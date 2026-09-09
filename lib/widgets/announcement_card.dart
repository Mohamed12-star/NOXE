import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../models/announcement_model.dart';
import '../theme/social_feed_theme.dart';

String _relativeTime(DateTime time) {
  final diff = DateTime.now().difference(time);
  if (diff.inMinutes < 1) return tr('time_now');
  if (diff.inMinutes < 60) return tr('time_minutes', {'n': '${diff.inMinutes}'});
  if (diff.inHours < 24) return tr('time_hours', {'n': '${diff.inHours}'});
  return tr('time_days', {'n': '${diff.inDays}'});
}

class _Avatar extends StatelessWidget {
  final String name;
  final Color color;
  static const double size = 44;

  const _Avatar({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        name.isEmpty ? '?' : name[0].toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: size * 0.42,
        ),
      ),
    );
  }
}

class _ReactionButton extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool active;
  final int count;
  final VoidCallback onTap;

  const _ReactionButton({
    required this.icon,
    required this.activeIcon,
    required this.active,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? SocialFeedColors.like : SocialFeedColors.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(active ? activeIcon : icon, size: 20, color: color),
            const SizedBox(width: 7),
            Text(
              '$count',
              style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

/// One post in the "ANNONCES" feed: message, reactions, and its reply thread.
class AnnouncementCard extends StatefulWidget {
  final Announcement announcement;
  final ValueChanged<String> onToggleLike;

  /// Called with the reply's id (the announcement id is already known here).
  final ValueChanged<String> onToggleReplyLike;
  final void Function(String message) onReply;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    required this.onToggleLike,
    required this.onToggleReplyLike,
    required this.onReply,
  });

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  bool _repliesExpanded = false;
  final _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _submitReply() {
    if (_replyController.text.trim().isEmpty) return;
    widget.onReply(_replyController.text);
    _replyController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final announcement = widget.announcement;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: SocialFeedColors.card,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Avatar(name: announcement.authorName, color: announcement.authorColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                announcement.authorName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: SocialFeedColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            if (announcement.verified) ...[
                              const SizedBox(width: 6),
                              const Icon(Icons.verified_rounded,
                                  color: SocialFeedColors.header, size: 16),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _relativeTime(announcement.createdAt),
                          style: const TextStyle(
                            color: SocialFeedColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                announcement.message,
                style: const TextStyle(
                  color: SocialFeedColors.textPrimary,
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14),
              const Divider(height: 1, color: SocialFeedColors.divider),
              const SizedBox(height: 8),
              Row(
                children: [
                  _ReactionButton(
                    icon: Icons.favorite_border_rounded,
                    activeIcon: Icons.favorite_rounded,
                    active: announcement.likedByMe,
                    count: announcement.likeCount,
                    onTap: () => widget.onToggleLike(announcement.id),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () => setState(() => _repliesExpanded = !_repliesExpanded),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.chat_bubble_outline_rounded,
                              size: 19, color: SocialFeedColors.textSecondary),
                          const SizedBox(width: 7),
                          Text(
                            '${announcement.replies.length}',
                            style: const TextStyle(
                              color: SocialFeedColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_repliesExpanded) ...[
          const SizedBox(height: 10),
          for (final reply in announcement.replies) ...[
            _ReplyTile(
              reply: reply,
              onToggleLike: () => widget.onToggleReplyLike(reply.id),
            ),
            const SizedBox(height: 10),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _replyController,
                    style: const TextStyle(color: SocialFeedColors.textPrimary, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: tr('announcement_replyHint'),
                      hintStyle: const TextStyle(color: SocialFeedColors.textSecondary),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      filled: true,
                      fillColor: SocialFeedColors.commentBubble,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _submitReply(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _submitReply,
                  icon: const Icon(Icons.send_rounded, color: SocialFeedColors.header),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _ReplyTile extends StatelessWidget {
  final AnnouncementReply reply;
  final VoidCallback onToggleLike;

  const _ReplyTile({required this.reply, required this.onToggleLike});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: SocialFeedColors.commentBubble,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                reply.authorName,
                style: const TextStyle(
                  color: SocialFeedColors.header,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _relativeTime(reply.createdAt),
                style: const TextStyle(color: SocialFeedColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            reply.message,
            style: const TextStyle(color: SocialFeedColors.textPrimary, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 6),
          _ReactionButton(
            icon: Icons.favorite_border_rounded,
            activeIcon: Icons.favorite_rounded,
            active: reply.likedByMe,
            count: reply.likeCount,
            onTap: onToggleLike,
          ),
        ],
      ),
    );
  }
}
