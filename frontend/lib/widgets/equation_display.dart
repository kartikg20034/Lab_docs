import 'package:flutter/material.dart';

class EquationDisplay extends StatelessWidget {
  final String equation;

  const EquationDisplay({super.key, required this.equation});

  @override
  Widget build(BuildContext context) {
    return Text(
      equation,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.yellowAccent,
      ),
      textAlign: TextAlign.center,
    );
  }
}