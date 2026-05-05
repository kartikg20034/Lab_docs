import 'package:flutter/material.dart';

class ReagentTile extends StatelessWidget {
  final String label;
  final bool isMetal;

  const ReagentTile({
    super.key,
    required this.label,
    this.isMetal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        color: Colors.transparent,
        child: _tile(Colors.white),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _tile(Colors.grey),
      ),
      child: _tile(Colors.white),
    );
  }

  Widget _tile(Color border) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: isMetal
          ? Container(
              width: 50,
              height: 10,
              color: Colors.grey,
            )
          : Column(
              children: [
                const Icon(Icons.science, color: Colors.blue),
                Text(label, style: const TextStyle(color: Colors.white)),
              ],
            ),
    );
  }
}