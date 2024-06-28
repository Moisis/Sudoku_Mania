import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(int) onNumberSelected;

  NumberPad({required this.onNumberSelected});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Keeping it 3 to maintain a balanced layout
        childAspectRatio: 1, // Ensuring the cells are square
        crossAxisSpacing: 5, // Adjusted spacing between grid items
        mainAxisSpacing: 5, // Adjusted spacing between grid items
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0), // Adjust padding to reduce button size
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
            ),
            onPressed: () {
              onNumberSelected((index + 1));
            },
            child: Text(
              (index + 1).toString(),
              style: TextStyle(color: Colors.black), // Ensure text is visible on white background
            ),
          ),
        );
      },
    );
  }
}
