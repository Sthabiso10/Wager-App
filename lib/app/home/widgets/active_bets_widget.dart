import 'package:flutter/material.dart';
import 'package:wager_app/app/home/widgets/bet_container.dart';

class ActiveBetsWidget extends StatelessWidget {
  const ActiveBetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // CRITICAL: Allow the list to scroll behind the nav pill
      physics: const BouncingScrollPhysics(),

      // CRITICAL: No bottom padding - let items scroll below
      padding: const EdgeInsets.only(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0, // This was probably set to something
      ),

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

        // Add some extra space at the bottom so last item isn't hidden
        SizedBox(height: 100), // This gives breathing room above nav pill
      ],
    );
  }
}
