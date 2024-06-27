import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // ##TODO ADD CONST FILE FOR TEXT STYLES
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
         ),
        title: Text('Sudoku Mania'.toUpperCase()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/appicon.png'),
            const Text(
              'Welcome to Sudoku Mania!',
            ),
            SizedBox(
                height: 20
            ),
            ElevatedButton(
              child: Text('Start Game'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/game_page"
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}