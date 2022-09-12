import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:scribe_lib/scribe_lib.dart';

class CharacterEditorController extends ChangeNotifier {
  String _character;

  String get character => _character;

  final TextEditingController characterFieldController =
      TextEditingController();

  final TextEditingController fontController = TextEditingController();

  CurvePoint? _currentPoint;

  CurvePoint? get currentPoint => _currentPoint;

  CurvePoint? previousPoint;

  Tool _selectedTool = Tool.line;
  Tool get selectedTool => _selectedTool;

  final List<EditorSegment> segments = [];

  EditorSegment? selectedSegment;

  int selectedCurveIndex = 0;

  CurvePoint? selectedPoint;

  late final AnimationController _anim;
  AnimationController get anim => _anim;

  bool initialized = false;

  bool isPlaying = false;

  String currentFontName = 'Quicksand';

  CharacterEditorController({String initialCharacter = 'A'})
      : _character = initialCharacter {
    init();
  }

  Iterable<EditorSegment> get backgroundSegments =>
      segments.where((element) => element != selectedSegment);

  void init() {
    characterFieldController.text = _character;
    characterFieldController.addListener(
      () {
        _character = characterFieldController.text;
        notifyListeners();
      },
    );

    _initSegment();
  }

  void initAnimation(AnimationController anim) {
    _anim = anim;
    initialized = true;
  }

  void animate() {
    _anim.reset();
    isPlaying = true;
    _anim.forward();
    notifyListeners();
  }

  void selectTool(Tool value) {
    _currentPoint = null;
    _selectedTool = value;

    if (value != Tool.pointer) {
      final segment = EditorSegment.create(selectedTool);
      selectedSegment = segment;
      segments[selectedCurveIndex] = segment;
    }

    notifyListeners();
  }

  void _initSegment() {
    final segment = EditorSegment.create(selectedTool);
    selectedSegment = segment;
    segments.add(segment);
  }

  void startPoint(DragDownDetails details) {
    if (selectedSegment == null) return;

    debugPrint('_LetterCanvasState._startPoint... ');
    switch (selectedTool) {
      case Tool.line:
        if (_currentPoint != null) {
          previousPoint = currentPoint;
        }
        _currentPoint = CurvePoint(details.localPosition);
        selectedSegment!.add(currentPoint!);
        break;
      case Tool.cubic:
        if (selectedSegment == null) {
          _initSegment();
        }

        if (currentPoint != null) {
          previousPoint = currentPoint;
        }
        _currentPoint = CurvePoint(details.localPosition);
        selectedSegment!.add(currentPoint!);
        break;
      case Tool.pointer:
        break;
    }
    debugPrint('_LetterCanvasState._startPoint...$selectedSegment ');
    notifyListeners();
  }

  void updatePoint(DragUpdateDetails details) {
    if (selectedTool.isSelection || selectedSegment == null) return;

    final point = currentPoint;
    if (point != null) {
      switch (selectedTool) {
        case Tool.line:
          _currentPoint = CurvePoint(details.localPosition);
          break;
        case Tool.cubic:
          _currentPoint = point.copyWith(
            anchorIn: point.offset + (point.offset - details.localPosition),
            anchorOut: details.localPosition,
          );
          break;
        case Tool.pointer:
          break;
      }

      selectedSegment!.updateLast(currentPoint!);
    }
    notifyListeners();
  }

  void removeLastPoint() {
    final segment = selectedSegment;
    if (segment?.isNotEmpty != true) return;

    segments[selectedCurveIndex] = segment!.copyWithPoints(
      segment.removeLast(),
    );
    notifyListeners();
  }

  /* TODO(rxlabz) */
  void endPoint(DragEndDetails details) {
    if (selectedTool.isSelection) return;
  }

