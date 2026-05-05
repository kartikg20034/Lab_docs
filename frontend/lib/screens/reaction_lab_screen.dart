import 'package:flutter/material.dart';
import '../data/reaction_repository.dart';
import '../models/reaction_model.dart';
import '../widgets/beaker.dart';
import '../widgets/draggable_reagent.dart';
import '../widgets/equation_display.dart';
import '../widgets/reaction_animator.dart';

class ReactionLabScreen extends StatefulWidget {
  const ReactionLabScreen({super.key});

  @override
  State<ReactionLabScreen> createState() => _ReactionLabScreenState();
}

class _ReactionLabScreenState extends State<ReactionLabScreen> {
  int index = 0;

  bool dropped = false;
  bool reacting = false;
  bool done = false;

  List<ReactionModel> reactions = ReactionRepository.getReactions();

  void startReaction() async {
    setState(() {
      dropped = true;
      reacting = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      reacting = false;
      done = true;
    });
  }

  Color getColor(ReactionType type) {
    if (!done) {
      if (type == ReactionType.displacement) return Colors.blue;
      if (type == ReactionType.precipitation) return Colors.white70;
      return Colors.grey;
    } else {
      if (type == ReactionType.displacement) return Colors.transparent;
      if (type == ReactionType.precipitation) return Colors.yellow;
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = reactions[index];

    return Scaffold(
      backgroundColor: const Color(0xff0b1f26),
      appBar: AppBar(title: const Text("Lab")),
      body: Column(
        children: [
          EquationDisplay(equation: r.equation),
          const SizedBox(height: 20),

          Text(r.instruction),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DraggableReagent(label: "Reagent", color: Colors.blue, id: "r")
            ],
          ),

          const SizedBox(height: 30),

          DragTarget<String>(
            onAccept: (_) => startReaction(),
            builder: (_, __, ___) {
              return Beaker(
                liquidColor: getColor(r.type),
                child: ReactionAnimator(
                  type: r.type,
                  reacting: reacting,
                  done: done,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}