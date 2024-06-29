import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(int) onNumberSelected;
  final Function() onClear;

  NumberPad({required this.onNumberSelected, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Adjusted to 3 to maintain a balanced layout
        childAspectRatio: 1, // Ensuring the cells are square
        crossAxisSpacing: 5, // Adjusted spacing between grid items
        mainAxisSpacing: 5, // Adjusted spacing between grid items
      ),
      itemCount: 10,

      itemBuilder: (context, index) {
        // Clear Button
        if (index == 9) {
          return Padding(
            padding: const EdgeInsets.all(5.0), // Adjust padding to reduce button size
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,  // Ensure no internal padding that affects centering
                minimumSize: Size(36, 36), // Example minimum size, adjust as needed
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ), // Rounded corners
              ),
              onPressed: () {
                onClear();
                },
              child: const Center(
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }

        // Number Buttons
        return Padding(
          padding: const EdgeInsets.all(5.0), // Adjust padding to reduce button size
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE8EEFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ), // Rounded corners
            ),
            onPressed: () {
              onNumberSelected(index + 1);
            },
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}