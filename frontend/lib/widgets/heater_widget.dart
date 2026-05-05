import 'package:flutter/material.dart';

class HeaterWidget extends StatelessWidget {
  final Function onAction;

  HeaterWidget(this.onAction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onAction("heat"),
      child: Column(
        children: [
          Icon(Icons.local_fire_department, color: Colors.orange, size: 50),
          Text("Heat"),
        ],
      ),
    );
  }
}