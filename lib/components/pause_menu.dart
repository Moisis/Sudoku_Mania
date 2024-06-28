import 'dart:ui';

import 'package:flutter/material.dart';


class PauseMenu extends StatelessWidget {
  final VoidCallback onResume;

  PauseMenu({required this.onResume});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.black.withOpacity(0.8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Paused',
                  style: TextStyle(color: Colors.white, fontSize: 70),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onResume,
                  child: Text('Resume'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add logic for restarting the game
                  },
                  child: Text('Restart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add logic for quitting to the main menu
                  },
                  child: Text('Return to Main Menu'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}