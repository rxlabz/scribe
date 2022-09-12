import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:scribe_lib/scribe_lib.dart';

import 'widgets/character_canvas.dart';
import 'widgets/character_grid_view.dart';

/// controls the character selection
/// - selected char. in the characterGgrid
/// - current animated character
class CharacterSelectionController extends ValueNotifier<Character> {
  final CharacterSet _characterSet;

  CharacterSet get characterSet => _characterSet;

  List<Character> get characters => _characterSet.characters;

  CharacterSelectionController(this._characterSet) : super(_characterSet[0]);

  /// select a new character and pronounce it
  void select(Character character) => value = character;

  /// select the next character
  void nextCharacter() {
    final index = characters.indexOf(value);
    if (index + 1 >= characters.length) return;

    select(characters[index + 1]);
  }
}

/// display the [characterSet] in a [CharactedGridView] and the [AnimatedCharacter]
/// - [autoplay]
/// - [showList] : affichage ou non de la liste de lettres
/// - [mute] : affichage ou non de la liste de lettres
class CharacterAnimationScreen extends StatelessWidget {
  //final Character? model;

  final bool showList;

  final bool autoPlay;

  final bool mute;

  final CharacterSet characterSet;

  const CharacterAnimationScreen(
    this.characterSet, {
    this.showList = true,
    this.autoPlay = true,
    this.mute = false,
    Key? key,
  }) : super(key: key);

  void pronounce(BuildContext context, Character character) =>
      context.read<FlutterTts>().speak(character.symbol.toLowerCase());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scribeTheme = theme.extension<ScribeThemeData>()!;

    final controller = CharacterSelectionController(characterSet);

    return SafeArea(
      child: Scaffold(
        backgroundColor: scribeTheme.backgroundColor,
        body: ValueListenableBuilder<Character>(
          valueListenable: controller,
          builder: (context, selectedCharacter, _) {
            if (!mute) {
              pronounce(context, selectedCharacter);
            }

            return Column(
              children: [
                if (showList)
                  CharactedGridView(
                    selectedCharacter,
                    alphabet: controller.characters,
                    onSelection: controller.select,
                  ),
                Expanded(
                  child: AnimatedCharacter(
                    selectedCharacter,
                    autoPlay: autoPlay,
                    onNextCharacter: controller.nextCharacter,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
