import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LabActivity extends StatefulWidget {
  @override
  _LabActivityState createState() => _LabActivityState();
}

class _LabActivityState extends State<LabActivity> {
  Map<String, dynamic>? labData;
  Color beakerColor = Colors.white24;
  String feedbackText = "Loading...";
  String currentLabId = "1.1";

  final String baseUrl = "http://192.168.1.5:8080"; // YOUR MAC IP

  @override
  void initState() {
    super.initState();
    print("INIT STATE CALLED");
    loadLab();
  }

  // 🔥 SAFE HEX PARSER (CRITICAL FIX)
  Color parseColor(String hex) {
    return Color(
      int.parse(hex.replaceFirst("0x", ""), radix: 16),
    );
  }

  // 🔥 Load lab from backend
  Future<void> loadLab() async {
    try {
      print("Loading lab: $currentLabId");

      final url = "$baseUrl/api/lab?id=$currentLabId";
      print("Calling: $url");

      final response = await http.get(Uri.parse(url));

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final target = data['components']
            .firstWhere((c) => c['role'] == 'TARGET');

        setState(() {
          labData = data;
          beakerColor = parseColor(target['color']);
          feedbackText = "Drag a reagent into the beaker";
        });
      } else {
        setState(() {
          feedbackText = "Failed to load experiment";
        });
      }
    } catch (e) {
      print("ERROR: $e");
      setState(() {
        feedbackText = "Server connection failed!";
      });
    }
  }

  // 🔥 Handle reactions
  void handleReaction(String actorId) {
    var rules = labData!['strict_rules'] as List;

    for (var rule in rules) {
      if (rule['actor_id'] == actorId) {
        setState(() {
          beakerColor = parseColor(rule['new_color']);
          feedbackText = rule['feedback'];
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(rule['feedback']),
            backgroundColor: Colors.blueGrey,
          ),
        );
        return;
      }
    }

    setState(() {
      feedbackText = "No valid reaction";
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔴 Loading UI
    if (labData == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text("Loading experiment..."),
            ],
          ),
        ),
      );
    }

    final components = labData!['components'] as List;
    final actors =
        components.where((c) => c['role'] == "ACTOR").toList();
    final target =
        components.firstWhere((c) => c['role'] == "TARGET");

    return Scaffold(
      appBar: AppBar(
        title: Text(labData!['title']),
        actions: [
          DropdownButton<String>(
            value: currentLabId,
            dropdownColor: Colors.black,
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
      body: Column(
        children: [
          // Instruction
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              labData!['instruction'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 🔥 Actors (droppers/metals)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: actors.map((comp) {
                return Draggable<String>(
                  data: comp['id'],
                  feedback: Icon(
                    Icons.science,
                    size: 60,
                    color: parseColor(comp['color']),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.science,
                        size: 50,
                        color: parseColor(comp['color']),
                      ),
                      SizedBox(height: 8),
                      Text(comp['label']),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // 🔥 Target (Beaker)
          DragTarget<String>(
            onAccept: (actorId) => handleReaction(actorId),
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 180,
                height: 220,
                margin: EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                  color: beakerColor,
                  border: Border.all(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: Text(
                    target['label'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),

          // Feedback
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Text(
              feedbackText,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}