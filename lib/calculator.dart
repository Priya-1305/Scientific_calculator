import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'button.dart';
import 'button_row.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';
  String _result = '';
  bool _isDegreeMode = true;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _expression = '';
        _result = '';
      } else if (buttonText == 'DEL') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (buttonText == '=') {
        try {
          String finalExpression = _expression;
          Parser p = Parser();
          Expression exp = p.parse(finalExpression);
          ContextModel cm = ContextModel();

          if (_isDegreeMode) {
            finalExpression = finalExpression.replaceAllMapped(
                RegExp(r'(sin|cos|tan)\((.*?)\)'),
                (Match m) =>
                    '${m.group(1)}(${_convertToRadians(double.parse(m.group(2)!))})');
            exp = p.parse(finalExpression);
          }

          _result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          _result = 'Error';
        }
      } else if (buttonText == 'DEG') {
        _isDegreeMode = true;
      } else if (buttonText == 'RAD') {
        _isDegreeMode = false;
      } else {
        _expression += buttonText;
      }
    });
  }

  double _convertToRadians(double degrees) {
    return degrees * (3.14159265358979323846 / 180.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12.0),
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _expression,
                  style: TextStyle(fontSize: 24.0),
                ),
                Text(
                  _result,
                  style: TextStyle(fontSize: 48.0),
                ),
              ],
            ),
          ),
        ),
        _buildButtons(),
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        ButtonRow(
            buttonTexts: ['7', '8', '9', '/'],
            onButtonPressed: _onButtonPressed),
        ButtonRow(
            buttonTexts: ['4', '5', '6', '*'],
            onButtonPressed: _onButtonPressed),
        ButtonRow(
            buttonTexts: ['1', '2', '3', '-'],
            onButtonPressed: _onButtonPressed),
        ButtonRow(
            buttonTexts: ['0', '.', '=', '+'],
            onButtonPressed: _onButtonPressed),
        ButtonRow(
            buttonTexts: ['sin', 'cos', 'tan', 'log'],
            onButtonPressed: _onButtonPressed),
        ButtonRow(
            buttonTexts: ['sqrt', 'exp', '^', 'AC'],
            onButtonPressed: _onButtonPressed),
        ButtonRow(
            buttonTexts: ['DEG', 'RAD', '(', ')'],
            onButtonPressed: _onButtonPressed),
        ButtonRow(buttonTexts: ['DEL'], onButtonPressed: _onButtonPressed),
      ],
    );
  }
}
