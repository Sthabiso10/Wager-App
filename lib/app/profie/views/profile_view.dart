import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/profie/view_model/profile_viewmodel.dart';
import 'package:wager_app/app/profie/views/settings_view.dart';
import 'package:wager_app/styles/colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (model) {
        model.loadUserData();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            // Header with curved bottom
            ClipPath(
              clipper: _HeaderClipper(),
              child: Container(
                height: 220,
                decoration: BoxDecoration(color: colorAccent),
              ),
            ),
            // Main content
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  // Animated Avatar with Glow and Badge
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.8, end: 1.1),
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorAccent,
                                      blurRadius: 32,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          onEnd: () {},
                        ),
                        Material(
                          elevation: 8,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person,
                                size: 70, color: colorAccent),
                          ),
                        ),
                        // Badge/accent (e.g., crown/star)
                        Positioned(
                          bottom: 12,
                          right: 18,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(Icons.star,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Glassmorphism Profile Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.5), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade100.withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        // For a true glass effect, use BackdropFilter in a Stack (see comment below)
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 28, horizontal: 18),
                            child: Column(
                              children: [
                                Text(
                                  'Hello, ${model.userData?["username"] ?? 'loading...'}!',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: colorText),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  model.userData?["email"] ?? 'loading...',
                                  style:
                                      TextStyle(fontSize: 15, color: colorText),
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const _ProfileStat(
                                      title: 'Events',
                                      value: '12',
                                    ),
                                    Container(
                                        width: 1,
                                        height: 28,
                                        color: Colors.grey[300]),
                                    const _ProfileStat(
                                        title: 'Friends', value: '34'),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                SizedBox(
                                  width: 150,
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      size: 18,
                                      color: colorText,
                                    ),
                                    label: Text(
                                      'Edit Profile',
                                      style: TextStyle(color: colorText),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Custom Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ProfileActionButton(
                          icon: Icons.settings,
                          label: 'Settings',
                          color: Colors.blue.shade400,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsView()),
                            );
                          },
                        ),
                        _ProfileActionButton(
                          icon: Icons.lock,
                          label: 'Password',
                          color: Colors.orange.shade400,
                          onTap: () {},
                        ),
                        _ProfileActionButton(
                          icon: Icons.logout,
                          label: 'Logout',
                          color: Colors.red.shade400,
                          onTap: () async {
                            final shouldLogout = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Logout'),
                                content: const Text(
                                    'Are you sure you want to logout?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Logout'),
                                  ),
                                ],
                              ),
                            );
                            if (shouldLogout == true) {
                              // TODO: Implement logout logic
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Creative header clipper for curved effect
class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Profile stat widget (unchanged)
class _ProfileStat extends StatelessWidget {
  final String title;
  final String value;
  const _ProfileStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: colorAccent),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: colorText),
          ),
        ],
      ),
    );
  }
}

// Custom action button for profile actions
class _ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ProfileActionButton(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: TextStyle(
                fontSize: 13, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
