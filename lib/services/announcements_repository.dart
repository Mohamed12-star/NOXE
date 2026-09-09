import 'package:flutter/material.dart';

import '../auth/auth_controller.dart';
import '../auth/user_role.dart';
import '../models/announcement_model.dart';

/// Read/write access to the "ANNONCES" feed.
///
/// [InMemoryAnnouncementsRepository] is the only implementation for now.
/// When the app moves to Firebase, add a `FirestoreAnnouncementsRepository`
/// implementing this same contract (backed by a Firestore collection
/// listener instead of a local list) and swap it in at the call site in
/// [AnnouncementsScreen] — the UI doesn't need to change.
abstract class AnnouncementsRepository extends ChangeNotifier {
  List<Announcement> get announcements;

  void publish({required String authorName, required String message});

  void reply({
    required String announcementId,
    required String authorName,
    required String message,
  });

  void toggleLike(String announcementId);

  void toggleReplyLike(String announcementId, String replyId);
}

class InMemoryAnnouncementsRepository extends AnnouncementsRepository {
  final List<Announcement> _announcements = buildMockAnnouncements();
  int _nextId = 1000;

  @override
  List<Announcement> get announcements =>
      List.unmodifiable(_announcements.reversed);

  @override
  void publish({required String authorName, required String message}) {
    if (authController.role != UserRole.admin) return;
    final trimmed = message.trim();
    if (trimmed.isEmpty) return;
    _announcements.add(
      Announcement(
        id: 'a${_nextId++}',
        authorName: authorName,
        authorColor: _colorFor(authorName),
        message: trimmed,
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  @override
  void reply({
    required String announcementId,
    required String authorName,
    required String message,
  }) {
    final trimmed = message.trim();
    if (trimmed.isEmpty) return;
    final announcement = _announcements.firstWhere((a) => a.id == announcementId);
    announcement.replies.add(
      AnnouncementReply(
        id: 'r${_nextId++}',
        authorName: authorName,
        authorColor: _colorFor(authorName),
        message: trimmed,
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  @override
  void toggleLike(String announcementId) {
    final announcement = _announcements.firstWhere((a) => a.id == announcementId);
    announcement.likedByMe = !announcement.likedByMe;
    announcement.likeCount += announcement.likedByMe ? 1 : -1;
    notifyListeners();
  }

  @override
  void toggleReplyLike(String announcementId, String replyId) {
    final announcement = _announcements.firstWhere((a) => a.id == announcementId);
    final reply = announcement.replies.firstWhere((r) => r.id == replyId);
    reply.likedByMe = !reply.likedByMe;
    reply.likeCount += reply.likedByMe ? 1 : -1;
    notifyListeners();
  }

  static const List<Color> _palette = [
    Color(0xFF2ECE89),
    Color(0xFFFFA726),
    Color(0xFF8E24AA),
    Color(0xFF42A5F5),
    Color(0xFFEF5350),
  ];

  Color _colorFor(String name) => _palette[name.hashCode.abs() % _palette.length];
}
