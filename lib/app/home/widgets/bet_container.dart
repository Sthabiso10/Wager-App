import 'dart:ui';
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
        return const Color(0xFFFFA726); // Orange
      case "accepted":
        return const Color(0xFF42A5F5); // Blue
      case "won":
        return const Color(0xFF66BB6A); // Green
      case "lost":
        return const Color(0xFFEF5350); // Red
      case "active":
        return const Color(0xFF6A11CB); // Purple accent
      default:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A1A), Color(0xFF141414)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Gradient border effect
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: status.toLowerCase() == "active"
                    ? [const Color(0xFF6A11CB), const Color(0x994277F2)]
                    : [const Color(0xFF2A2A2A), const Color(0xFF2A2A2A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.5), // Border width
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(18.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20, 50, 20, 10), // Added top padding for status badge
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with icon
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6A11CB).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.currency_exchange,
                              color: const Color(0xFF6A11CB),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right:
                                      60), // Add right padding to prevent text from going under status badge
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                                maxLines:
                                    2, // Allow title to take 2 lines if needed
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Description
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 20),

                      // VS Divider
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const Divider(
                            color: Color(0xFF2A2A2A),
                            thickness: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6A11CB), Color(0x994277F2)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'VS',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Players section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Player 1
                          _buildPlayerCard(
                            name: player1,
                            isPlayer1: true,
                            isWinning: status.toLowerCase() == "won",
                          ),

                          // Player 2
                          _buildPlayerCard(
                            name: player2,
                            isPlayer1: false,
                            isWinning: status.toLowerCase() == "lost",
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Footer with stake and date
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF141414),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF2A2A2A),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Stake
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'STAKE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet,
                                      color: const Color(0xFF6A11CB),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      stake,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Date
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'DATE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.white.withOpacity(0.7),
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      date,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Status badge with glow effect
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 80, // Ensure minimum width for status text
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    getStatusColor(),
                    getStatusColor().withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: getStatusColor().withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                status.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard({
    required String name,
    required bool isPlayer1,
    required bool isWinning,
  }) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isWinning
            ? (isPlayer1
                ? const Color(0xFF66BB6A).withOpacity(0.15)
                : const Color(0xFFEF5350).withOpacity(0.15))
            : const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isWinning
              ? (isPlayer1
                  ? const Color(0xFF66BB6A).withOpacity(0.3)
                  : const Color(0xFFEF5350).withOpacity(0.3))
              : const Color(0xFF3A3A3A),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Player avatar with status indicator
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: isPlayer1
                        ? [const Color(0xFF6A11CB), const Color(0x994277F2)]
                        : [const Color(0xFFEF5350), const Color(0x99FF7043)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF1A1A1A),
                    child: Text(
                      name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              if (isWinning)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Color(0xFF66BB6A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isWinning
                  ? (isPlayer1
                      ? const Color(0xFF66BB6A)
                      : const Color(0xFFEF5350))
                  : Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            isPlayer1 ? 'You' : 'Opponent',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
