import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:wager_app/helper_functions/helper_functions.dart';
import 'package:wager_app/styles/colors.dart';

class AddFriendsViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController userNameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFriend(BuildContext context) async {
    final friendUsername = userNameController.text.trim();

    if (friendUsername.isEmpty) {
      newEventSnackBar('Please enter a username', context, errorColor);
      return;
    }

    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      newEventSnackBar('User is not signed in', context, errorColor);
      return;
    }

    final currentUserEmail = currentUser.email!;
    final currentUserDoc =
        await _firestore.collection('Users').doc(currentUserEmail).get();
    final currentUsername = currentUserDoc.data()?['username'];

    if (friendUsername == currentUsername) {
      if (context.mounted) {
        newEventSnackBar('You cannot add yourself', context, errorColor);
      }
      return;
    }

    final friendSnapshot = await _firestore
        .collection('Users')
        .where('username', isEqualTo: friendUsername)
        .limit(1)
        .get();

    if (friendSnapshot.docs.isEmpty) {
      if (context.mounted) {
        newEventSnackBar('User not found', context, errorColor);
      }
      return;
    }

    final friendDoc = friendSnapshot.docs.first;
    final friendEmail = friendDoc.id;

    // Check if already friends
    final existingFriendship =
        await _checkExistingFriendship(currentUserEmail, friendEmail);
    if (existingFriendship != null) {
      if (context.mounted) {
        newEventSnackBar(existingFriendship, context, errorColor);
      }
      return;
    }

    // Check existing request
    final existingRequest =
        await _checkExistingRequest(currentUserEmail, friendEmail);
    if (existingRequest != null) {
      if (context.mounted) {
        newEventSnackBar(existingRequest, context, errorColor);
      }
      return;
    }

    // Send friend request (friends docs are only created on accept)
    await _sendFriendRequest(
        currentUserEmail, friendEmail, friendUsername, currentUsername);

    if (context.mounted) {
      newEventSnackBar('Friend request sent', context, successColor);
    }
  }

  Future<String?> _checkExistingFriendship(
      String currentUserEmail, String friendEmail) async {
    final friendDoc = await _firestore
        .collection('Users')
        .doc(currentUserEmail)
        .collection('friends')
        .doc(friendEmail)
        .get();

    if (friendDoc.exists) {
      return 'You are already friends with this user';
    }
    return null;
  }

  Future<String?> _checkExistingRequest(
      String currentUserEmail, String friendEmail) async {
    final existingRequest = await _firestore
        .collection('Notifications')
        .doc(friendEmail)
        .collection('Requests')
        .where('from', isEqualTo: currentUserEmail)
        .where('status', isEqualTo: 'pending')
        .limit(1)
        .get();

    if (existingRequest.docs.isNotEmpty) {
      return 'Friend request already pending';
    }

    return null;
  }

  Future<void> _sendFriendRequest(String currentUserEmail, String friendEmail,
      String friendUsername, String? currentUsername) async {
    final requestDocRef = _firestore
        .collection('Notifications')
        .doc(friendEmail)
        .collection('Requests')
        .doc();

    await requestDocRef.set({
      'from': currentUserEmail, // sender email
      'fromUsername': currentUsername ?? currentUserEmail, // sender username
      'to': friendEmail, // recipient email
      'toUsername': friendUsername, // recipient username
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> acceptFriendRequest(String requestId, String fromUser) async {
    final currentUser = _auth.currentUser!;
    final currentUserEmail = currentUser.email!;

    final batch = _firestore.batch();

    // Update request status
    final requestRef = _firestore
        .collection('Notifications')
        .doc(currentUserEmail)
        .collection('Requests')
        .doc(requestId);

    batch.update(requestRef, {'status': 'accepted'});

    // Add both users to each other's friends list
    final timestamp = FieldValue.serverTimestamp();

    // Add the friend to the current user's friends list
    batch.set(
      _firestore
          .collection('Users')
          .doc(currentUserEmail) // Current user's document
          .collection('friends')
          .doc(fromUser), // Friend's email as document ID
      {'userId': fromUser, 'since': timestamp},
    );

    // Add the current user to the friend's friends list
    batch.set(
      _firestore
          .collection('Users')
          .doc(fromUser) // Friend's document
          .collection('friends')
          .doc(currentUserEmail), // Current user's email as document ID
      {'userId': currentUserEmail, 'since': timestamp},
    );

    // Commit the batch
    await batch.commit();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot> getFriendsStream() {
    final currentUser = _auth.currentUser;
    return currentUser != null
        ? _firestore
            .collection('Users')
            .doc(currentUser.email)
            .collection('friends')
            .snapshots()
        : const Stream.empty();
  }
}
