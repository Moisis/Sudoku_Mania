import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(int) onNumberSelected;
  final Function() onClear;

  NumberPad({required this.onNumberSelected, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonSize = constraints.maxWidth / 5; // Divide by the number of buttons in a row

        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            // Clear Button
            if (index == 9) {
              return Padding(
                padding: EdgeInsets.all(buttonSize * 0.05), // 5% of button size
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(buttonSize, buttonSize),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: onClear,
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
              padding: EdgeInsets.all(buttonSize * 0.05), // 5% of button size
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8EEFA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  onNumberSelected(index + 1);
                },
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: buttonSize * 0.2, // 20% of button size
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}