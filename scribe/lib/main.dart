import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribe_lib/scribe_lib.dart';

import 'data/digits_sets.dart';
import 'data/latin_sets.dart';
import 'screens/character_animation/character_animation_screen.dart';
import 'tts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tts = await initTTS(
      voice: kIsWeb ? null : {"name": "Amélie", "locale": "fr-CA"});

  runApp(Provider.value(value: tts, child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      theme: mainTheme,
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(body: MenuScreen());
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scribeTheme = theme.extension<ScribeThemeData>()!;
    final textTheme = theme.textTheme;
    final h3 = textTheme.displayMedium?.apply(color: Colors.yellow);

    return Scaffold(
      backgroundColor: scribeTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Scribe',
              style: textTheme.displayLarge?.copyWith(color: Colors.white38),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CharacterAnimationScreen(
                        latinSet.variants.first,
                        mute: false,
                      ),
                    ),
                  ),
                  child: Text('ABCDEF...', style: h3),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CharacterAnimationScreen(
                        latinSet.variants.last,
                        mute: false,
                      ),
                    ),
                  ),
                  child: Text('abcdef...', style: h3),
                ),
              ],
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CharacterAnimationScreen(
                    digitSet,
                    mute: false,
                  ),
                ),
              ),
              child: Text('1234567890', style: h3),
            ),
          ],
        ),
      ),
    );
  }
}
