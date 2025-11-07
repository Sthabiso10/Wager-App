import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  void pushNavigation(context, view) {
    Navigator.pushNamed(
      context,
      view,
    );
  }
}
