import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:scribe_lib/scribe_lib.dart';

class CharacterEditorController extends ChangeNotifier {
  final Character _character;

  final ValueChanged<Character> onSegmentUpdate;

  final List<EditableSegment> _segments;

  List<EditableSegment> get segments => List.unmodifiable(_segments);

  int? _selectedSegmentIndex;
  int? get selectedLayerIndex => _selectedSegmentIndex;

  /// a point selected with selec
  CurvePoint? _selectedPoint;
  CurvePoint? get selectedPoint => _selectedPoint;

  Tool _selectedTool = Tool.line;
  Tool get selectedTool => _selectedTool;

  EditableSegment? get selectedSegment {
    final index = _selectedSegmentIndex;
    return index != null && index < _segments.length ? _segments[index] : null;
  }

  Iterable<EditableSegment> get backgroundSegments =>
      _segments.where((element) => element != selectedSegment);

  CharacterEditorController(this._character, {required this.onSegmentUpdate})
      : _segments = _character.editableSegments,
        _selectedSegmentIndex = _character.editableSegments.isEmpty ? null : 0;

  void selectTool(Tool value) {
    _selectedTool = value;

    notifyListeners();
  }

  void addSegment() {
    _segments.add(EditableSegment([]));
    _selectedSegmentIndex = max(_segments.length - 1,0);
    _selectedPoint = null;

    //updateCharacter();
    notifyListeners();
  }

  void deleteSegment(EditableSegment deletedSegment) {
    if (selectedSegment == deletedSegment) {
      final deletedIndex = _segments.indexOf(deletedSegment);
      _selectedSegmentIndex = _segments.length > 1
          ? deletedIndex > 0
              ? deletedIndex - 1
              : deletedIndex
          : null;
      _selectedPoint == null;
    }
    _segments.removeWhere((element) => element == deletedSegment);

    notifyListeners();
  }

  void selectSegment(int index) {
    _selectedPoint = null;

    _selectedSegmentIndex = index;

    notifyListeners();
  }

  void onCanvasTap(
    TapUpDetails details, {
    required VoidCallback onFocus,
  }) {
    final segment = selectedSegment;

    if (!_selectedTool.isSelection || segment == null) return;

    try {
      final nearPoint = segment.points.firstWhere(
          (element) => (element.offset - details.localPosition).distance < 20);

      _selectedPoint = nearPoint;
      onFocus();

      //print('_LetterCanvasState._onTap...$selectedPoint');
    } catch (err) {
      debugPrint('No close point');
    }

    notifyListeners();
  }

  void startPoint(DragDownDetails details) {
    if (selectedSegment == null) return;

    switch (_selectedTool) {
      case Tool.line:
        _selectedPoint = CurvePoint(details.localPosition);
        selectedSegment!.add(_selectedPoint!);
        break;
      case Tool.cubic:
        if (selectedSegment == null) {
          _initSegment();
        }

        _selectedPoint = CurvePoint(details.localPosition);
        selectedSegment!.add(_selectedPoint!);
        break;
      case Tool.pointer:
        break;
    }

    updateCharacter();
    notifyListeners();
  }

  void _initSegment() {
    _segments.add(EditableSegment([]));
    _selectedSegmentIndex = _segments.length - 1;
  }

  void updatePoint(DragUpdateDetails details) {
    if (_selectedTool.isSelection || selectedSegment == null) return;

    final point = _selectedPoint;
    if (point != null) {
      switch (_selectedTool) {
        case Tool.line:
          _selectedPoint = CurvePoint(details.localPosition);
          break;
        case Tool.cubic:
          _selectedPoint = point.copyWith(
            anchorIn: point.offset + (point.offset - details.localPosition),
            anchorOut: details.localPosition,
          );
          break;
        case Tool.pointer:
          break;
      }

      selectedSegment!.updateLast(_selectedPoint!);
    }

    updateCharacter();
    notifyListeners();
  }

  void updateCharacter() => onSegmentUpdate(
        _character.copyWith(
          segments: _segments
              .map((e) => Segment(path: e.svg, interval: e.interval))
              .toList(),
        ),
      );

  void endPoint(DragEndDetails details) {
    updateCharacter();
  }

  void movePoint(Offset offset) {
    final segment = selectedSegment;
    final point = _selectedPoint;

    if (segment != null && point != null) {
      final updatedPoint = point.copyWith(
        position: point.offset + offset,
        anchorIn: point.anchorIn + offset,
        anchorOut: point.anchorOut + offset,
      );

      segment.replace(point, updatedPoint);
      _selectedPoint = updatedPoint;
    }

    updateCharacter();
    notifyListeners();
  }

  void updateEditPoint(DragUpdateDetails details) {
    final segment = selectedSegment;
    final point = selectedPoint;
    if (segment != null && point != null) {
      final updatedPoint = point.copyWith(
        position: point.offset + details.delta,
        anchorIn: point.anchorIn + details.delta,
        anchorOut: point.anchorOut + details.delta,
      );

      segment.replace(point, updatedPoint);
      _selectedPoint = updatedPoint;
    }

    updateCharacter();
    notifyListeners();
  }

  void updateEditAnchorIn(DragUpdateDetails details) {
    final segment = selectedSegment;
    final point = selectedPoint;
    if (segment != null && point != null) {
      final updatedPoint = point.copyWith(
        anchorIn: point.anchorIn + details.delta,
      );
      segment.replace(point, updatedPoint);
      _selectedPoint = updatedPoint;
    }

    updateCharacter();
    notifyListeners();
  }

  void updateEditAnchorOut(DragUpdateDetails details) {
    final segment = selectedSegment;
    final point = selectedPoint;
    if (segment != null && point != null) {
      final updatedPoint = point.copyWith(
        anchorOut: point.anchorOut + details.delta,
      );

      segment.replace(point, updatedPoint);
      _selectedPoint = updatedPoint;
    }

    updateCharacter();
    notifyListeners();
  }

  void updateSegmentInterval(int index, EditableSegment segment) {
    _segments.replaceRange(index, index + 1, [segment]);
    updateCharacter();
    notifyListeners();
  }
}
