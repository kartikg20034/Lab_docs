import 'package:flutter/material.dart';
import 'widgets/dropper_widget.dart';
import 'widgets/heater_widget.dart';
import 'widgets/metal_widget.dart';

Widget buildComponent(Map comp, Function onAction) {
  switch (comp['type']) {
    case "DROPPER":
      return DropperWidget(comp, onAction);

    case "HEATER":
      return HeaterWidget(onAction);

    case "METAL":
      return MetalWidget(comp, onAction);

    default:
      return Container();
  }
}