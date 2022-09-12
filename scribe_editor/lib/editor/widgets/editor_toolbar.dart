import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../../animation/animation_preview_screen.dart';
import '../../fonts.dart';
import '../editor_controller.dart';
import '../font_controller.dart';
import 'autocomplete.dart';
import 'buttons.dart';

class EditorToolbar extends StatelessWidget {
  const EditorToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CharacterEditorController>();
    final fontController = context.watch<GFontController>();

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade50,
            Colors.grey.shade200,
            Colors.grey.shade600
          ],
          stops: const [.3, .98, 1],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: Navigator.of(context).pop),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 60,
                child: TextField(
                  controller: controller.characterFieldController,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: fontController.fontStyle,
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
            Padding(
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
                    (element) => element
                        .toLowerCase()
                        .contains(value.text.toLowerCase()),
                  ),
                ),
              ),
            ),
            ToggleButtons(
              fillColor: Colors.white,
              hoverColor: Colors.cyan.shade50,
              focusColor: Colors.blueGrey.shade200,
              isSelected: List.generate(
                3,
                (index) => index == controller.selectedTool.index,
              ),
              onPressed: (index) {
                if (controller.selectedTool != Tool.values[index]) {
                  controller.selectTool(Tool.values[index]);
                }
              },
              children: [
                LabelToggleButtons(
                  selected: controller.selectedTool == Tool.line,
                  icon: Icons.border_inner_outlined,
                  label: 'Line',
                ),
                LabelToggleButtons(
                  selected: controller.selectedTool == Tool.cubic,
                  icon: Icons.gesture,
                  label: 'Bézier',
                ),
                LabelToggleButtons(
                  selected: controller.selectedTool == Tool.pointer,
                  icon: Icons.arrow_upward,
                  label: 'Selection',
                ),
              ],
            ),
            const Spacer(),
            if (controller.selectedSegment != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IconButton(
                  color: Colors.blue,
                  tooltip: 'remove last point',
                  icon: const Icon(Icons.undo),
                  onPressed: controller.removeLastPoint,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton.icon(
                label: const Text('Clear'),
                icon: const Icon(Icons.clear),
                onPressed: controller.onClear,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton.icon(
                label: const Text('Animate'),
                icon: const Icon(Icons.play_circle_fill),
                onPressed: controller.animate,
              ),
            ),
            TextButton.icon(
              label: const Text('Preview'),
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AnimatedCharacterPreview(
                    character: _buildWritableCharacter(
                      controller.character,
                      controller.segments,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Character _buildWritableCharacter(
    String character,
    List<EditorSegment> segments,
  ) =>
      Character(
        character,
        segments: enumerate(segments)
            .map(
              (curve) => Segment(
                path: curve.value.svg,
                interval: curve.value
                    .interval /*Tuple2(
                  curve.index / segments.length,
                  (curve.index + 1) / segments.length,
                )*/
                ,
              ),
            )
            .toList(),
      );
}
