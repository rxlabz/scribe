import 'package:flutter/material.dart';
import 'package:scribe_lib/scribe_lib.dart';

class AnimationControlBar extends StatelessWidget {
  final VoidCallback clear;

  final VoidCallback animate;

  final VoidCallback play;

  final bool autoPlay;

  const AnimationControlBar({
    required this.clear,
    required this.animate,
    required this.play,
    required this.autoPlay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canGoBack = Navigator.of(context).canPop();
    final theme = Theme.of(context);
    final scribeTheme = theme.extension<ScribeThemeData>()!;
    final iconColor = scribeTheme.toolbarIconColor;

    return Row(
      mainAxisAlignment:
          canGoBack ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        if (canGoBack) ...[
          IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: iconColor),
            iconSize: 64,
            onPressed: Navigator.of(context).pop,
          ),
          const Spacer(),
        ],
        if (!autoPlay)
          IconButton(
            icon: Icon(Icons.play_circle_fill, color: iconColor),
            iconSize: 64,
            tooltip: 'Jouer l\'animation',
            onPressed: play,
          ),
        IconButton(
          icon: Icon(Icons.next_plan, color: iconColor),
          iconSize: 64,
          tooltip: 'Segment suivant',
          onPressed: animate,
        ),
        if (autoPlay)
          IconButton(
            icon: Icon(Icons.settings_backup_restore, color: iconColor),
            iconSize: 64,
            tooltip: 'Rejouer',
            onPressed: clear,
          ),
      ],
    );
  }
}
