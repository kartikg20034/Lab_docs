import 'package:flutter/material.dart';

class EquationWidget extends StatelessWidget {
  final String equation;
  final bool active;

  const EquationWidget({
    super.key,
    required this.equation,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: active ? 1 : 0.3,
      duration: const Duration(milliseconds: 800),
      child: Text(
        equation,
        style: TextStyle(
          fontSize: 20,
          color: active ? Colors.tealAccent : Colors.white30,
        ),
      ),
    );
  }
}