import 'dart:ui'; // <-- Required for ImageFilter
import 'package:flutter/material.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 130,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white, // semi-transparent
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white, width: 1),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20,
                spreadRadius: -5,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                  child: _buildStatItem(
                icon: Icons.people,
                count: "12",
                label: "Friends",
                iconColor: Colors.blueAccent,
              )),
              _verticalDivider(),
              Expanded(
                  child: _buildStatItem(
                icon: Icons.emoji_events,
                count: "9",
                label: "Won",
                iconColor: Colors.greenAccent,
              )),
              _verticalDivider(),
              Expanded(
                  child: _buildStatItem(
                icon: Icons.close,
                count: "3",
                label: "Lost",
                iconColor: Colors.redAccent,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 60,
      width: 1.2,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String count,
    required String label,
    required Color iconColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor,
            boxShadow: [
              BoxShadow(
                color: iconColor,
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          count,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
