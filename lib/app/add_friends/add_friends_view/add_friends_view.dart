import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/add_friends/add_friends_view_model/add_friends_view_model.dart';
import 'package:wager_app/app/global_widgets/animations.dart';
import 'package:wager_app/app/global_widgets/app_components.dart';
import 'package:wager_app/app/global_widgets/my_button.dart';
import 'package:wager_app/app/global_widgets/my_textfield.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

class AddFriendsView extends StatelessWidget {
  const AddFriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddFriendsViewModel>.reactive(
      viewModelBuilder: () => AddFriendsViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Friends'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.lg),
              child: IconPillButton(
                  icon: Icons.qr_code_rounded, onTap: () {}),
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(AppSpacing.screen, AppSpacing.sm,
                AppSpacing.screen, AppSpacing.xxxl),
            children: [
              // ---- Add a friend card ---------------------------------------
              FadeSlideIn(child: _addFriendCard(context, model)),
              const SizedBox(height: AppSpacing.xxl),

              // ---- Friends list --------------------------------------------
              StreamBuilder<QuerySnapshot>(
                stream: model.getFriendsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                          child:
                              CircularProgressIndicator(color: AppColors.ink)),
                    );
                  }
                  final friends = snapshot.data?.docs ?? [];
                  if (friends.isEmpty) return _emptyFriends();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Your friends', style: AppText.h2),
                          const SizedBox(width: 8),
                          AppBadge.soft('${friends.length}'),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ...List.generate(friends.length, (index) {
                        final data =
                            friends[index].data() as Map<String, dynamic>;
                        final username = (data['username'] as String?) ??
                            'Pending request';
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: FadeSlideIn.staggered(
                            index,
                            child: _friendTile(context, username, index),
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addFriendCard(BuildContext context, AddFriendsViewModel model) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PastelIconBadge(
                icon: Icons.person_add_alt_1_rounded,
                background: AppColors.lavender,
                foreground: AppColors.onLavender,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add a friend', style: AppText.h3),
                    Text('Search by username or scan a code',
                        style: AppText.caption, maxLines: 1),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          MyTextField(
            hintText: 'Enter username',
            obscureText: false,
            icon: Icons.alternate_email_rounded,
            controller: model.userNameController,
          ),
          const SizedBox(height: AppSpacing.md),
          MyButton(
            text: 'Send request',
            icon: Icons.send_rounded,
            onPressed: () => model.addFriend(context),
          ),
        ],
      ),
    );
  }

  Widget _friendTile(BuildContext context, String username, int index) {
    final chip = AppColors.chipForIndex(index);
    // Deterministic "online" flag just for visual variety.
    final online = index % 3 != 0;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: chip[0], shape: BoxShape.circle),
                child: Text(
                  username.isNotEmpty ? username[0].toUpperCase() : '?',
                  style: AppText.label.copyWith(color: chip[1], fontSize: 18),
                ),
              ),
              if (online)
                Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 2.5),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username,
                    style: AppText.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(online ? 'Online' : 'Offline',
                    style: AppText.caption.copyWith(
                        color: online
                            ? AppColors.success
                            : AppColors.textTertiary)),
              ],
            ),
          ),
          PressableScale(
            onTap: () => Navigator.pushNamed(context, '/friend-bet'),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                children: [
                  const Icon(Icons.sports_kabaddi_rounded,
                      color: AppColors.onInk, size: 15),
                  const SizedBox(width: 6),
                  Text('Challenge',
                      style: AppText.caption.copyWith(
                          color: AppColors.onInk,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyFriends() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Column(
          children: [
            FadeSlideIn(
              child: PastelIconBadge(
                icon: Icons.group_outlined,
                background: AppColors.mint,
                foreground: AppColors.onMint,
                size: 88,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('No friends yet', style: AppText.h1),
            const SizedBox(height: AppSpacing.sm),
            Text('Add someone by their username to get started.',
                style: AppText.bodyMuted, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
