import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/animations.dart';
import 'package:wager_app/app/global_widgets/app_components.dart';
import 'package:wager_app/app/global_widgets/app_feedback.dart';
import 'package:wager_app/app/inbox/view_model/inbox_view_model.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

class InboxView extends StatelessWidget {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InboxViewModel>.reactive(
      viewModelBuilder: () => InboxViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Notifications'),
          actions: [
            TextButton(
              onPressed: () => AppToast.success(context, 'All caught up!'),
              child: Text('Mark read',
                  style: AppText.label.copyWith(color: AppColors.accentText)),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: model.getFriendRequests(),
          builder: (context, snapshot) {
            final requests = snapshot.data?.docs ?? [];
            final loading =
                snapshot.connectionState == ConnectionState.waiting;

            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(AppSpacing.screen,
                  AppSpacing.lg, AppSpacing.screen, AppSpacing.xxxl),
              children: [
                // ---- Friend requests --------------------------------------
                if (loading)
                  const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Center(
                        child:
                            CircularProgressIndicator(color: AppColors.ink)),
                  )
                else if (requests.isNotEmpty) ...[
                  FadeSlideIn(
                    child: _sectionRow('Friend requests', requests.length),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ...List.generate(requests.length, (index) {
                    final request = requests[index];
                    final data = request.data() as Map<String, dynamic>?;
                    if (data == null) return const SizedBox.shrink();

                    final String? fromEmail = data['from'] as String?;
                    final String? fromUsernameNew =
                        data['fromUsername'] as String?;
                    final String? legacyUsername = data['username'] as String?;
                    final displayName = fromUsernameNew ??
                        legacyUsername ??
                        fromEmail ??
                        'Unknown user';

                    void respond(String action) {
                      if (fromEmail != null) {
                        model.respondToFriendRequest(
                            request.id, fromEmail, action, context);
                      } else if (legacyUsername != null) {
                        model.respondToFriendRequestByUsername(
                            request.id, legacyUsername, action, context);
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FadeSlideIn.staggered(
                        index,
                        child: _RequestCard(
                          displayName: displayName,
                          chipIndex: index,
                          onAccept: () => respond('accept'),
                          onReject: () => respond('reject'),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: AppSpacing.xl),
                ],

                // ---- Activity feed ----------------------------------------
                FadeSlideIn(
                  delay: const Duration(milliseconds: 120),
                  child: Text('Earlier', style: AppText.overline),
                ),
                const SizedBox(height: AppSpacing.md),
                ..._activity.asMap().entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FadeSlideIn.staggered(
                      e.key,
                      step: const Duration(milliseconds: 55),
                      child: _ActivityTile(item: e.value),
                    ),
                  );
                }),

                if (!loading && requests.isEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  _hint(),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _sectionRow(String title, int count) {
    return Row(
      children: [
        Text(title, style: AppText.h2),
        const SizedBox(width: 8),
        AppBadge(label: '$count'),
      ],
    );
  }

  Widget _hint() {
    return Center(
      child: Column(
        children: [
          PastelIconBadge(
            icon: Icons.notifications_none_rounded,
            background: AppColors.sky,
            foreground: AppColors.onSky,
            size: 72,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('No new requests', style: AppText.h3),
          const SizedBox(height: 4),
          Text('New friend requests will appear at the top.',
              style: AppText.caption, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // Sample activity feed (illustrative until wired to real events).
  static const List<_Activity> _activity = [
    _Activity(
      icon: Icons.emoji_events_rounded,
      title: 'You won R50',
      subtitle: 'Weekend 5km challenge vs Sarah',
      time: '2h ago',
      kind: _ActKind.win,
      unread: true,
    ),
    _Activity(
      icon: Icons.bolt_rounded,
      title: 'Luka accepted your quick bet',
      subtitle: 'Barcelona will win La Liga · R30',
      time: '5h ago',
      kind: _ActKind.accept,
      unread: true,
    ),
    _Activity(
      icon: Icons.timer_outlined,
      title: 'A wager is ending soon',
      subtitle: 'Lakers championship bet ends tomorrow',
      time: 'Yesterday',
      kind: _ActKind.reminder,
      unread: false,
    ),
    _Activity(
      icon: Icons.person_add_alt_1_rounded,
      title: 'Maria is now your friend',
      subtitle: 'Say hi and start a wager',
      time: '2d ago',
      kind: _ActKind.social,
      unread: false,
    ),
  ];
}

enum _ActKind { win, accept, reminder, social }

class _Activity {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final _ActKind kind;
  final bool unread;

  const _Activity({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.kind,
    required this.unread,
  });

  List<Color> get chip {
    switch (kind) {
      case _ActKind.win:
        return [AppColors.mint, AppColors.onMint];
      case _ActKind.accept:
        return [AppColors.sky, AppColors.onSky];
      case _ActKind.reminder:
        return [AppColors.amber, AppColors.onAmber];
      case _ActKind.social:
        return [AppColors.lavender, AppColors.onLavender];
    }
  }
}

class _ActivityTile extends StatelessWidget {
  final _Activity item;
  const _ActivityTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PastelIconBadge(
              icon: item.icon,
              background: item.chip[0],
              foreground: item.chip[1]),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(item.title, style: AppText.label)),
                    Text(item.time, style: AppText.caption),
                  ],
                ),
                const SizedBox(height: 2),
                Text(item.subtitle,
                    style: AppText.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          if (item.unread) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                  color: AppColors.accent, shape: BoxShape.circle),
            ),
          ],
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String displayName;
  final int chipIndex;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _RequestCard({
    required this.displayName,
    required this.chipIndex,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final chip = AppColors.chipForIndex(chipIndex);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [chip[0].withValues(alpha: 0.6), AppColors.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: chip[0], shape: BoxShape.circle),
            child: Text(
              displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
              style: AppText.label.copyWith(color: chip[1], fontSize: 18),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName,
                    style: AppText.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text('Wants to be friends', style: AppText.caption),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          _circleButton(
              icon: Icons.close_rounded,
              bg: AppColors.surface,
              fg: AppColors.textSecondary,
              border: true,
              onTap: onReject),
          const SizedBox(width: 8),
          _circleButton(
              icon: Icons.check_rounded,
              bg: AppColors.ink,
              fg: AppColors.onInk,
              onTap: onAccept),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required Color bg,
    required Color fg,
    required VoidCallback onTap,
    bool border = false,
  }) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: border ? Border.all(color: AppColors.border) : null,
        ),
        child: Icon(icon, color: fg, size: 20),
      ),
    );
  }
}
