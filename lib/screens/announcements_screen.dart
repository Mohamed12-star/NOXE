import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/auth_controller.dart';
import '../auth/user_role.dart';
import '../l10n/locale_controller.dart';
import '../services/announcements_repository.dart';
import '../theme/social_feed_theme.dart';
import '../widgets/announcement_card.dart';
import '../widgets/compose_announcement_sheet.dart';

/// "ANNONCES" tab: a community feed where users publish posts that others
/// can reply to and react to.
class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final AnnouncementsRepository _repository = InMemoryAnnouncementsRepository();

  String get _currentUserName =>
      authController.currentUser?.displayName ?? tr('profile_name');

  Future<void> _openComposer() async {
    final message = await ComposeAnnouncementSheet.show(context);
    if (message != null) {
      _repository.publish(authorName: _currentUserName, message: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SocialFeedColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const _SocialFeedHeader(),
            Expanded(
              child: ListenableBuilder(
                listenable: _repository,
                builder: (context, _) {
                  final announcements = _repository.announcements;
                  return CustomScrollView(
                    slivers: [
                      if (authController.role == UserRole.admin)
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          sliver: SliverToBoxAdapter(
                            child: ElevatedButton.icon(
                              onPressed: _openComposer,
                              icon: const Icon(Icons.add_rounded),
                              label: Text(tr('announcements_publish')),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: SocialFeedColors.header,
                                foregroundColor: SocialFeedColors.onHeader,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                textStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (announcements.isEmpty)
                        const SliverFillRemaining(
                          hasScrollBody: false,
                          child: _EmptyState(),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                          sliver: SliverList.separated(
                            itemCount: announcements.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 14),
                            itemBuilder: (context, index) {
                              final announcement = announcements[index];
                              return AnnouncementCard(
                                announcement: announcement,
                                onToggleLike: _repository.toggleLike,
                                onToggleReplyLike: (replyId) =>
                                    _repository.toggleReplyLike(announcement.id, replyId),
                                onReply: (message) => _repository.reply(
                                  announcementId: announcement.id,
                                  authorName: _currentUserName,
                                  message: message,
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Gold title bar matching the reference "Social Feed" design.
class _SocialFeedHeader extends StatelessWidget {
  const _SocialFeedHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: SocialFeedColors.header,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(
        tr('announcements_header'),
        style: GoogleFonts.poppins(
          color: SocialFeedColors.onHeader,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          tr('announcements_empty'),
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: SocialFeedColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
