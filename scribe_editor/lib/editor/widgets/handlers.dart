import 'package:flutter/material.dart';
import 'package:scribe_lib/scribe_lib.dart';

class EditablePointHandle extends StatelessWidget {
  final CurvePoint point;

  const EditablePointHandle(this.point, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: pointHandleWidth,
        height: pointHandleWidth,
        decoration:
            const BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
      );
}

class EditableAnchorHandle extends StatelessWidget {
  final CurvePoint point;

  const EditableAnchorHandle(this.point, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: anchorHandleWidth,
        height: anchorHandleWidth,
        decoration: const BoxDecoration(
            color: Colors.blueAccent, shape: BoxShape.circle),
      );
}
