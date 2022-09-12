import 'package:flutter/material.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../../../utils/canvas_utils.dart';

class CharacterCanvasController {
  final Character character;

  final VoidCallback onLineComplete;

  /// flag de tracé en cours => masque le painter de 1er plan
  final ValueNotifier<bool> isDrawing = ValueNotifier(false);

  void updateDrawingStatus(bool newValue) => isDrawing.value = newValue;

  final ValueNotifier<bool> successStatus = ValueNotifier(false);
  void updateSuccess(bool newValue) => successStatus.value = newValue;

  final ValueNotifier<List<Offset>> currentLine = ValueNotifier([]);

  /// updates user's current drawing
  void updateLine(DragUpdateDetails details) =>
      _addPoint(details.localPosition);

  /// add a new point to the user current drawn line
  void _addPoint(Offset point) {
    currentLine.value = [...currentLine.value, point];
  }

  /// ended users lines
  final ValueNotifier<List<List<Offset>>> lines = ValueNotifier([]);

  int get numLines => lines.value.length;

  /// user lines count
  int _lineCount = 0;

  CharacterCanvasController(this.character, {required this.onLineComplete});

  void startLine(DragDownDetails details) => updateDrawingStatus(true);

  /// when a user end a line
  /// - simplify the path
  /// - validate if the 2 targets have been hitted
  void endLine(DragEndDetails details, double scale) {
    updateDrawingStatus(false);

    final line = _simplify(currentLine.value, tolerance: tolerance);

    if (_validate(currentLine.value, character.segments[_lineCount], scale)) {
      lines.value = [...lines.value, line];
      currentLine.value = [];

      if (lines.value.length < character.segments.length) {
        _lineCount++;
        onLineComplete();
      } else {
        updateSuccess(true);
      }
    } else {
      currentLine.value = [];
    }
  }

  /// réduit le nombre de points d'une ligne par rapport à [tolerance]
  List<Offset> _simplify(List<Offset> points, {required int tolerance}) {
    // supprimer points proches
    final simplified = points.fold<List<Offset>>([], (previousValue, element) {
      if (previousValue.isEmpty) return [element];

      final distance = element - previousValue.last;

      if (distance.distance < tolerance && element != points.last) {
        return previousValue;
      }

      return [...previousValue, element];
    });
    return simplified;
  }

  /// vérifie si le tracé est validé
  bool _validate(List<Offset> line, Segment target, double scale) {
    if (line.isEmpty) return false;

    // version basique : test 1er et dernier points du tracé
    Offset startPoint = target.pathPoints.first.offset;
    Offset endPoint = target.pathPoints.last.offset;

    if ((startPoint - endPoint).distance < 30) {
      startPoint = Offset(startPoint.dx - 20, startPoint.dy);
      endPoint = Offset(endPoint.dx + 20, endPoint.dy);
    }

    // TODO vérifier que l'ensemble des points n'est pas trop éloigné de la courbe modéle
    final result = (startPoint - line.first / scale).distance < tolerance &&
        (endPoint - line.last / scale).distance < tolerance;

    return result;
  }

  void clear() {
    _lineCount = 0;
    currentLine.value = [];
    lines.value = [];

    updateSuccess(false);
  }
}
