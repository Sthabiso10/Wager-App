import 'package:flutter/material.dart';
import 'package:wager_app/app/home/widgets/bet_container.dart';

class ActiveBetsWidget extends StatelessWidget {
  const ActiveBetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NewBetCard(
          title: "# Lakers will win the championship",
          description: "I bet the Lakers will win the 2025 NBA championship",
          player1: "Alex Johnson",
          player2: "Sarah Lee",
          stake: "R50",
          status: "Pending",
          date: "15/06/2025",
        ),
        SizedBox(height: 10),
        NewBetCard(
          title: "# Barcelona will win La Liga",
          description: "I bet Barcelona will win the 2025 La Liga title",
          player1: "Luka",
          player2: "Maria",
          stake: "R30",
          status: "Accepted",
          date: "10/06/2025",
        ),
        SizedBox(height: 10),
        NewBetCard(
          title: "# Lakers will win the championship",
          description: "I bet the Lakers will win the 2025 NBA championship",
          player1: "Alex Johnson",
          player2: "Sarah Lee",
          stake: "R50",
          status: "Pending",
          date: "15/06/2025",
        ),
      ],
    );
  }
}
