import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/helper_functions/helper_functions.dart';
import 'package:wager_app/styles/colors.dart';

class InboxViewModel extends BaseViewModel {
  final TextEditingController searchController = TextEditingController();

  String selectedButton = 'All';

  void selectButton(String button) {
    selectedButton = button;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getFriendRequests() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }

    // Updated path to reflect the correct structure, assuming you renamed or restructured.
    return _firestore
        .collection(
            'Notifications') // Assuming this is where requests are stored.
        .doc(currentUser.email)
        .collection('Requests')
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  Future<void> respondToFriendRequest(
    String requestId,
    String fromUserEmail,
    String action,
    BuildContext context,
  ) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final currentUserEmail = currentUser.email!;
    final batch = _firestore.batch();

    final fromUserRef = _firestore.collection('Users').doc(fromUserEmail);
    final currentUserRef = _firestore.collection('Users').doc(currentUserEmail);
    final friendRequestRef = _firestore
        .collection(
            'Notifications') // Ensure correct path to notifications collection
        .doc(currentUserEmail)
        .collection('Requests')
        .doc(requestId); // Correct path to request document

    try {
      if (action == 'accept') {
        final fromUserSnapshot = await fromUserRef.get();
        final fromUsername =
            fromUserSnapshot.data()?['username'] ?? fromUserEmail;
        final currentUserUsername = currentUser.displayName ?? currentUserEmail;

        // Add the usernames of both users to each other's friends collection only once
        batch.set(
          currentUserRef.collection('friends').doc(fromUserEmail),
          {'username': fromUsername},
        );
        batch.set(
          fromUserRef.collection('friends').doc(currentUserEmail),
          {'username': currentUserUsername},
        );
      }

      // Delete the friend request after responding
      batch.delete(friendRequestRef);

      // Commit the batch to make the changes
      await batch.commit();

      // Show the appropriate message to the user
      newEventSnackBar(
        action == 'accept'
            ? 'Friend Request Accepted'
            : 'Friend Request Rejected',
        context,
        action == 'accept' ? colorAccent : errorColor,
      );
    } catch (e) {
      // Handle any errors that might occur during the batch operation
      print('Error responding to friend request: $e');
      newEventSnackBar(
        'Something went wrong. Please try again.',
        context,
        errorColor,
      );
    }
  }

  Future<String?> resolveEmailByUsername(String username) async {
    try {
      final query = await _firestore
          .collection('Users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();
      if (query.docs.isEmpty) return null;
      return query.docs.first.id; // document ID is the user's email
    } catch (_) {
      return null;
    }
  }

  Future<void> respondToFriendRequestByUsername(
    String requestId,
    String fromUsername,
    String action,
    BuildContext context,
  ) async {
    final email = await resolveEmailByUsername(fromUsername);
    if (email == null) {
      newEventSnackBar(
          'Could not find sender for this request.', context, errorColor);
      return;
    }
    await respondToFriendRequest(requestId, email, action, context);
  }

  // If you need a username from the sender to be displayed
  Future<String> getSenderUsername(String email) async {
    final userDoc = await _firestore.collection('Users').doc(email).get();
    return userDoc.data()?['username'] ?? email;
  }
}
