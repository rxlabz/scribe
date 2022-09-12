import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribe_lib/scribe_lib.dart';

import 'editor/editor_screen.dart';
import 'editor/font_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final fontController = GFontController();
  runApp(ScribeEditorApp(fontController: fontController));
}

class ScribeEditorApp extends StatelessWidget {
  final GFontController fontController;

  const ScribeEditorApp({required this.fontController, super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: fontController,
        child: MaterialApp(
          title: 'Scribe',
          theme: mainTheme,
          debugShowCheckedModeBanner: false,
          home: const MainScreen(),
        ),
      );
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: MenuScreen());
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final h1 = textTheme.displayMedium;
    final h3 = textTheme.titleMedium;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Scribe', style: h1),
          ElevatedButton.icon(
            onPressed: () {
              final controller = EditorController(
                const CharacterSet(name: '', characters: []),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: controller,
                    child: const EditorScreen(),
                  ),
                ),
              );
            },
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.create_new_folder, size: 42),
            ),
            label: Text('Create a new Character set', style: h3),
          ),
          /*ElevatedButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CharacterEditorScreen(
                  characterSet: CharacterSet(
                    name: '',
                    characters: [],
                  ),
                ),
              ),
            ),
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.create_new_folder, size: 42),
            ),
            label: Text('Editor', style: h3),
          ),*/
          /*ElevatedButton.icon(
            onPressed: () {
              // select and parse json file

              // send the set to edit screen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CharacterEditorScreen(),
                ),
              );
            },
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.folder_open, size: 42),
            ),
            label: Text('Open a Character set', style: h3),
          ),*/
        ],
      ),
    );
  }
}

