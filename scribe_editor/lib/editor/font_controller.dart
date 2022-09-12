import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GFontController extends ChangeNotifier {
  String currentFontName = 'Quicksand';

  late TextStyle fontStyle = GoogleFonts.getFont(currentFontName, fontSize: 24);

  updateFontStyle() {}

  void loadFont(String fontName) async {
    currentFontName = fontName;
    fontStyle = GoogleFonts.getFont(fontName, fontSize: 24);

    notifyListeners();
  }
}
