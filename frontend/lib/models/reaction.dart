class Reaction {
  final String id;
  final String title;
  final String instruction;
  final String equation;
  final List<Component> components;
  final List<Rule> rules;

  Reaction({
    required this.id,
    required this.title,
    required this.instruction,
    required this.equation,
    required this.components,
    required this.rules,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      id: json['id'],
      title: json['title'],
      instruction: json['instruction'],
      equation: json['equation'],
      components: (json['components'] as List)
          .map((e) => Component.fromJson(e))
          .toList(),
      rules: (json['strict_rules'] as List)
          .map((e) => Rule.fromJson(e))
          .toList(),
    );
  }
}

class Component {
  final String id;
  final String label;
  final String color;
  final String role;
  final String type;

  Component({
    required this.id,
    required this.label,
    required this.color,
    required this.role,
    required this.type,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      id: json['id'],
      label: json['label'],
      color: json['color'],
      role: json['role'],
      type: json['type'],
    );
  }
}

class Rule {
  final String actorId;
  final String targetId;
  final String newColor;
  final String feedback;
  final String reactionType;

  Rule({
    required this.actorId,
    required this.targetId,
    required this.newColor,
    required this.feedback,
    required this.reactionType,
  });

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      actorId: json['actor_id'],
      targetId: json['target_id'],
      newColor: json['new_color'],
      feedback: json['feedback'],
      reactionType: json['reaction_type'],
    );
  }
}