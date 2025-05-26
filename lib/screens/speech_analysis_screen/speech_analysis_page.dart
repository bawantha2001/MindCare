import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'result.dart'; // Import the ResultPage

class SpeechAnalysisPage extends StatefulWidget {
  const SpeechAnalysisPage({Key? key}) : super(key: key);

  @override
  State<SpeechAnalysisPage> createState() => _SpeechAnalysisPageState();
}

class _SpeechAnalysisPageState extends State<SpeechAnalysisPage> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _filePath;
  List<Map<String, dynamic>> _messages = [];
  // This list stores the server responses for later use.
  List<Map<String, dynamic>> _serverResponses = [];

  // Original questions list.
  final List<String> _questions = [
    "What did you do this morning?",
    "Can you name three things around you?",
    "What is your favorite color?",
    "Tell us a favorite childhood memory.",
    "What do you usually do in the morning?",
  ];

  // This list holds the available questions for selection.
  late List<String> _availableQuestions;

  late String _currentQuestion;
  int _questionCount = 1;
  final int _maxQuestions = 3;
  bool _finished = false; // Indicates if all questions are completed

  @override
  void initState() {
    super.initState();
    _availableQuestions = List.from(_questions); // copy original questions

    _initRecorder();
    // Ask the first question from _availableQuestions
    _currentQuestion = _getRandomQuestion();
    _messages.add({
      'text': _currentQuestion,
      'isUser': false,
      'isAudio': false,
    });
  }

  // Picks a random question from the available list and removes it.
  String _getRandomQuestion() {
    if (_availableQuestions.isNotEmpty) {
      int index = Random().nextInt(_availableQuestions.length);
      return _availableQuestions.removeAt(index);
    }
    // If none available, fallback to a random question from original list.
    return _questions[Random().nextInt(_questions.length)];
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Permission Required"),
          content: const Text(
              "Microphone permission is required to record audio. Please enable it in your settings."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            )
          ],
        ),
      );
      return;
    }
    await _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (!await Permission.microphone.isGranted) return;
    final directory = await Directory.systemTemp.createTemp();
    _filePath =
    '${directory.path}/user_audio_${DateTime.now().millisecondsSinceEpoch}.wav';
    try {
      await _recorder.startRecorder(
        toFile: _filePath,
        codec: Codec.pcm16WAV,
      );
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      debugPrint("Error starting recording: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to start recording: $e")),
      );
    }
  }

  Future<void> _stopRecordingAndSave() async {
    try {
      final path = await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });

      if (path == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("File is not uploaded. Check your connection or try again."),
          ),
        );
        return;
      }

      _filePath = path;
      _sendAudioToServer(_filePath!);
    } catch (e) {
      debugPrint("Error stopping recording: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to stop recording: $e")),
      );
    }
  }

  Future<void> _sendAudioToServer(String filePath) async {
    // Show a loading dialog while waiting for the server response.
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Dialog(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Please wait…"),
            ],
          ),
        ),
      ),
    );

    try {
      setState(() {
        _messages.add({
          'text': "Recorded Audio",
          'isUser': true,
          'isAudio': true,
        });
      });

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://20.81.156.144:8000/predict'),
      );
      request.files.add(await http.MultipartFile.fromPath('audio', filePath));

      var streamed = await request.send();
      var body = await streamed.stream.bytesToString();

      if (streamed.statusCode == 200) {
        final json = jsonDecode(body) as Map<String, dynamic>;
        final stage = json['predicted_stage'] as String? ?? 'unknown';

        // Save only the stage
        _serverResponses.add({'predictedStage': stage});
      } else {
        _serverResponses.add({
          'error': 'Server error: ${streamed.statusCode}',
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Server error—please try again."),
          ),
        );
      }
    } catch (e) {
      debugPrint("Upload error: $e");
      _serverResponses.add({'error': e.toString()});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Upload failed—check your connection."),
        ),
      );
    } finally {
      Navigator.of(context).pop(); // hide loading
      _askNextQuestion();
    }
  }

  void _askNextQuestion() {
    if (_questionCount < _maxQuestions) {
      _questionCount++;
      _currentQuestion = _getRandomQuestion();
      setState(() {
        _messages.add({
          'text': _currentQuestion,
          'isUser': false,
          'isAudio': false,
        });
      });
    } else {
      // Mark as finished and show the Next button.
      setState(() {
        _finished = true;
      });
      debugPrint("All responses saved: $_serverResponses");
    }
  }

  void _goToResultPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(serverResponses: _serverResponses),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // --- 1) Top bar with back arrow & progress ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back_ios_rounded, size: 24),
                  ),
                  const Spacer(),
                  Text(
                    'Question $_questionCount of $_maxQuestions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  // keep same space so text stays centered
                  const SizedBox(width: 24),
                ],
              ),
            ),

            // --- 2) Question text ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                _currentQuestion,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            // push mic button down
            const Spacer(),

            // --- 3) Big circular mic button ----
            GestureDetector(
              onTap: () {
                if (_isRecording) {
                  _stopRecordingAndSave();
                } else {
                  _startRecording();
                }
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: _isRecording ? Colors.redAccent : Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isRecording ? Icons.stop : Icons.mic,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // --- 4) Transcript preview ----
            if (_messages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  // show the last user-audio message’s “text”
                  _messages.last['isAudio'] == true
                      ? _messages.last['text']
                      : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),

            const Spacer(),

            // --- 5) Next button pinned at bottom ----
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: !_finished
                      ? null
                      : () {
                    _goToResultPage();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }
