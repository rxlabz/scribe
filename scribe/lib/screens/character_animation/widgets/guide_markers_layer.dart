import 'package:flutter/material.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../painters/guide_marker_painter.dart';
import 'character_canvas_controller.dart';

class GuideMarkerLayer extends StatelessWidget {
  final CharacterCanvasController controller;

  final Size size;

  final double scale;

  final List<Segment> segments;

  const GuideMarkerLayer({
    required this.size,
    required this.scale,
    required this.segments,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: ValueListenableBuilder<List<List<Offset>>>(
            // count the  user drawn lines to hide when complete
            valueListenable: controller.lines,
            builder: (context, lines, _) =>
                ValueListenableBuilder<List<Offset>>(
              // watch the user current drawing to detect validated targets
              valueListenable: controller.currentLine,
              builder: (context, line, _) => lines.length == segments.length
                  ? const SizedBox.shrink()
                  : _GuideMarkersView(
                      line: line,
                      segment: segments[lines.length],
                      size: size,
                      scale: scale,
                    ),
            ),
          ),
        ),
      );
}

class _GuideMarkersView extends StatelessWidget {
  final Size size;

  final double scale;

  final Segment segment;

  final List<Offset> line;

  const _GuideMarkersView({
    required this.line,
    required this.segment,
    required this.size,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scribeTheme = theme.extension<ScribeThemeData>()!;

    final backgroundColor = scribeTheme.stepMarkerBackgroundColor;
    final activatedBackgroundColor =
        scribeTheme.stepMarkerActivatedBackgroundColor;
    final textColor = scribeTheme.stepMarkerTextColor;

    return CustomPaint(
      size: size,
      painter: NumerotedGuideMarkerPainter(
        segment,
        line,
        scale: scale,
        backgroundColor: backgroundColor,
        activatedBackgroundColor: activatedBackgroundColor,
        textColor: textColor,
      ),
    );
  }
}
