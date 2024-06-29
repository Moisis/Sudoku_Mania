import 'dart:ui';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onReturnToMainMenu;

  PauseMenu({
    required this.onResume,
    required this.onRestart,
    required this.onReturnToMainMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.black.withOpacity(0.8),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Paused',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      elevation: 3,
                    ),
                    onPressed: onResume,
                    child: Text(
                      'Resume',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      elevation: 3,
                    ),
                    onPressed: onRestart,
                    child: Text(
                      'Restart',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      elevation: 3,
                    ),
                    onPressed: onReturnToMainMenu,
                    child: Text(
                      'Return to Main Menu',
                      textAlign: TextAlign.center, // Ensure text alignment is centered
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
