import 'dart:math';
import 'package:flutter/material.dart';
import '../models/reaction_model.dart';

class ReactionAnimator extends StatelessWidget {
  final ReactionType type;
  final bool reacting;
  final bool done;

  const ReactionAnimator({
    super.key,
    required this.type,
    required this.reacting,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ReactionType.displacement:
        return _copperEffect();
      case ReactionType.precipitation:
        return _precipitate();
      case ReactionType.combination:
        return _heat();
    }
  }

  /// ✅ Copper deposition (FIXED)
  Widget _copperEffect() {
    return Stack(
      children: [
        if (done)
          Positioned(
            top: 20,
            left: 50,
            child: Container(
              width: 40,
              height: 6,
              color: Colors.brown,
            ),
          ),

        if (reacting)
          ...List.generate(10, (i) {
            return AnimatedPositioned(
              duration: const Duration(seconds: 2),
              top: done ? 120 : Random().nextDouble() * 60,
              left: Random().nextDouble() * 120,
              child: Container(
                width: 4,
                height: 4,
                color: Colors.brown,
              ),
            );
          })
      ],
    );
  }

  /// ✅ Precipitate (with settling)
  Widget _precipitate() {
    return Stack(
      children: [
        if (reacting)
          Container(color: Colors.white.withOpacity(0.3)),

        if (reacting || done)
          ...List.generate(15, (i) {
            return AnimatedPositioned(
              duration: const Duration(seconds: 2),
              top: done ? 120 : Random().nextDouble() * 80,
              left: Random().nextDouble() * 120,
              child: Container(
                width: 4,
                height: 4,
                color: Colors.yellow,
              ),
            );
          }),

        if (done)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(height: 25, color: Colors.yellow),
          ),
      ],
    );
  }

  /// 🔥 Heat + bubbles
  Widget _heat() {
    return Stack(
      children: [
        if (reacting)
          const Center(
              child: Icon(Icons.whatshot, color: Colors.orange)),

        ...List.generate(10, (i) {
          return Positioned(
            bottom: Random().nextDouble() * 60,
            left: Random().nextDouble() * 120,
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
            ),
          );
        }),
      ],
    );
  }
}