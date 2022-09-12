import 'package:flutter_tts/flutter_tts.dart';

Future<FlutterTts> initTTS({
  String locale = 'fr-FR',
  Map<String, String>? voice,
}) async {
  final flutterTts = FlutterTts();
  await flutterTts.setLanguage(locale);
  if (voice != null) {
    await flutterTts.setVoice(voice);
  }
  await flutterTts.setVolume(1);
  await flutterTts.setSpeechRate(.4);

  return flutterTts;
}
