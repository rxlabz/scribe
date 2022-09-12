import 'package:flutter/material.dart';
import 'package:scribe_lib/scribe_lib.dart';

class CharactedGridView extends StatelessWidget {
  final Character? selection;

  final List<Character> alphabet;

  final ValueChanged<Character> onSelection;

  const CharactedGridView(
    this.selection, {
    required this.alphabet,
    required this.onSelection,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
        children: alphabet
            .map(
              (character) => LetterGridItem(
                character.symbol,
                selected: character == selection,
                onTap: () => onSelection(character),
              ),
            )
            .toList(),
      );
}

class LetterGridItem extends StatelessWidget {
  final String letter;

  final bool selected;

  final VoidCallback onTap;

  const LetterGridItem(
    this.letter, {
    required this.onTap,
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    final scribeTheme = theme.extension<ScribeThemeData>()!;
    final style = textTheme.headline2?.copyWith(
      color: selected
          ? scribeTheme.selectedLetterListColor
          : scribeTheme.letterListColor,
    );

    return SizedBox(
      width: (size.width ~/ 13).toDouble(),
      height: (size.height ~/ 10).toDouble(),
      child: Center(
        child: TextButton(
          onPressed: onTap,
          child: Text(letter, style: style),
        ),
      ),
    );
  }
}
