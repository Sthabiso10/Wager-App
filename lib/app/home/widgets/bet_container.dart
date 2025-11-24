import 'package:flutter/material.dart';
import 'package:wager_app/styles/colors.dart';

class NewBetCard extends StatelessWidget {
  final String title;
  final String description;
  final String player1;
  final String player2;
  final String stake;
  final String status;
  final String date;

  const NewBetCard({
    super.key,
    required this.title,
    required this.description,
    required this.player1,
    required this.player2,
    required this.stake,
    required this.status,
    required this.date,
  });

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orangeAccent;
      case "accepted":
        return Colors.blueAccent;
      case "won":
        return Colors.green;
      case "lost":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      margin: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          // Main Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18), // spacing for badge

                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // Use Expanded to push VS row to bottom
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Player 1
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(player1[0],
                                style: const TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 4),
                          Text(player1,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: colorText)),
                        ],
                      ),
                      const Spacer(),

                      // VS box
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'VS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const Spacer(),

                      // Player 2
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Text(player2[0],
                                style: const TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 4),
                          Text(player2,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: colorText)),
                        ],
                      ),
                    ],
                  ),
                ),

                // Footer: Stake & Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stake: $stake',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status badge (floating top-right)
          Positioned(
            top: 8,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: getStatusColor(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
