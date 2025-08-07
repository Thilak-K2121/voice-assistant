// lib/gemini_service.dart

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:voice_assistant/secrets.dart';

class GeminiService {
  // Model and Chat will be recreated when the persona changes
  late GenerativeModel _model;
  late ChatSession _chat;

  // Store the current persona string
  String _persona = 'You are Svara, a helpful and friendly AI assistant. Keep your answers concise and clear.';

  final GenerationConfig _generationConfig = GenerationConfig(
    temperature: 0.7,
  );

  GeminiService() {
    // Initialize with the default persona
    _initializeModel();
  }
  
  // NEW: A private method to initialize or re-initialize the model and chat
  void _initializeModel() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: geminiApiKey,
      generationConfig: _generationConfig,
      // THIS IS THE CORRECT WAY TO SET THE PERSONA
      systemInstruction: Content.text(_persona),
    );
    _chat = _model.startChat();
  }

  // UPDATED: This method now updates the persona and recreates the model
  void setPersona(String newPersona) {
    _persona = newPersona;
    _initializeModel(); // Re-initialize with the new system instruction
  }

  Future<String> sendPrompt(String prompt) async {
    try {
      final response = await _chat.sendMessage(
        Content.text(prompt),
      );
      return response.text ?? 'Sorry, I could not process that. Please try again.';
    } catch (e) {
      print('An error occurred: $e');
      return 'Sorry, an error occurred while trying to connect to the service.';
    }
  }
}