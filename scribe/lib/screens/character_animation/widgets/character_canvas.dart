import 'package:basics/int_basics.dart';
import 'package:flutter/material.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../character_animation_controller.dart';
import '../painters/animated_segments_painter.dart';
import '../painters/painters.dart';
import 'animation_control_bar.dart';
import 'character_canvas_controller.dart';
import 'guide_markers_layer.dart';

/* FIXME(rxlabz) remove static size*/
const _size = Size(520, 520);

class AnimatedCharacter extends StatefulWidget {
  final Character character;

  final bool autoPlay;

  final VoidCallback onNextCharacter;

  const AnimatedCharacter(
    this.character, {
    required this.onNextCharacter,
    this.autoPlay = true,
    Key? key,
  }) : super(key: key);

  @override
  AnimatedCharacterState createState() => AnimatedCharacterState();
}

class AnimatedCharacterState extends State<AnimatedCharacter>
    with TickerProviderStateMixin {
  /// main animation
  late AnimationController _anim;

  late CharacterAnimationController controller;

  late CharacterCanvasController canvasController;

  @override
  void initState() {
    super.initState();
    initCharacter(widget.character);
  }

  /// start the animation of [char]
  /// instanciate a new [AnimationController] and a new [CharacterAnimationController]
  ///
  void initCharacter(Character char) {
    _anim = AnimationController(
      duration: Duration(milliseconds: char.duration),
      vsync: this,
    );

    controller = CharacterAnimationController(char, _anim);

    canvasController =
        CharacterCanvasController(char, onLineComplete: controller.resume);

    canvasController.successStatus.addListener(() {
      if (canvasController.successStatus.value) {
        Future.delayed(1.seconds, () => openNextChar(char));
      }
    });

    if (widget.autoPlay) {
      Future.delayed(1.seconds, startAnimation);
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedCharacter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.character != widget.character) {
      initCharacter(widget.character);
    }
  }

  void startAnimation() {
    controller.start();
    canvasController.clear();
  }

  void openNextChar(Character letter) => widget.onNextCharacter();

  @override
  void dispose() {
    _anim.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AnimationControlBar(
            clear: () => controller.start(previewMode: false),
            animate: controller.nextSegment,
            play: startAnimation,
            autoPlay: widget.autoPlay,
          ),
          Flexible(
            child: ValueListenableBuilder<bool>(
              valueListenable: canvasController.successStatus,
              builder: (context, succeed, snapshot) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final scale = constraints.maxHeight / _size.height;
                    final size = _size * scale;

                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      /* FIXME(rxlabz) try to remove the transformation*/
                      child: Transform.translate(
                        offset: const Offset(-50, -80),
                        child: _CharactereCanvas(
                          animController: controller,
                          canvasController: canvasController,
                          scale: scale,
                          size: size,
                          anim: _anim,
                          succeed: succeed,
                          showHelpers: controller.showHelpers,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
}

/// stack containing various layers
/// - gestureDetector
/// - character
/// - animated paths
/// - helper anchor
/// - previously drawn lines
/// - currently drawned line
class _CharactereCanvas extends StatelessWidget {
  final CharacterAnimationController animController;

  final CharacterCanvasController canvasController;

  final double scale;

  final Size size;

  final bool succeed;

  final ValueNotifier<bool> showHelpers;

  final AnimationController anim;

  const _CharactereCanvas({
    Key? key,
    required this.canvasController,
    required this.animController,
    required this.scale,
    required this.size,
    required this.anim,
    required this.showHelpers,
    required this.succeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scribeTheme = theme.extension<ScribeThemeData>()!;

    final character = canvasController.character;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (!succeed)
          GestureDetector(
            onPanDown: canvasController.startLine,
            onPanUpdate: canvasController.updateLine,
            onPanEnd: (details) => canvasController.endLine(details, scale),
            child: CustomPaint(
              size: size,
              painter: CharacterPainter(
                canvasController.character,
                scale: scale,
                textColor: scribeTheme.canvasTextColor,
              ),
            ),
          ),
        if (!succeed)
          IgnorePointer(
            // animation lettre
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: AnimatedBuilder(
                animation: anim,
                builder: (context, widget) => CustomPaint(
                  size: size,
                  painter: AnimatedSegmentsPainter(
                    canvasController.character,
                    animationProgressList:
                        animController.segmentAnimationsValues,
                    scale: scale,
                    guideColor: scribeTheme.guideColor,
                    guidePenColor: scribeTheme.guidePenColor,
                  ),
                ),
              ),
            ),
          ),
        // segments dessinés par l'utilisateur
        ValueListenableBuilder<List<List<Offset>>>(
          valueListenable: canvasController.lines,
          builder: (context, lines, snapshot) {
            return IgnorePointer(
              child: Center(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: CustomPaint(
                    size: size,
                    painter: UserPainter(lines, succeed: succeed),
                  ),
                ),
              ),
            );
          },
        ),
        // cibles 1 & 2
        ValueListenableBuilder<bool>(
          valueListenable: showHelpers,
          builder: (context, showHelpers, snapshot) => !succeed && showHelpers
              ? GuideMarkerLayer(
                  size: size,
                  controller: canvasController,
                  scale: scale,
                  segments: character.segments,
                )
              : const SizedBox.shrink(),
        ),
        // tracé en cours
        ValueListenableBuilder<bool>(
          valueListenable: canvasController.isDrawing,
          builder: (context, lines, snapshot) {
            return IgnorePointer(
              child: Center(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: ValueListenableBuilder<List<Offset>>(
                    valueListenable: canvasController.currentLine,
                    builder: (context, lines, snapshot) {
                      return CustomPaint(
                        size: size,
                        painter: UserPainter([lines], succeed: succeed),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
