import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sudoku Stats'.toUpperCase() , style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Game Statistics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SudokuStatisticCard(
                difficulty: 'Beginner',
                gamesPlayed: 50, // Replace with actual data
                gamesWon: 30, // Replace with actual data
                winRate: '60%', // Replace with actual data
                bestTime: '3:45', // Replace with actual data
              ),
              SudokuStatisticCard(
                difficulty: 'Easy',
                gamesPlayed: 100, // Replace with actual data
                gamesWon: 70, // Replace with actual data
                winRate: '70%', // Replace with actual data
                bestTime: '6:12', // Replace with actual data
              ),
              SudokuStatisticCard(
                difficulty: 'Medium',
                gamesPlayed: 80, // Replace with actual data
                gamesWon: 50, // Replace with actual data
                winRate: '62.5%', // Replace with actual data
                bestTime: '8:20', // Replace with actual data
              ),
              SudokuStatisticCard(
                difficulty: 'Hard',
                gamesPlayed: 60, // Replace with actual data
                gamesWon: 40, // Replace with actual data
                winRate: '66.67%', // Replace with actual data
                bestTime: '10:15', // Replace with actual data
              ),
              SudokuStatisticCard(
                difficulty: 'Expert',
                gamesPlayed: 30, // Replace with actual data
                gamesWon: 20, // Replace with actual data
                winRate: '66.67%', // Replace with actual data
                bestTime: '12:30', // Replace with actual data
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SudokuStatisticCard extends StatelessWidget {
  final String difficulty;
  final int gamesPlayed;
  final int gamesWon;
  final String winRate;
  final String bestTime;

  const SudokuStatisticCard({
    Key? key,
    required this.difficulty,
    required this.gamesPlayed,
    required this.gamesWon,
    required this.winRate,
    required this.bestTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              difficulty,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
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
                // Add additional widgets or actions as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}
