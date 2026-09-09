import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../theme/app_theme.dart';

/// Bottom sheet used to publish a new post to the "ANNONCES" feed.
class ComposeAnnouncementSheet extends StatefulWidget {
  const ComposeAnnouncementSheet({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ComposeAnnouncementSheet(),
    );
  }

  @override
  State<ComposeAnnouncementSheet> createState() => _ComposeAnnouncementSheetState();
}

class _ComposeAnnouncementSheetState extends State<ComposeAnnouncementSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _publish() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textGrey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(tr('compose_title'), style: AppTextStyles.screenTitle.copyWith(fontSize: 17)),
            const SizedBox(height: 14),
            TextField(
              controller: _controller,
              autofocus: true,
              maxLines: 4,
              maxLength: 500,
              style: AppTextStyles.chip.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
              decoration: InputDecoration(
                hintText: tr('compose_hint'),
                hintStyle: AppTextStyles.chip.copyWith(color: AppColors.textGrey),
                filled: true,
                fillColor: AppColors.screenBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _publish,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(tr('compose_submit'), style: AppTextStyles.leagueName.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
