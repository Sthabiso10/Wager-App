import 'package:flutter/material.dart';
import 'package:wager_app/app/profie/widgets/settings_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            // User info header (compact, non-overlapping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue.shade200,
                    child:
                        const Icon(Icons.person, size: 28, color: Colors.white),
                  ),
                  title: const Text('John Doe',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  subtitle: Text('john.doe@email.com',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700])),
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
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade100.withOpacity(0.18),
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
                        // TODO: Implement logout
                      },
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
