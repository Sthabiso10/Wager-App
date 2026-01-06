// models/wager_model.dart
class Wager {
  final String title;
  final String description;
  final String player1;
  final String player2;
  final String stake;
  final String status;
  final String date;
  final String? id; // Add ID for unique identification

  Wager({
    required this.title,
    required this.description,
    required this.player1,
    required this.player2,
    required this.stake,
    required this.status,
    required this.date,
    this.id,
  });
}
