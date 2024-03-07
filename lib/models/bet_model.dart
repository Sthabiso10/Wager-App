import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

class Bet {
  Bet({
    required this.date,
    required this.title,
    required this.description,
    required this.amount,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }
}
