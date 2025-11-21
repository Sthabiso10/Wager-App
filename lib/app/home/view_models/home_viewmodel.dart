import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/models/bet_model.dart';
import 'package:wager_app/app/home/views/edit_bet_page.dart';

import 'package:wager_app/app/settings/views/settings_view.dart';

class HomeViewModel extends BaseViewModel {
  User? get currentUser => FirebaseAuth.instance.currentUser;

  final List<Bet> dummyBet = [
    Bet(
      date: DateTime.now(),
      title: 'Basketball Match Bet',
      description: 'Bet on the outcome of the basketball match.',
      amount: 30.0,
    ),
    Bet(
      date: DateTime.now(),
      title: 'Soccer Match Bet',
      description: 'Bet on the outcome of the soccer match.',
      amount: 20.0,
    ),
    Bet(
      date: DateTime.now(),
      title: 'Tennis Match Bet',
      description: 'Bet on the outcome of the tennis match.',
      amount: 50.0,
    ),
  ];

  List betData = [
    [
      'UCL Winner',
      'Daniel says Arsenal will win the chanmpions league and Ethan does not',
      '200',
    ],
    [
      'Best out of 3',
      'Ethab says he will have more than 2',
      '50',
    ],
  ];

  void openSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const SettingsPage()));
  }

  void addNewBet(List<String> newBet) {
    betData.add(newBet);
  }

  void editBet(String betTiTle, String betDescription, String betAmount,
      BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => EditBetPage(
          betTitle: betTiTle,
          betDescription: betDescription,
          betAmount: betAmount,
        ),
      ),
    );
  }

  Map<String, dynamic>? userData;

  Future<void> loadUserData() async {
    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .get();

    userData = doc.data();
    notifyListeners();
  }

  DateTime betDate = DateTime.now();
}