  /* TODO(rxlabz) */
  void startEditPoint(DragDownDetails details) {}

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
      selectedPoint = updatedPoint;
    }

    notifyListeners();
  }

  /* TODO(rxlabz) */
  void endEditPoint(DragEndDetails details) {}

  /* TODO(rxlabz) */
  void startEditAnchorIn(DragDownDetails details) {}

  void updateEditAnchorIn(DragUpdateDetails details) {
    final segment = selectedSegment;
    final point = selectedPoint;
    if (segment != null && point != null) {
      final updatedPoint = point.copyWith(
        anchorIn: point.anchorIn + details.delta,
      );
      segment.replace(point, updatedPoint);
      selectedPoint = updatedPoint;
    }
    notifyListeners();
  }

  /* TODO(rxlabz) */
  void endEditAnchorIn(DragEndDetails details) {}

  /* TODO(rxlabz) */
  void startEditAnchorOut(DragDownDetails details) {}

  void updateEditAnchorOut(DragUpdateDetails details) {
    final segment = selectedSegment;
    final point = selectedPoint;
    if (segment != null && point != null) {
      final updatedPoint = point.copyWith(
        anchorOut: point.anchorOut + details.delta,
      );

      segment.replace(point, updatedPoint);
      selectedPoint = updatedPoint;
    }
    notifyListeners();
  }

  /* TODO(rxlabz) */
  void endEditAnchorOut(DragEndDetails details) {}

  void onClear() {
    segments.clear();

    selectedPoint = null;
    isPlaying = false;
    _currentPoint = null;
    selectedSegment?.clear();

    addLayer();

    notifyListeners();
  }

  void savePath() {
    final segment = selectedSegment;
    if (segment?.isNotEmpty != true) return;

    Clipboard.setData(ClipboardData(text: selectedSegment!.svg));
  }

  void saveCharacter() {
    if (segments.isEmpty) return;

    final svgSegments =
        segments.where((element) => element.isNotEmpty).map((e) => e.svg);

    final data = ''' const char_${characterFieldController.text} = Character(
  '${characterFieldController.text}',
  duration: 2,
  segments: [
    ${svgSegments.map((e) => "Segment(path:'$e',interval:Tuple2(0,1),),").join('\n')}
  ],
);''';

    Clipboard.setData(ClipboardData(text: data));
  }

  void addLayer() {
    segments.add(EditorSegment.create(selectedTool));
    selectedCurveIndex = segments.length - 1;
    selectedSegment = segments[segments.length - 1];
    selectedPoint = null;
    _currentPoint = null;

    notifyListeners();
  }

  void selectLayer(int index) {
    selectedPoint = null;
    _currentPoint = null;

    selectedCurveIndex = index;
    selectedSegment = segments[index];

    notifyListeners();
  }

  void onCanvasTap(
    TapUpDetails details, {
    required VoidCallback onFocus,
  }) {
    final segment = selectedSegment;

    if (!selectedTool.isSelection || segment == null) return;

    try {
      final nearPoint = segment.points.firstWhere(
          (element) => (element.offset - details.localPosition).distance < 20);

      selectedPoint = nearPoint;
      onFocus();

      //print('_LetterCanvasState._onTap...$selectedPoint');
    } catch (err) {
      debugPrint('No close point');
    }

    notifyListeners();
  }

  void deleteSegment(EditorSegment deletedCurve) {
    if (selectedSegment == deletedCurve) {
      selectedSegment = null;
      selectedPoint == null;
      _currentPoint = null;
    }
    segments.removeWhere((element) => element == deletedCurve);

    notifyListeners();
  }

  void step(Offset offset) {
    if (!selectedTool.isSelection) return;

    final segment = selectedSegment;
    final point = selectedPoint;
    if (segment != null && point != null) {
      final updatedPoint = point.copyWith(
        position: point.offset + offset,
        anchorIn: point.anchorIn + offset,
        anchorOut: point.anchorOut + offset,
      );

      segment.replace(point, updatedPoint);
      selectedPoint = updatedPoint;
    }
    notifyListeners();
  }

  void jump(Offset offset) {
    if (!selectedTool.isSelection) return;

    final segment = selectedSegment;
    final point = selectedPoint;
    if (segment != null && point != null) {
      Offset delta = Offset.zero;

      delta = offset;

      final updatedPoint = point.copyWith(
        position: point.offset + delta,
        anchorIn: point.anchorIn + delta,
        anchorOut: point.anchorOut + delta,
      );

      segment.replace(point, updatedPoint);
      selectedPoint = updatedPoint;
    }
    notifyListeners();
  }

  FocusNode? _focusNode;

  initFocus(FocusNode focus) {
    _focusNode = focus;
  }

  void updateSegmentInterval(int index, EditorSegment segment) {
    segments.replaceRange(index, index + 1, [segment]);
    notifyListeners();
  }
}
