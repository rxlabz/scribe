import 'package:basics/int_basics.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:quiver/iterables.dart';
import 'package:scribe_lib/scribe_lib.dart';

/// character segments animation controller
class CharacterAnimationController {
  final Character character;

  /// animation principale
  final AnimationController anim;

  CharacterAnimationController(this.character, this.anim) {
    _initSegments();
  }

  final List<Animation<double>> _segmentAnimations = [];

  List<double> get segmentAnimationsValues =>
      _segmentAnimations.map<double>((e) => e.value).toList();

  /// current animated segment index
  int _segmentIndex = 0;

  /// should pause between each segment animation
  /// or "autoplay" run the global animation
  /// Autoplay is 'true' in the first character complete animation
  bool _previewMode = false;

  /// construit une animation<double> sur l'intervalle de chaque segment
  void _initSegments() => _segmentAnimations
    ..clear()
    ..addAll(
      enumerate(character.segments).map(_buildSegmentAnimation),
    );

  /// build a linear animation on the segment interval
  Animation<double> _buildSegmentAnimation(IndexedValue<Segment> segment) {
    final subAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: anim,
        curve: Interval(
          segment.value.interval.item1,
          segment.value.interval.item2,
          curve: Curves.linear,
        ),
      ),
    );
    subAnim.addListener(_onTick);
    return subAnim;
  }

  /// à chaque tick d'un segmentAnimation
  /// - si on est à la fin ou [_previewMode] => rien
  /// - si l'animation en cours est terminée =>
  ///
  void _onTick() {
    if (_segmentIndex == _segmentAnimations.length || _previewMode) return;

    // quand l'animation du segment en cours est teminée
    if (_segmentAnimations[_segmentIndex].value == 1) {
      anim.stop();
      _segmentIndex++;
      _updateHelpersVisibility(true);
    }
  }

  /// helper(1&2) visibility flag
  final ValueNotifier<bool> showHelpers = ValueNotifier(false);
  void _updateHelpersVisibility(bool newValue) => showHelpers.value = newValue;

  void start({bool previewMode = true}) {
    _segmentIndex = 0;

    if (character.segments.length > 1) {
      _previewMode = previewMode;
      anim.addStatusListener(_disablePreviewMode);
    }

    anim
      ..reset()
      ..forward();
  }

  /// allow control bar to jump to the next segment
  /// without waiting user drawing
  void nextSegment() {
    _updateHelpersVisibility(false);
    anim.forward();
  }

  /// remove segment autoplay after playing a replay animation
  void _disablePreviewMode(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;

    anim.removeStatusListener(_disablePreviewMode);
    if (_previewMode) {
      Future.delayed(1.seconds, () => start(previewMode: false));
      _previewMode = false;
    }
  }

  /// remove segmentAnimations listener
  void dispose() {
    for (final anim in _segmentAnimations) {
      anim.removeListener(_onTick);
    }
  }

  /// resume the animation to start
  /// the next segment animation interval
  void resume() {
    _updateHelpersVisibility(false);
    anim.forward();
  }
}
