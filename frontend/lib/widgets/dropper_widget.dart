import 'package:flutter/material.dart';

class DropperWidget extends StatelessWidget {
  final Map comp;
  final Function onAction;

  DropperWidget(this.comp, this.onAction);

  Color parse(String c) =>
      Color(int.parse(c.replaceFirst("0x", ""), radix: 16));

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: comp['id'],
      feedback: Icon(Icons.colorize, size: 60, color: parse(comp['color'])),
      child: Column(
        children: [
          Icon(Icons.colorize, color: parse(comp['color']), size: 50),
          Text(comp['label']),
        ],
      ),
    );
  }
}