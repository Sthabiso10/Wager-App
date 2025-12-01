import 'package:stacked/stacked.dart';
import 'package:wager_app/models/wager_model.dart';

class WagerViewModel extends BaseViewModel {
  // Sample wager list
  List<Wager> wagerList = [
    Wager(
      title: "Soccer Bet",
      description: "Team A vs Team B",
      player1: "Alice",
      player2: "Bob",
      stake: "\$20",
      status: "active",
      date: "2025-12-01",
    ),
    Wager(
      title: "Tennis Match",
      description: "Player 1 vs Player 2",
      player1: "Charlie",
      player2: "Dave",
      stake: "\$15",
      status: "pending",
      date: "2025-12-02",
    ),
    Wager(
      title: "Chess Challenge",
      description: "Alice vs Bob",
      player1: "Alice",
      player2: "Bob",
      stake: "\$10",
      status: "done",
      date: "2025-11-30",
    ),
  ];
}
