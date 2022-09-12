import 'dart:ui';

const tolerance = 30;

ParagraphBuilder getTextBuilder(Color color) {
  final opStyle = TextStyle(
    color: color,
    fontSize: 32,
  );
  return ParagraphBuilder(ParagraphStyle(/*fontSize: 24*/))..pushStyle(opStyle);
}

/// draw [index] in a paragraph at [targetPoint] on [canvas] with [textColor]
void drawMarkerText(
  Canvas canvas,
  Offset targetPoint,
  int index,
  Color textColor,
) {
  final builder = getTextBuilder(textColor)..addText('$index');
  final indexLabel1 = builder.build()
    ..layout(const ParagraphConstraints(width: 32));

  canvas.drawParagraph(
    indexLabel1,
    targetPoint - Offset(indexLabel1.width / 4, indexLabel1.height / 2),
  );
}
