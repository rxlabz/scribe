import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribe_editor/editor/editor_controller.dart';
import 'package:scribe_editor/editor/font_controller.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../fonts.dart';
import 'widgets/autocomplete.dart';
import 'widgets/buttons.dart';
import 'widgets/character_editor_canvas.dart';
import 'widgets/character_list.dart';
import 'widgets/interval_timeline.dart';
import 'widgets/layer_list_view.dart';

class EditorController extends ChangeNotifier {
  CharacterSet _characterSet;

  CharacterSet get characterSet => _characterSet;

  Character? _selectedCharacter;

  Character? get selectedCharacter => _selectedCharacter;

  int? get selectedIndex => _selectedCharacter == null
      ? null
      : _characterSet.characters.indexOf(_selectedCharacter!);

  EditorController(this._characterSet)
      : _selectedCharacter = _characterSet.isEmpty ? null : _characterSet[0];

  void addCharacter(Character character) {
    _characterSet = _characterSet
        .copyWith(characters: [..._characterSet.characters, character]);

    _selectedCharacter = character;
    notifyListeners();
  }

  void selectCharacter(Character character) {
    _selectedCharacter = character;
    notifyListeners();
  }

  void updateCharacter(Character updatedCharacter) {
    if (_selectedCharacter == null) return;

    final updatedIndex = _characterSet.characters.indexWhere(
      (element) => element.symbol == updatedCharacter.symbol,
    );
    final copy = List<Character>.from(_characterSet.characters);
    copy[updatedIndex] = updatedCharacter;

    _characterSet = _characterSet.copyWith(
      characters: copy,
    );
  }
}

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode(debugLabel: 'canvasFocus');

    return Selector<EditorController, Character?>(
      selector: (context, controller) => controller.selectedCharacter,
      builder: (context, character, _) {
        if (character == null) {
          return Scaffold(
            appBar: const EditorAppBar(),
            backgroundColor: Colors.grey.shade50,
            body: Row(
              children: const [Expanded(child: CharacterList())],
            ),
          );
        }

        final editorController = CharacterEditorController(
          character,
          onSegmentUpdate: context.read<EditorController>().updateCharacter,
        );

        return ChangeNotifierProvider.value(
          value: editorController,
          child: Scaffold(
            appBar: const EditorAppBar(),
            backgroundColor: Colors.grey.shade50,
            body: EditorView(
              focus: focus,
            ),
          ),
        );
      },
    );
  }
}

class EditorView extends StatelessWidget {
  const EditorView({
    Key? key,
    required this.focus,
  }) : super(key: key);

  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditorController>();

    final fontController = context.watch<GFontController>();
    final characterStyle = fontController.fontStyle.copyWith(
      fontSize: 512,
      height: 1.1,
      color: Colors.grey.shade300,
    );

    return Row(
      children: [
        CharacterList(
          key: ValueKey(controller.characterSet.characters),
        ),
        if (controller.selectedCharacter != null) ...[
          LayerListView(
            key: ValueKey(controller.selectedCharacter),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [_Toolbar(), _FontSelector()],
                ),
                Expanded(
                  child: EditorShortcuts(
                    child: CharacterEditorCanvas(
                      focus: focus,
                      backgroundLayers: [
                        Center(
                          child: Text(
                            controller.selectedCharacter!.symbol,
                            style: characterStyle,
                          ),
                        )
                      ],
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const IntervalTimeLine(),
              ],
            ),
          ),
        ]
      ],
    );
  }
}

class _Toolbar extends StatelessWidget {
  _Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Selector<CharacterEditorController, Tool>(
        selector: (context, controller) => controller.selectedTool,
        builder: (context, selectedTool, _) => Padding(
          padding: const EdgeInsets.all(12),
          child: ToggleButtons(
            fillColor: Colors.white,
            hoverColor: Colors.cyan.shade50,
            focusColor: Colors.blueGrey.shade200,
            isSelected: List.generate(
              3,
              (index) => index == selectedTool.index,
            ),
            onPressed: (index) {
              if (selectedTool != Tool.values[index]) {
                context
                    .read<CharacterEditorController>()
                    .selectTool(Tool.values[index]);
              }
            },
            children: [
              LabelToggleButtons(
                selected: selectedTool == Tool.line,
                icon: Icons.border_inner_outlined,
                label: 'Line',
              ),
              LabelToggleButtons(
                selected: selectedTool == Tool.cubic,
                icon: Icons.gesture,
                label: 'Bézier',
              ),
              LabelToggleButtons(
                selected: selectedTool == Tool.pointer,
                icon: Icons.arrow_upward,
                label: 'Selection',
              ),
            ],
          ),
        ),
      );
}

class EditorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditorAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = context.read<EditorController>();
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 3,
      shadowColor: Colors.blueGrey.shade100,
      leading: const ScribeLogo(),
      titleSpacing: -5,
      titleTextStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text.rich(TextSpan(children: [
          const TextSpan(
              text: 'Scribe\n', style: TextStyle(color: Colors.grey)),
          TextSpan(
              text: 'alpha.0', style: TextStyle(color: Colors.grey.shade400)),
        ])),
      ),
      actions: [
        TextButton.icon(
          label: const Text('Preview'),
          icon: const Icon(Icons.edit_outlined),
          /* TODO(rxlabz) */
          onPressed: () {},
        ),
        TextButton.icon(
          label: const Text('Export'),
          icon: const Icon(Icons.save),
          /* TODO(rxlabz) */
          onPressed: () => print('${mainController._characterSet.characters}'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}

class ScribeLogo extends StatelessWidget {
  const ScribeLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: 42,
        height: 42,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: Colors.cyan.shade600),
        child: const Center(
          child: Text(
            'S',
            style: TextStyle(color: Colors.white38, fontSize: 24),
          ),
        ),
      );
}

class _FontSelector extends StatelessWidget {
  const _FontSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final fontController = context.watch<GFontController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: 280,
        child: Autocomplete<String>(
          onSelected: (value) => fontController.loadFont(value),
          fieldViewBuilder: (context, controller, focusNode, onSubmit) {
            return AutocompleteField(
              focusNode: focusNode,
              textEditingController: controller
                ..text = fontController.currentFontName,
              onFieldSubmitted: onSubmit,
            );
          },
          optionsBuilder: (value) => googleFonts.where(
            (element) =>
                element.toLowerCase().contains(value.text.toLowerCase()),
          ),
        ),
      ),
    );
  }
}
