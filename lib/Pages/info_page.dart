import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  Future<void> _launchUrl(String Url) async {
    final Uri _url = Uri.parse(Url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        title: Text('About'.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About Sudoku Mania',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sudoku Mania is a fun and challenging Sudoku puzzle game for players of all ages. '
                    'Our game offers various difficulty levels, from Beginner to Expert, to cater to both newcomers and seasoned players.',
                style: TextStyle(fontSize: 16),
              ),

              const Text(
                'Rules of Sudoku',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '1. Each row must contain the numbers from 1 to 9, without repetitions.\n'
                    '2. Each column must contain the numbers from 1 to 9, without repetitions.\n'
                    '3. Each of the nine 3x3 grids must contain the numbers from 1 to 9, without repetitions.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'How to Play',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '1. Fill the grid with numbers from 1 to 9.\n'
                    '2. Each row, column, and 3x3 grid must contain all the numbers from 1 to 9 without repeating.\n'
                    '3. Use logic and reasoning to solve the puzzle.\n'
                    '4. Start with easier levels and gradually progress to harder levels.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              const Text(
                'Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '1. Multiple difficulty levels.\n'
                    '2. User-friendly interface.\n'
                    '3. Hints and undo options.\n'
                    '4. Track your progress with statistics.\n'
                    '5. Daily puzzles to keep you engaged.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,

                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'If you have any questions or feedback, feel free to reach out to us at support@sudokumania.com.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Follow Author',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _launchUrl('https://github.com/Moisis');
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.code, color: Colors.blue),
                        SizedBox(width: 5),
                        Text(
                          'GitHub',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      _launchUrl('https://www.linkedin.com/in/moisis-mounir-72153a280/');
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.work, color: Colors.blue),
                        SizedBox(width: 5),
                        Text(
                          'LinkedIn',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


