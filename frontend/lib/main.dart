import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const LabApp());
}

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LabActivity(),
    );
  }
}

class LabActivity extends StatefulWidget {
  const LabActivity({super.key});

  @override
  State<LabActivity> createState() => _LabActivityState();
}

class _LabActivityState extends State<LabActivity> {
  Map<String, dynamic>? labData;

  Color beakerColor = Colors.white24;
  String feedbackText = "Loading...";
  String currentLabId = "1.1";

  final String baseUrl = "http://192.168.1.5:8080";

  // 🔥 NEW STATE
  bool isReacting = false;
  bool showEquation = false;
  List<String> addedActors = [];

  @override
  void initState() {
    super.initState();
    loadLab();
  }

  Color parseColor(String hex) {
    return Color(int.parse(hex.replaceFirst("0x", ""), radix: 16));
  }

  Future<void> loadLab() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/lab?id=$currentLabId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final target =
            data['components'].firstWhere((c) => c['role'] == 'TARGET');

        setState(() {
          labData = data;
          beakerColor = parseColor(target['color']);
          feedbackText = "Drag a reagent into the beaker";
          addedActors.clear();
          isReacting = false;
          showEquation = false;
        });
      } else {
        setState(() => feedbackText = "Failed to load lab");
      }
    } catch (e) {
      setState(() => feedbackText = "Server connection failed!");
    }
  }

  void handleReaction(String actorId) async {
    if (addedActors.contains(actorId)) return;

    addedActors.add(actorId);

    setState(() {
      feedbackText = "Pouring...";
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      isReacting = true;
    });

    var rules = labData!['strict_rules'] as List;

    for (var rule in rules) {
      if (rule['actor_id'] == actorId) {
        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          beakerColor = parseColor(rule['new_color']);
          feedbackText = rule['feedback'];
          showEquation = true;
          isReacting = false;
        });
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (labData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final components = labData!['components'] as List;
    final actors = components.where((c) => c['role'] == "ACTOR").toList();
    final target =
        components.firstWhere((c) => c['role'] == "TARGET");

    return Scaffold(
      appBar: AppBar(
        title: Text(labData!['title']),
        actions: [
          DropdownButton<String>(
            value: currentLabId,
            dropdownColor: Colors.black,
            underline: const SizedBox(),
            items: ["1.1", "1.2", "1.3"].map((id) {
              return DropdownMenuItem(
                value: id,
                child: Text("Activity $id"),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                currentLabId = value!;
                labData = null;
              });
              loadLab();
            },
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            // 🧮 EQUATION
            if (labData!['equation'] != null)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: showEquation ? 1 : 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    labData!['equation'],
                    style: TextStyle(
                      fontSize: 20,
                      color: showEquation
                          ? Colors.tealAccent
                          : Colors.white24,
                    ),
                  ),
                ),
              ),

            // 📢 INSTRUCTION
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                labData!['instruction'],
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // 🧪 ACTORS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: actors.map((comp) {
                bool isMetal =
                    comp['label'].toLowerCase().contains("zinc");

                return Draggable<String>(
                  data: comp['id'],
                  feedback: Material(
                    color: Colors.transparent,
                    child: _buildActor(comp, isMetal, 60),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: _buildActor(comp, isMetal, 50),
                  ),
                  child: _buildActor(comp, isMetal, 50),
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            // 🧪 BEAKER
            DragTarget<String>(
              onAccept: (actorId) {
                handleReaction(actorId);
              },
              builder: (context, candidateData, rejectedData) {
                return AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: 140,
                  height: 180,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.white70, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        height: isReacting ? 140 : 80,
                        decoration: BoxDecoration(
                          color: beakerColor,
                          borderRadius:
                              const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          boxShadow: [
                            if (isReacting)
                              BoxShadow(
                                color:
                                    beakerColor.withOpacity(0.6),
                                blurRadius: 20,
                              )
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          target['label'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),

            const Spacer(),

            // 💬 FEEDBACK
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                feedbackText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActor(Map comp, bool isMetal, double size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isMetal
            ? Container(
                width: 50,
                height: 10,
                color: Colors.grey,
              )
            : Icon(
                Icons.science,
                size: size,
                color: parseColor(comp['color']),
              ),
        const SizedBox(height: 6),
        Text(comp['label']),
      ],
    );
  }
}