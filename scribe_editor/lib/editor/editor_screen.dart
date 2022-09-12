import 'package:basics/basics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'editor_controller.dart';
import 'font_controller.dart';
import 'widgets/character_editor_canvas.dart';
import 'widgets/editor_toolbar.dart';
import 'widgets/export_panel.dart';
import 'widgets/interval_timeline.dart';
import 'widgets/layer_list_view.dart';

class CharacterEditorScreen extends StatelessWidget {
  const CharacterEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CharacterEditorController();
    final fontController = GFontController();

    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: controller),
          ChangeNotifierProvider.value(value: fontController),
        ],
        child: const CharacterEditorView(),
      ),
    );
  }
}

class CharacterEditorView extends StatefulWidget {
  const CharacterEditorView({super.key});

  @override
  CharacterEditorViewState createState() => CharacterEditorViewState();
}

class CharacterEditorViewState extends State<CharacterEditorView>
    with SingleTickerProviderStateMixin {
  late final AnimationController anim = AnimationController(
    duration: 3.seconds,
    vsync: this,
  );

  @override
  void dispose() {
    anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CharacterEditorController>();
    final fontController = context.watch<GFontController>();

    if (!controller.initialized) {
      controller.initAnimation(anim);
    }

    final characterStyle = fontController.fontStyle.copyWith(
      fontSize: 512,
      height: 1.1,
      color: Colors.grey.shade300,
    );

    return Column(
      children: [
        FocusTraversalGroup(child: const EditorToolbar()),
        Expanded(
          child: Row(
            children: [
              const LayerListView(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: EditorShortcuts(
                        child: CharacterEditorCanvas(
                          backgroundColor: Colors.white,
                          focus: FocusNode(),
                          backgroundLayers: [
                            // character
                            Selector<CharacterEditorController, String>(
                              selector: (context, controller) =>
                                  controller.character,
                              builder: (context, value, _) {
                                return Center(
                                  child: Text(
                                    controller.characterFieldController.text,
                                    style: characterStyle,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const IntervalTimeLine()
                  ],
                ),
              ),
              const ExportPanel(),
            ],
          ),
        ),
      ],
    );
  }
}
