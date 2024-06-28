import 'package:flutter/material.dart';

class IC_button extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Icon icon;
  final Color color;
  final double fontsize ;


  IC_button({required this.title, required this.onPress, required this.icon, required this.color, required this.fontsize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text(
        title,
        style: TextStyle(
          fontSize: fontsize,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onPress,
    );
  }
}