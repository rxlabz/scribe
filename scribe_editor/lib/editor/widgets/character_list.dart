import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribe_editor/editor/font_controller.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../editor_screen.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditorController>();
    final characterSet = controller.characterSet;

    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size(140, double.infinity)),
      child: Column(
        children: [
          _AddCharacterButton(),
          Expanded(
            child: ListView.builder(
              itemCount: characterSet.characters.length,
              itemBuilder: (context, index) {
                final char = characterSet.characters[index];

                return InkWell(
                  onTap: () => controller.selectCharacter(char),
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 42,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(char.symbol),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _AddCharacterButton extends StatelessWidget {
  final TextEditingController fieldController = TextEditingController();

  _AddCharacterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final fontStyle = context.read<GFontController>().fontStyle;
    final controller = context.read<EditorController>();

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: SizedBox(
            width: 60,
            child: TextField(
              controller: fieldController,
              maxLength: 1,
              textAlign: TextAlign.center,
              style: fontStyle,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                isDense: true,
                counterText: '',
              ),
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: fieldController,
          builder: (context, field, _) => IconButton(
            onPressed: field.text.isEmpty
                ? null
                : () => controller.addCharacter(
                      Character(
                        fieldController.text,
                        segments: [
                          const Segment(path: '', interval: defaultInterval),
                        ],
                      ),
                    ),
            icon: Icon(Icons.add, color: Colors.cyan.shade600),
          ),
        ),
      ],
    );
  }
}
