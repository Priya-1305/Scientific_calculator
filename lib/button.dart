import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Function(String) onPressed;

  Button({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => onPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
