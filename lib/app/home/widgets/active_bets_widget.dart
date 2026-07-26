import 'package:flutter/material.dart';
import 'package:wager_app/app/global_widgets/animations.dart';
import 'package:wager_app/app/home/widgets/bet_container.dart';

class ActiveBetsWidget extends StatelessWidget {
  const ActiveBetsWidget({super.key});

  static const List<NewBetCard> _bets = [
    NewBetCard(
      title: "# Lakers will win the championship",
      description: "I bet the Lakers will win the 2025 NBA championship",
      player1: "Alex Johnson",
      player2: "Sarah Lee",
      stake: "R50",
      status: "Pending",
      date: "15/06/2025",
    ),
    NewBetCard(
      title: "# Barcelona will win La Liga",
      description: "I bet Barcelona will win the 2025 La Liga title",
      player1: "Luka",
      player2: "Maria",
      stake: "R30",
      status: "Accepted",
      date: "10/06/2025",
    ),
    NewBetCard(
      title: "# Weekend 5km run challenge",
      description: "First to finish the parkrun under 25 minutes wins",
      player1: "Alex Johnson",
      player2: "Sarah Lee",
      stake: "R50",
      status: "Won",
      date: "15/06/2025",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 120),
      itemCount: _bets.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) => FadeSlideIn.staggered(
        index,
        step: const Duration(milliseconds: 90),
        child: _bets[index],
      ),
    );
  }
}
