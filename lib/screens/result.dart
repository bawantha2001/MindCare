import 'dart:math';
import 'package:flutter/material.dart';
import 'speech_analysis_page.dart';

class ResultPage extends StatelessWidget {
  final List<Map<String, dynamic>> serverResponses;

  const ResultPage({Key? key, required this.serverResponses}) : super(key: key);

  // Helper function to compute the final category.
  String computeFinalCategory(List<Map<String, dynamic>> responses) {
    int severeCount = 0;
    int earlyCount = 0;
    int moderateCount = 0;

    for (var response in responses) {
      String predictedLabel = response['predictedLabel'] ?? "";
      String category;
      if (predictedLabel == "Patient's Confused Respond" ||
          predictedLabel == "Patient's Minimum respond") {
        category = "severe";
      } else if (predictedLabel == "Patient's Delay Respond") {
        category = "moderate";
      } else if (predictedLabel == "Patient's Fluent Respond" ||
          predictedLabel == "Patient's Repeat respond") {
        category = "early";
      } else {
        category = "early"; // Fallback to early if unknown.
      }

      if (category == "severe") {
        severeCount++;
      } else if (category == "early") {
        earlyCount++;
      } else if (category == "moderate") {
        moderateCount++;
      }
    }

    // If all 3 are early, randomly show "early" or "moderate".
    if (earlyCount == 3) {
      List<String> options = ["early", "moderate"];
      return options[Random().nextInt(options.length)];
    }

    // If at least 2 responses are severe, final category is severe.
    if (severeCount >= 2) {
      return "severe";
    }
    // Otherwise, if there are at least 2 responses that are early or moderate,
    // randomly choose one of the available options.
    else if ((earlyCount + moderateCount) >= 2) {
      List<String> options = [];
      if (earlyCount > 0) options.add("early");
      if (moderateCount > 0) options.add("moderate");
      return options[Random().nextInt(options.length)];
    }
    // Default to early.
    return "early";
  }

  @override
  Widget build(BuildContext context) {
    // Compute the final overall category from server responses.
    String finalCategory = computeFinalCategory(serverResponses);

    // Fixed values for our custom bar graph.
    final List<double> testValues = [3.5, 4.2, 2.8];
    final double maxValue = 5.0; // Maximum value for scaling.
    final double graphHeight = 200; // Height available for the graph.

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fluency Metrics"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Gray box at the top showing the final overall category.
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  "Overall Category: $finalCategory",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Custom bar graph built with standard widgets.
            SizedBox(
              height: graphHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBar("Fluency", testValues[0], maxValue, graphHeight, Colors.blue),
                  _buildBar("Verbal", testValues[1], maxValue, graphHeight, Colors.green),
                  _buildBar("Story", testValues[2], maxValue, graphHeight, Colors.orange),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // "Analyze Again" button.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to a fresh SpeechAnalysisPage by removing all previous routes.
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SpeechAnalysisPage(),
                    ),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text("Analyze Again"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build each bar in the graph.
  Widget _buildBar(
      String label,
      double value,
      double maxValue,
      double graphHeight,
      Color color,
      ) {
    // Calculate the bar height based on the value and the maximum value.
    double barHeight = (value / maxValue) * graphHeight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: barHeight,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
