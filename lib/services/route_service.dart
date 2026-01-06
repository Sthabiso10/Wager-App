import 'package:flutter/material.dart';
import 'package:wager_app/app/add_friends/add_friends_view/add_friends_view.dart';
import 'package:wager_app/app/create_bet/views';
import 'package:wager_app/app/inbox/views/inbox_view.dart';
import 'package:wager_app/app/navigation%20bar/views/navigation_view.dart';
import 'package:wager_app/app/profie/views/profile_view.dart';
import 'package:wager_app/auth/auth.dart';
import '../app/home/views/home_view.dart';

class RouteService {
  static const String homeView = '/home';
  static const String profileView = '/profile';
  static const String navigationMenu = '/naviagtion';
  static const String inbox = '/inbox';
  static const String authPage = '/auth';
  static const String friendsView = '/friends';
  static const String createBet = '/createBet';

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeView:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case profileView:
        return MaterialPageRoute(builder: (context) => const ProfileView());
      case navigationMenu:
        return MaterialPageRoute(builder: (context) => NavigationMenu());
      case authPage:
        return MaterialPageRoute(builder: (context) => const AuthPage());
      case inbox:
        return MaterialPageRoute(builder: (context) => const InboxView());
      case friendsView:
        return MaterialPageRoute(builder: (context) => const AddFriendsView());
      case createBet:
        return MaterialPageRoute(builder: (context) => const CreateBetView());

      default:
        return null;
    }
  }
}
