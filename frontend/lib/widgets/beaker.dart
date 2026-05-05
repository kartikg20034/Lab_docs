import 'package:flutter/material.dart';

class Beaker extends StatelessWidget {
  final Color liquidColor;
  final Widget? child;

  const Beaker({
    super.key,
    required this.liquidColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: liquidColor,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(18)),
              ),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}