// ignore_for_file: unused_import, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:voice_assistant/feature_list.dart';
import 'package:voice_assistant/pallete.dart';
// import 'package:speech_to_text/speech_to_text.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final speechToText = SpeechToText();
  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Svara'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //virtual Assistant picture
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png'),
                    ),
                  ),
                ),
              ],
            ),

            //chat bubble to greet
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: BorderRadius.circular(
                  20,
                ).copyWith(topLeft: Radius.zero),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Hello , Good morning , How can I help?',
                  style: const TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: 25,
                    fontFamily: 'Cera Pro',
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 22),
              child: const Text(
                'Here are few commands..',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            //features list
            Column(
              children: const [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'Gemini',
                  descriptionText:
                      "Gemini is Google’s AI model that helps generate text, code, images, and more.",
                ),

                //Dall E
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: 'Dall-E',
                  descriptionText:
                      "Get inspired and stay creative with your personal assistant powered by Dall-E",
                ),

                //Smart voice assistant
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: 'Smart Voice Assistant',
                  descriptionText:
                      "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT",
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.mic, color: Colors.black),
        backgroundColor: Color.fromRGBO(209, 243, 249, 1),
      ),
    );
  }
}
