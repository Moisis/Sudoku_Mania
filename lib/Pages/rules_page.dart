import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Aaaaa");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        title: Text('About Sudoku | Rules'.toUpperCase()),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Sudoku',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Sudoku is a logic-based, combinatorial number-placement puzzle. '
                    'The objective is to fill a 9×9 grid with digits so that each column, '
                    'each row, and each of the nine 3×3 subgrids that compose the grid '
                    'contain all of the digits from 1 to 9. The puzzle setter provides a partially '
                    'completed grid, which typically has a unique solution.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Rules of Sudoku',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '1. Each row must contain the numbers from 1 to 9, without repetitions.\n'
                    '2. Each column must contain the numbers from 1 to 9, without repetitions.\n'
                    '3. Each of the nine 3x3 grids must contain the numbers from 1 to 9, without repetitions.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Tips for Solving Sudoku',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '1. Start with the obvious numbers.\n'
                    '2. Use the process of elimination.\n'
                    '3. Look for rows, columns, and boxes that contain a lot of numbers.\n'
                    '4. Be patient and practice regularly.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'History of Sudoku',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Sudoku was popularized in 1986 by the Japanese puzzle company Nikoli, under the name Sudoku, '
                    'meaning "single number". However, the puzzle\'s origins can be traced back to a puzzle called '
                    'Number Place, which was created by Howard Garns, a freelance puzzle constructor, in 1979.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
