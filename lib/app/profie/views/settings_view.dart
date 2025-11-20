import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/profie/view_model/profile_viewmodel.dart';
import 'package:wager_app/app/profie/widgets/settings_tile.dart';
import 'package:wager_app/styles/colors.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (model) {
          model.loadUserData();
        },
        builder: (context, model, chid) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                title: Text(
                  'Settings',
                  style: TextStyle(color: colorText),
                ),
                leading: IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios_new_rounded, color: colorText),
                  onPressed: () => Navigator.pop(context),
                ),
                backgroundColor: backgroundColor,
                elevation: 0,
              ),
              extendBodyBehindAppBar: false,
              body: Column(
                children: [
                  // User info header (compact, non-overlapping)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Card(
                      color: containerColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: colorAccent,
                          child: const Icon(Icons.person,
                              size: 28, color: Colors.white),
                        ),
                        title: Text(model.userData?["username"] ?? "loading...",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorText)),
                        subtitle: Text(model.userData?["email"] ?? "loading...",
                            style: TextStyle(fontSize: 13, color: colorText)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Animated settings list
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade100.withAlpha(46),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          SettingsTile(
                            icon: Icons.notifications,
                            title: 'Notifications',
                            onTap: () {},
                          ),
                          const SizedBox(height: 8),
                          SettingsTile(
                            icon: Icons.lock,
                            title: 'Privacy',
                            onTap: () {},
                          ),
                          const SizedBox(height: 8),
                          SettingsTile(
                            icon: Icons.color_lens,
                            title: 'Theme',
                            onTap: () {},
                          ),
                          const SizedBox(height: 8),
                          SettingsTile(
                            icon: Icons.info,
                            title: 'About',
                            onTap: () {},
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          SettingsTile(
                            icon: Icons.logout,
                            title: 'Logout',
                            onTap: () {
                              if (!context.mounted) return;
                              model.logout(context);
                            },
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ));
  }
}
