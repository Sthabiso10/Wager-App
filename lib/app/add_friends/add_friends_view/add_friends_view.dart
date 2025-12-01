import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:wager_app/app/add_friends/add_friends_view_model/add_friends_view_model.dart';
import 'package:wager_app/app/add_friends/widgets/exercise_search_field.dart';
import 'package:wager_app/app/global_widgets/my_button.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';

class AddFriendsView extends StatelessWidget {
  const AddFriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddFriendsViewModel>.reactive(
        viewModelBuilder: () => AddFriendsViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: colorText,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Friends',
                          style: TextStyle(
                              color: colorText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colorAccent,
                            ),
                            child: Icon(
                              Icons.qr_code_scanner_rounded,
                              color: colorText,
                              size: 25,
                            )),
                      ],
                    ),
                    spacingHeight16,
                    Text(
                        'Add friends by searching for their username or scanning thier code.',
                        style: TextStyle(color: colorText, fontSize: 16)),
                    spacingHeight16,
                    AddFriendsSearchField(
                        hintText: 'Enter Username',
                        controller: model.userNameController),
                    spacingHeight16,
                    MyButton(
                        text: "Add Friend",
                        isGlass: false,
                        isGradient: true,
                        onPressed: () {
                          model.addFriend(context);
                        }),
                    spacingHeight16,
                    Row(
                      children: [
                        Text(
                          'My Friends List',
                          style: TextStyle(
                              color: colorText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    spacingHeight16,
                    StreamBuilder<QuerySnapshot>(
                      stream: model.getFriendsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                              child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'No friends have been added.',
                                style:
                                    TextStyle(color: colorText, fontSize: 16),
                              ),
                              Image.asset('assets/crowd.png')
                            ],
                          ));
                        }

                        final friends = snapshot.data!.docs;

                        return Expanded(
                          child: ListView.builder(
                            itemCount: friends.length,
                            itemBuilder: (context, index) {
                              final friendData =
                                  friends[index].data() as Map<String, dynamic>;

                              // Access the 'username' field you saved in the friends collection
                              final friendUsername =
                                  friendData['username'] ?? 'Pending Request';

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: colorText,
                                    ),
                                    title: Text(
                                      friendUsername,
                                      style: TextStyle(
                                          color: colorText, fontSize: 16),
                                    ), // Display the friend's username
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ));
  }
}
