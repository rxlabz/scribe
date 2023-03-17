import 'package:flutter/material.dart';

const defautlFontName = 'Quicksand';

final mainTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.cyan,
    primary: Colors.cyan.shade700,
  ),
  useMaterial3: true,
).copyWith(
  scaffoldBackgroundColor: Colors.cyan.shade600,
  appBarTheme: AppBarTheme(surfaceTintColor: Colors.white),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(),
    color: Colors.white,
    surfaceTintColor: null,
  ),
  extensions: <ThemeExtension<dynamic>>{
    ScribeThemeData(),
  },
);

class ScribeThemeData extends ThemeExtension<ScribeThemeData> {
  final Color backgroundColor;

  final Color letterListColor;

  final Color selectedLetterListColor;

  final Color toolbarIconColor;

  final Color canvasTextColor;

  final Color stepMarkerBackgroundColor;

  final Color stepMarkerActivatedBackgroundColor;

  final Color stepMarkerTextColor;

  final Color guideColor;

  final Color guidePenColor;

  const ScribeThemeData.raw({
    required this.backgroundColor,
    required this.letterListColor,
    required this.selectedLetterListColor,
    required this.toolbarIconColor,
    required this.canvasTextColor,
    required this.stepMarkerBackgroundColor,
    required this.stepMarkerActivatedBackgroundColor,
    required this.stepMarkerTextColor,
    required this.guideColor,
    required this.guidePenColor,
  });

  factory ScribeThemeData() => ScribeThemeData.raw(
        backgroundColor: Colors.cyan.shade700,
        letterListColor: Colors.white,
        selectedLetterListColor: Colors.lime,
        toolbarIconColor: Colors.yellow,
        canvasTextColor: Colors.white,
        stepMarkerBackgroundColor: Colors.cyan.shade900,
        stepMarkerActivatedBackgroundColor: Colors.greenAccent.shade700,
        stepMarkerTextColor: Colors.white,
        guideColor: Colors.green.withOpacity(.8),
        guidePenColor: Colors.green,
      );

  @override
  ThemeExtension<ScribeThemeData> copyWith({
    Color? newBackgroundColor,
    Color? newLetterListColor,
    Color? newSelectedLetterListColor,
    Color? newToolbarIconColor,
    Color? newCanvasTextColor,
    Color? newStepMarkerBackgroundColor,
    Color? newStepMarkerActivatedBackgroundColor,
    Color? newStepMarkerTextColor,
    Color? newGuideColor,
    Color? newGuidePenColor,
  }) =>
      ScribeThemeData.raw(
        backgroundColor: newBackgroundColor ?? backgroundColor,
        letterListColor: newLetterListColor ?? letterListColor,
        selectedLetterListColor:
            newSelectedLetterListColor ?? selectedLetterListColor,
        toolbarIconColor: newToolbarIconColor ?? toolbarIconColor,
        canvasTextColor: newCanvasTextColor ?? canvasTextColor,
        stepMarkerBackgroundColor:
            newStepMarkerBackgroundColor ?? stepMarkerBackgroundColor,
        stepMarkerActivatedBackgroundColor:
            newStepMarkerActivatedBackgroundColor ??
                stepMarkerActivatedBackgroundColor,
        stepMarkerTextColor: newStepMarkerTextColor ?? stepMarkerTextColor,
        guideColor: newGuideColor ?? guideColor,
        guidePenColor: newGuidePenColor ?? guidePenColor,
      );

  @override
  ThemeExtension<ScribeThemeData> lerp(
      ThemeExtension<ScribeThemeData>? other, double t) {
    if (other is! ScribeThemeData) {
      return this;
    }

    return ScribeThemeData.raw(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      letterListColor: Color.lerp(letterListColor, other.letterListColor, t) ??
          letterListColor,
      selectedLetterListColor: Color.lerp(
              selectedLetterListColor, other.selectedLetterListColor, t) ??
          letterListColor,
      toolbarIconColor: Color.lerp(
            toolbarIconColor,
            other.toolbarIconColor,
            t,
          ) ??
          toolbarIconColor,
      canvasTextColor: Color.lerp(
            canvasTextColor,
            other.canvasTextColor,
            t,
          ) ??
          canvasTextColor,
      stepMarkerBackgroundColor: Color.lerp(
            stepMarkerBackgroundColor,
            other.stepMarkerBackgroundColor,
            t,
          ) ??
          stepMarkerBackgroundColor,
      stepMarkerActivatedBackgroundColor: Color.lerp(
            stepMarkerActivatedBackgroundColor,
            other.stepMarkerActivatedBackgroundColor,
            t,
          ) ??
          stepMarkerActivatedBackgroundColor,
      stepMarkerTextColor: Color.lerp(
            stepMarkerTextColor,
            other.stepMarkerTextColor,
            t,
          ) ??
          stepMarkerTextColor,
      guideColor: Color.lerp(guideColor, other.guideColor, t) ?? guideColor,
      guidePenColor:
          Color.lerp(guidePenColor, other.guidePenColor, t) ?? guidePenColor,
    );
  }
}
