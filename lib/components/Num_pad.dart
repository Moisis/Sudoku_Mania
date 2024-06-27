import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(int) onNumberSelected;

  NumberPad({required this.onNumberSelected});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 2,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              onNumberSelected((index +1));
            },
            child: Text(
              (index + 1).toString(),
            ),
          ),
        );
      },
    );
  }
}
