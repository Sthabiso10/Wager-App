import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/inbox/view_model/inbox_view_model.dart';
import 'package:wager_app/app/inbox/widgets/action_row_strip.dart';
import 'package:wager_app/app/inbox/widgets/inbox_search_field.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';

class InboxView extends StatelessWidget {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InboxViewModel>.reactive(
      viewModelBuilder: () => InboxViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_outlined, color: colorText),
          ),
          title: Text(
            'Notifications',
            style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.settings, color: colorText),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              InboxSearchField(
                hintText: 'Search',
                controller: model.searchController,
              ),
              spacingHeight16,
              const ActionButtonStrip(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: model.getFriendRequests(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error loading friend requests',
                          style: TextStyle(color: errorColor, fontSize: 16),
                        ),
                      );
                    }

                    final requests = snapshot.data?.docs ?? [];

                    if (requests.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No friend requests found.',
                              style: TextStyle(
                                color: colorText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            spacingHeight16,
                            Image.asset(
                              'assets/crowd.png',
                              height: 100,
                              color: colorText,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        final requestData =
                            request.data() as Map<String, dynamic>?;

                        if (requestData == null) {
                          return const SizedBox.shrink(); // Skip invalid data
                        }

                        // Support both new and legacy payloads
                        final String? fromEmail =
                            requestData['from'] as String?; // new schema
                        final String? fromUsernameNew =
                            requestData['fromUsername']
                                as String?; // new schema
                        final String? legacyUsername =
                            requestData['username'] as String?; // legacy

                        final String displayName = fromUsernameNew ??
                            legacyUsername ??
                            fromEmail ??
                            'Unknown User';

                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const CircleAvatar(radius: 30),
                                spacingWidth16,
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: displayName,
                                          style: TextStyle(
                                            color: colorText,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' wants to be friends',
                                          style: TextStyle(
                                            color: colorText,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (fromEmail != null) {
                                          model.respondToFriendRequest(
                                              request.id,
                                              fromEmail,
                                              'reject',
                                              context);
                                        } else if (legacyUsername != null) {
                                          model
                                              .respondToFriendRequestByUsername(
                                                  request.id,
                                                  legacyUsername,
                                                  'reject',
                                                  context);
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: errorColor,
                                        ),
                                        child:
                                            Icon(Icons.close, color: colorText),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        if (fromEmail != null) {
                                          model.respondToFriendRequest(
                                              request.id,
                                              fromEmail,
                                              'accept',
                                              context);
                                        } else if (legacyUsername != null) {
                                          model
                                              .respondToFriendRequestByUsername(
                                                  request.id,
                                                  legacyUsername,
                                                  'accept',
                                                  context);
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: colorAccent,
                                        ),
                                        child:
                                            Icon(Icons.check, color: colorText),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
