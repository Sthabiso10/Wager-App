import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/profie/view_model/profile_viewmodel.dart';
import 'package:wager_app/app/profie/widgets/profile_tile.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          top: true,
          left: true,
          right: true,
          bottom: true,
          minimum: const EdgeInsets.all(16),
          child: Column(
            children: [
              spacingHeight16,
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    // Positioned CircleAvatar in the center
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.red,
                            ),
                          ),
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            future: model.getUserName(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  "Loading...",
                                  style: TextStyle(
                                      color: colorText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  "Error: ${snapshot.error}",
                                  style: TextStyle(
                                      color: colorText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data?.data() != null) {
                                Map<String, dynamic>? data =
                                    snapshot.data!.data(); // Extract data map
                                String username = data?['username'] ??
                                    "No Username"; // Handle null
                                return Text(
                                  username,
                                  style: TextStyle(
                                      color: colorText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                );
                              } else {
                                return Text(
                                  "No data available",
                                  style: TextStyle(
                                      color: colorText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(
                            10.0), // Add padding to ensure it's not flush with the edges
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: colorAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 50,
                          child: Image.asset(
                            'assets/photo.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              spacingHeight16,
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              spacingHeight16,
              ProfileTile(
                model: model,
                title: 'Profile',
                onTap: () {
                  Navigator.pushNamed(context, '/profilePageView');
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ProfileTile(
                model: model,
                title: 'Settings',
                onTap: () {
                  Navigator.pushNamed(context, '/settingsPageView');
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ProfileTile(
                model: model,
                title: 'Terms & Conditions',
                onTap: () {
                  model.openTermsAndConditions(context);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              const SizedBox(
                height: 8,
              ),
              ProfileTile(
                model: model,
                title: 'Sign out',
                onTap: () {
                  model.logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
