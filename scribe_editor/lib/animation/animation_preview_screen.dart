import 'package:flutter/material.dart';
import 'package:scribe_lib/src/model/character.dart';

class AnimatedCharacterPreview extends StatelessWidget {
  final Character character;

  const AnimatedCharacterPreview({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          BackButton(),
        ],
      ),
    );
  }
}
