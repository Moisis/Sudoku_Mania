import 'package:flutter/material.dart';


class SudokuStatisticCard extends StatelessWidget {
  final String difficulty;
  final int gamesPlayed;
  final int gamesWon;
  final String winRate;
  final String bestTime;

  const SudokuStatisticCard({
    super.key,
    required this.difficulty,
    required this.gamesPlayed,
    required this.gamesWon,
    required this.winRate,
    required this.bestTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              difficulty,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Games Played: $gamesPlayed'),
                    Text('Games Won: $gamesWon'),
                    Text('Win Rate: $winRate'),
                    Text('Best Time: $bestTime'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}