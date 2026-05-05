import 'package:flutter/material.dart';

class DraggableReagent extends StatelessWidget {
  final String label;
  final Color color;
  final String id;

  const DraggableReagent({
    super.key,
    required this.label,
    required this.color,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: id,
      feedback: _box(70),
      childWhenDragging: _box(50, Colors.grey),
      child: _box(50),
    );
  }

  Widget _box(double size, [Color? override]) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: override ?? color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: (override ?? color).withOpacity(0.6),
                  blurRadius: 10)
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}