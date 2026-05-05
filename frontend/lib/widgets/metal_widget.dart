import 'dart:math';
import 'package:flutter/material.dart';

class MetalWidget extends StatelessWidget {
  final Map comp;
  final Function(String) onAction;

  /// NEW: pass state from parent
  final bool reacting;
  final bool done;

  const MetalWidget(
    this.comp,
    this.onAction, {
    super.key,
    this.reacting = false,
    this.done = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color baseColor = comp['color'] ?? Colors.grey;
    final Color depositColor = comp['depositColor'] ?? Colors.brown;

    return Draggable<String>(
      data: comp['id'],

      feedback: _metalVisual(baseColor, depositColor, 70),

      childWhenDragging:
          _metalVisual(Colors.grey.shade400, depositColor, 50, faded: true),

      child: Column(
        children: [
          GestureDetector(
            onTap: () => onAction(comp['id']),
            child: _metalVisual(baseColor, depositColor, 50),
          ),
          const SizedBox(height: 6),
          Text(comp['label'], style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  /// 🔥 Core Metal UI
  Widget _metalVisual(
    Color base,
    Color deposit,
    double size, {
    bool faded = false,
  }) {
    return Stack(
      children: [
        /// 🪨 Base Metal Strip (dynamic gradient)
        Container(
          width: size,
          height: size * 0.2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                base.withOpacity(faded ? 0.5 : 1),
                base.withOpacity(faded ? 0.7 : 0.9),
                base.withOpacity(faded ? 0.5 : 1),
              ],
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: base.withOpacity(0.5),
                blurRadius: 8,
              )
            ],
          ),
        ),

        /// 🔴 Deposition layer (ONLY if reaction done)
        if (done && comp['canDeposit'] == true)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: deposit.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

        /// ⚡ Active particles (during reaction)
        if (reacting && comp['canDeposit'] == true)
          ...List.generate(6, (i) {
            final rand = Random();
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              top: done ? size * 0.2 : rand.nextDouble() * 10,
              left: rand.nextDouble() * (size - 10),
              child: Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  color: deposit,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),

        /// ✨ Shine (premium look)
        Positioned(
          top: 1,
          left: 5,
          right: 5,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}