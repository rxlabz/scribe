import 'package:flutter/material.dart';
import 'package:scribe_lib/scribe_lib.dart';

import 'editor/editor_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ScribeEditorApp());
}

class ScribeEditorApp extends StatelessWidget {
  const ScribeEditorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scribe',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
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
    final h3 = textTheme.headline3;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CharacterEditorScreen()),
            ),
            child: Text('Editeur', style: h3),
          ),
        ],
      ),
    );
  }
}
