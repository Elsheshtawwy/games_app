import 'package:flutter/material.dart';
import 'package:games_app/models/GameDetailsModel.dart';
import 'package:games_app/providers/dark_mode_provider.dart';
import 'package:provider/provider.dart';

class MinimumSystemRequirmentsCard extends StatelessWidget {
  MinimumSystemRequirmentsCard(
      {super.key, required this.minimumSystemRequirments});
  final MinimumSystemRequirements? minimumSystemRequirments;

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (context, darkModeConsumer, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Minimum System Requirements",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: darkModeConsumer.isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "OS: ${minimumSystemRequirments!.os}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: darkModeConsumer.isDark ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "MEMORY: ${minimumSystemRequirments!.memory}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: darkModeConsumer.isDark ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "PROCESSOR: ${minimumSystemRequirments!.processor}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: darkModeConsumer.isDark ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "GRAPHICS: ${minimumSystemRequirments!.graphics}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: darkModeConsumer.isDark ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "STORAGE: ${minimumSystemRequirments!.storage}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: darkModeConsumer.isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      );
    });
  }
}
