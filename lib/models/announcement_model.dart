import 'package:flutter/material.dart';

/// One reply left under an [Announcement].
class AnnouncementReply {
  final String id;
  final String authorName;
  final Color authorColor;
  final String message;
  final DateTime createdAt;
  int likeCount;
  bool likedByMe;

  AnnouncementReply({
    required this.id,
    required this.authorName,
    required this.authorColor,
    required this.message,
    required this.createdAt,
    this.likeCount = 0,
    this.likedByMe = false,
  });
}

/// A post published in the "ANNONCES" feed, with its replies and reactions.
class Announcement {
  final String id;
  final String authorName;
  final Color authorColor;
  final String message;
  final DateTime createdAt;
  final bool verified;
  int likeCount;
  bool likedByMe;
  final List<AnnouncementReply> replies;

  Announcement({
    required this.id,
    required this.authorName,
    required this.authorColor,
    required this.message,
    required this.createdAt,
    this.verified = false,
    this.likeCount = 0,
    this.likedByMe = false,
    List<AnnouncementReply>? replies,
  }) : replies = replies ?? [];
}

/// Demo seed data shown when the feed is first opened.
List<Announcement> buildMockAnnouncements() {
  final now = DateTime.now();
  return [
    Announcement(
      id: 'a0',
      authorName: 'NOXE',
      authorColor: const Color(0xFFFFC72C),
      verified: true,
      message: '📌 Conseils pour mieux gagner avec NOXE\n\n'
          'Tu veux augmenter tes chances de gain ? Voici quelques règles simples à suivre 👇\n\n'
          '❌ Évite de combiner trop de matchs dans un seul coupon.\n'
          'Plus tu ajoutes de matchs, plus le risque augmente.',
      createdAt: now.subtract(const Duration(days: 1)),
      likeCount: 214,
      replies: [
        AnnouncementReply(
          id: 'a0-r1',
          authorName: 'CleverPanda21',
          authorColor: const Color(0xFF42A5F5),
          message: 'Merci pour le conseil, ça aide vraiment 🙏',
          createdAt: now.subtract(const Duration(hours: 20)),
          likeCount: 6,
        ),
      ],
    ),
  ];
}
