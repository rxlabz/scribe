import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../editor_controller.dart';
import '../editor_painters.dart';
import 'handlers.dart';

const canvasSize = Size(520, 560);

class EditorShortcuts extends StatelessWidget {
  final Widget child;
  const EditorShortcuts({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CharacterEditorController>();

    return FocusTraversalGroup(
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.arrowUp, shift: true): () =>
              controller.jump(const Offset(0, -10)),
          const SingleActivator(LogicalKeyboardKey.arrowDown, shift: true):
              () => controller.jump(const Offset(0, 10)),
          const SingleActivator(LogicalKeyboardKey.arrowLeft, shift: true):
              () => controller.jump(const Offset(-10, 0)),
          const SingleActivator(LogicalKeyboardKey.arrowRight, shift: true):
              () => controller.jump(const Offset(10, 0)),
          const SingleActivator(LogicalKeyboardKey.arrowUp): () =>
              controller.step(const Offset(0, -1)),
          const SingleActivator(LogicalKeyboardKey.arrowDown): () =>
              controller.step(const Offset(0, 1)),
          const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
              controller.step(const Offset(-1, 0)),
          const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
              controller.step(const Offset(1, 0)),
        },
        child: child,
      ),
    );
  }
}

class CharacterEditorCanvas extends StatelessWidget {
  final FocusNode focus;

  final Color backgroundColor;
  final List<Widget> backgroundLayers;

  const CharacterEditorCanvas({
    required this.focus,
    required this.backgroundLayers,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CharacterEditorController>()
      ..initFocus(focus);

    return Focus(
      focusNode: focus,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 7, color: Colors.grey.shade400)],
            color: backgroundColor,
          ),
          width: canvasSize.width,
          height: canvasSize.height,
          child: Stack(
            children: [
              ...backgroundLayers,
              // animated curves
              if (controller.isPlaying && controller.selectedSegment != null)
                AnimatedBuilder(
                  animation: controller.anim,
                  builder: (context, snapshot) => CustomPaint(
                    size: canvasSize,
                    painter: AnimatedSegmentsPainter(
                      controller.selectedSegment!.points,
                      controller.anim.value,
                    ),
                  ),
                ),
              // courbes/layers non sélectionnés
              if (controller.backgroundSegments.isNotEmpty)
                CustomPaint(
                  size: canvasSize,
                  painter: CurvesPainter(
                    controller.segments.map((e) => e.points),
                  ),
                ),

              // courbe sélectionnée
              GestureDetector(
                onTapUp: (details) => controller.onCanvasTap(
                  details,
                  onFocus: () => Focus.of(context).requestFocus(focus),
                ),
                onPanDown: controller.startPoint,
                onPanUpdate: controller.updatePoint,
                onPanEnd: controller.endPoint,
                child: CustomPaint(
                  size: canvasSize,
                  painter: CurvePainter(
                    controller.currentPoint ?? controller.selectedPoint,
                    controller.selectedSegment?.points ?? [],
                  ),
                ),
              ),
              // points de manipulation des points courbes
              if (controller.selectedPoint != null &&
                  controller.selectedTool.isSelection) ...[
                Positioned(
                  left: controller.selectedPoint!.offset.dx -
                      (pointHandleWidth / 2),
                  top: controller.selectedPoint!.offset.dy -
                      (pointHandleWidth / 2),
                  child: GestureDetector(
                    onPanDown: controller.startEditPoint,
                    onPanUpdate: controller.updateEditPoint,
                    onPanEnd: controller.endEditPoint,
                    child: EditablePointHandle(controller.selectedPoint!),
                  ),
                ),
                if ((controller.selectedPoint!.offset -
                                controller.selectedPoint!.anchorIn)
                            .distance >
                        5 ||
                    (controller.selectedPoint!.offset -
                                controller.selectedPoint!.anchorOut)
                            .distance >
                        5)
                  Positioned(
                    left: controller.selectedPoint!.anchorIn.dx -
                        (anchorHandleWidth / 2),
                    top: controller.selectedPoint!.anchorIn.dy -
                        (anchorHandleWidth / 2),
                    child: GestureDetector(
                      onPanDown: controller.startEditAnchorIn,
                      onPanUpdate: controller.updateEditAnchorIn,
                      onPanEnd: controller.endEditAnchorIn,
                      child: EditableAnchorHandle(controller.selectedPoint!),
                    ),
                  ),
                if ((controller.selectedPoint!.offset -
                                controller.selectedPoint!.anchorOut)
                            .distance >
                        5 ||
                    (controller.selectedPoint!.offset -
                                controller.selectedPoint!.anchorIn)
                            .distance >
                        5)
                  Positioned(
                    left: controller.selectedPoint!.anchorOut.dx -
                        (anchorHandleWidth / 2),
                    top: controller.selectedPoint!.anchorOut.dy -
                        (anchorHandleWidth / 2),
                    child: GestureDetector(
                      onPanDown: controller.startEditAnchorOut,
                      onPanUpdate: controller.updateEditAnchorOut,
                      onPanEnd: controller.endEditAnchorOut,
                      child: EditableAnchorHandle(controller.selectedPoint!),
                    ),
                  ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
