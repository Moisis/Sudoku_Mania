import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_mania/models/sudoku_statistic.dart';

import '../components/SudokuStatisticCard.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<SudokuStatistic> stats = [];

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedStats = prefs.getStringList('game_stats') ?? [];

    final Map<String, SudokuStatistic> statsMap = {
      'Beginner': SudokuStatistic(difficulty: 'Beginner'),
      'Easy': SudokuStatistic(difficulty: 'Easy'),
      'Medium': SudokuStatistic(difficulty: 'Medium'),
      'Hard': SudokuStatistic(difficulty: 'Hard'),
      'Expert': SudokuStatistic(difficulty: 'Expert'),
    };

    for (var stat in savedStats) {
      final parts = stat.split(':');
      final key = parts[0];
      final value = int.parse(parts[1]);

      final difficulty = key.split('_')[0];
      final statType = key.split('_')[2];

      if (statType == 'played') {
        statsMap[difficulty]!.gamesPlayed = value;
      } else if (statType == 'won') {
        statsMap[difficulty]!.gamesWon = value;
      } else if (statType == 'lost') {
        statsMap[difficulty]!.gamesLost = value;
      } else if (statType == 'time') {
        statsMap[difficulty]!.setBestTime(value);
      }
    }

    statsMap.forEach((key, value) {
      value.calculateWinRate();
    });

    setState(() {
      stats = statsMap.values.toList();
    });
  }

  Future<void> resetStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('game_stats');
    loadStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Stats'.toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: resetStats,
            child: Text(
              'Reset',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: stats.map((stat) {
              return SudokuStatisticCard(
                difficulty: stat.difficulty,
                gamesPlayed: stat.gamesPlayed,
                gamesWon: stat.gamesWon,
                winRate: stat.winRate,
                bestTime: stat.bestTime,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

}
