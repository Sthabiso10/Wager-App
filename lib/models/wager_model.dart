class Wager {
  final String title;
  final String description;
  final String player1;
  final String player2;
  final String stake;
  final String status; // all, active, pending, done
  final String date;

  Wager({
    required this.title,
    required this.description,
    required this.player1,
    required this.player2,
    required this.stake,
    required this.status,
    required this.date,
  });
}
