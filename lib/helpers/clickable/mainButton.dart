import 'package:flutter/material.dart';

class Mainbutton extends StatelessWidget {
  const Mainbutton({super.key, required this.onPressed, required this.label});
  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blue),
        ),
        onPressed: () {
          onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Text(label),
        ));
  }
}
