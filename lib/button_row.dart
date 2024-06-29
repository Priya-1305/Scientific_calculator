import 'package:flutter/material.dart';
import 'button.dart';

class ButtonRow extends StatelessWidget {
  final List<String> buttonTexts;
  final Function(String) onButtonPressed;

  ButtonRow({required this.buttonTexts, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buttonTexts.map((text) {
        return Button(buttonText: text, onPressed: onButtonPressed);
      }).toList(),
    );
  }
}
