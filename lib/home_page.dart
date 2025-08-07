// lib/home_page.dart

// ignore_for_file: avoid_print, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant/feature_list.dart';
import 'package:voice_assistant/gemini_service.dart';
import 'package:voice_assistant/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --- State Variables ---
  bool _isSpeaking = false;
  final SpeechToText speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final GeminiService geminiService = GeminiService();
  final TextEditingController _textController = TextEditingController();

  String lastWords = '';
  String? generatedContent;
  bool isLoading = false;
  bool showFeatureBoxes = true;
  // --- End of State Variables ---

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech().then((_) {
      setState(() {
        generatedContent = "Hi, I’m Svara.\nHow can I help you?";
      });
      systemSpeak(generatedContent!);
    });
  }

  // In lib/home_page.dart

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);

    // Add these handlers to automatically track speaking status
    flutterTts.setStartHandler(() {
      setState(() {
        _isSpeaking = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("TTS Error: $msg");
        _isSpeaking = false;
      });
    });

    setState(() {});
  }

  // Add this function inside your _HomePageState class

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
    setState(() {
      _isSpeaking = false;
    });
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });

    if (result.finalResult && lastWords.isNotEmpty) {
      callGeminiAPI(prompt: lastWords);
      lastWords = ''; // Clear after sending
    }
  }

  void sendTextMessage() {
    final text = _textController.text;
    if (text.isNotEmpty) {
      callGeminiAPI(prompt: text);
      _textController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  Future<void> callGeminiAPI({required String prompt}) async {
    setState(() {
      showFeatureBoxes = false;
      isLoading = true;
      generatedContent = null;
    });

    final content = await geminiService.sendPrompt(prompt);

    setState(() {
      generatedContent = content;
      isLoading = false;
    });

    await systemSpeak(content);
  }

  Future<void> systemSpeak(String content) async {
    // To support multiple languages, we let the TTS engine decide.
    // For specific language support, you can uncomment the lines below
    // after ensuring the voice data is installed on the device.

    await flutterTts.setLanguage("kn-IN");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);

    await flutterTts.speak(content);
  }

  Future<void> _showPersonaDialog() async {
    final personaController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text('Set Assistant Persona'),
            content: TextField(
              controller: personaController,
              decoration: const InputDecoration(
                hintText: 'e.g., "You are a sarcastic pirate."',
              ),
              maxLines: 3,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  final userPersona = personaController.text;
                  if (userPersona.isNotEmpty) {
                    // We create a more robust prompt by adding a strict rule.
                    final finalPersona =
                        '$userPersona. You must strictly adhere to this persona. If the user asks a question that is outside the scope of your role, you must politely refuse to answer and gently remind them of your designated function.';

                    // Send the enhanced persona to the service
                    geminiService.setPersona(finalPersona);
                    systemSpeak(
                      "My personality has been updated and my focus is set.",
                    );
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Svara'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: _showPersonaDialog,
            icon: const Icon(Icons.psychology_outlined),
            tooltip: 'Set Persona',
          ),
        ],
      ),
      body: Column(
        children: [
          // This Expanded widget makes the content area scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  // Assistant Avatar
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            color: Pallete.assistantCircleColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Container(
                        height: 123,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/virtualAssistant.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Chat Bubble
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Pallete.borderColor),
                      borderRadius: BorderRadius.circular(
                        20,
                      ).copyWith(topLeft: Radius.zero),
                    ),
                    child: Text(
                      isLoading ? 'Thinking...' : generatedContent ?? '',
                      style: const TextStyle(
                        color: Pallete.mainFontColor,
                        fontSize: 22,
                        fontFamily: 'Cera Pro',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // CORRECTED: This 'if' block now correctly shows the features only once.
                  if (showFeatureBoxes)
                    const Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Here are a few features...',
                            style: TextStyle(
                              fontFamily: 'Cera Pro',
                              color: Pallete.mainFontColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        FeatureBox(
                          color: Pallete.firstSuggestionBoxColor,
                          headerText: 'Conversational AI',
                          descriptionText:
                              "A powerful and friendly conversational AI, powered by Google's Gemini.",
                        ),
                        FeatureBox(
                          color: Pallete.secondSuggestionBoxColor,
                          headerText: 'Custom Persona',
                          descriptionText:
                              "Change my personality on the fly using the settings icon in the top right!",
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ), // Extra space at the bottom of the scroll view
                ],
              ),
            ),
          ),

          // The fixed input bar at the bottom
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: (_) => sendTextMessage(),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    speechToText.isListening
                        ? Icons.stop_circle_outlined
                        : Icons.mic,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                  onPressed: () async {
                    if (await speechToText.hasPermission) {
                      if (speechToText.isListening) {
                        await stopListening();
                      } else {
                        await startListening();
                      }
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    // Use a ternary operator to change the icon
                    _isSpeaking ? Icons.stop_circle : Icons.send,
                    color: Pallete.blackColor,
                    size: 30,
                  ),
                  // Use a ternary operator to change the function
                  onPressed: _isSpeaking ? stopSpeaking : sendTextMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
