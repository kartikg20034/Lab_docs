import 'package:flutter/material.dart';
import '../models/reaction.dart';

final reactions = [
  Reaction(
    id: "combination",
    title: "Combination Reaction",
    instruction: "Add water to quicklime.",
    reactants: ["Water", "CaO"],
    equation: "CaO + H₂O → Ca(OH)₂ + Heat",
    resultText: "Calcium Hydroxide formed! Heat released 🔥",
    finalColor: Colors.grey.shade300,
  ),

  Reaction(
    id: "displacement",
    title: "Displacement Reaction",
    instruction: "Put Zinc into Copper Sulphate.",
    reactants: ["Zn", "CuSO₄"],
    equation: "Zn + CuSO₄ → ZnSO₄ + Cu",
    resultText: "Copper deposited!",
    finalColor: Colors.brown,
  ),

  Reaction(
    id: "double",
    title: "Double Displacement",
    instruction: "Add KI to Lead Nitrate.",
    reactants: ["KI", "Pb(NO₃)₂"],
    equation: "2KI + Pb(NO₃)₂ → PbI₂↓ + 2KNO₃",
    resultText: "Yellow precipitate formed!",
    finalColor: Colors.yellow,
  ),
];