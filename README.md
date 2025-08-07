
# Svara - A Conversational AI Voice Assistant 🤖

Svara is a sleek, modern voice assistant for Android & iOS, built with Flutter and powered by Google's Gemini API. Engage in natural conversations, set custom personalities for the assistant, and get answers in multiple languages.

\<br\>

<img width="528" height="1151" alt="image" src="https://github.com/user-attachments/assets/b3600aa9-a561-4234-94af-f55bbb30b0b0" />

\`\`

-----

## ✨ Features

  * **🧠 Conversational AI:** Get intelligent and context-aware answers from Google's Gemini model.
  * **🎙️ Voice & Text Input:** Interact with your voice using the speech-to-text engine or type your queries directly.
  * **🗣️ Text-to-Speech:** Listen to the assistant's responses in a natural-sounding voice.
  * **🌐 Multi-language Support:** The app is configured to handle English and Kannada, with the ability to expand.
  * **🎭 Custom Personas:** Make the assistant a pirate, a chef, or anything you can imagine\! The persona feature allows you to set a system-level instruction for the AI to follow.
  * **⏹️ Stop Speaking:** Interrupt the assistant at any time with a dedicated stop button.

-----

## 🛠️ Tech Stack & Packages

  * **Framework:** [Flutter](https://flutter.dev/)
  * **Language:** [Dart](https://dart.dev/)
  * **AI Model:** [Google Gemini API](https://ai.google.dev/)
  * **State Management:** `setState`
  * **Packages:**
      * [`google_generative_ai`](https://www.google.com/search?q=%5Bhttps://pub.dev/packages/google_generative_ai%5D\(https://pub.dev/packages/google_generative_ai\))
      * [`speech_to_text`](https://www.google.com/search?q=%5Bhttps://pub.dev/packages/speech_to_text%5D\(https://pub.dev/packages/speech_to_text\))
      * [`flutter_tts`](https://www.google.com/search?q=%5Bhttps://pub.dev/packages/flutter_tts%5D\(https://pub.dev/packages/flutter_tts\))

-----

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing.

### Prerequisites

  * Flutter SDK installed on your machine.
  * An IDE like VS Code or Android Studio.
  * A Google Gemini API Key.

### Installation & Setup

1.  **Clone the repository:**

    ```sh
    git clone https://github.com/Thilak-K2121/voice-assistant.git
    ```

2.  **Navigate to the project directory:**

    ```sh
    cd voice-assistant
    ```

3.  **Install dependencies:**

    ```sh
    flutter pub get
    ```

4.  **Add your API Key:**

      * Inside the `lib/` folder, create a new file named `secrets.dart`.
      * Add the following line to it:
        ```dart
        const String geminiApiKey = 'YOUR_GEMINI_API_KEY';
        ```
      * Replace `YOUR_GEMINI_API_KEY` with your actual key from Google AI Studio.
      * *Note: This file is listed in `.gitignore` and will not be pushed to GitHub.*

5.  **Run the app:**

    ```sh
    flutter run
    ```

-----

## Usage

  * Use the **microphone button** 🎙️ to start and stop voice input.
  * Use the **text field** to type queries and the **send button** ➡️ to submit them.
  * Tap the **persona icon** 🧠 in the app bar to set a custom personality for the assistant. This instruction will be strictly followed.
  * Tap the **stop button** ⏹️ to interrupt the assistant while it's speaking.

-----

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details.

-----

Built with ❤️ and Flutter.
