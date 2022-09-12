import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../editor_controller.dart';

class IntervalTimeLine extends StatelessWidget {
  const IntervalTimeLine({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CharacterEditorController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ColoredBox(
          color: Colors.grey.shade400,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Intervals'),
          ),
        ),
        Container(
          height: 120,
          color: Colors.grey.shade300,
          child: ListView.separated(
            itemCount: controller.segments.length,
            itemBuilder: (context, index) {
              final segment = controller.segments[index];
              return TimelineTime(
                index: index,
                segment: segment,
                key: ValueKey(segment),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class TimelineTime extends StatelessWidget {
  final int index;

  final EditorSegment segment;

  const TimelineTime({required this.segment, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CharacterEditorController>();

    return ColoredBox(
      color: Colors.grey.shade100,
      child: Row(
        children: [
          SizedBox(width: 80, child: Center(child: Text('Layer ${index + 1}'))),
          Expanded(
            child: RangeSlider(
              values:
                  RangeValues(segment.interval.item1, segment.interval.item2),
              divisions: 100,
              activeColor: Colors.blueGrey,
              inactiveColor: Colors.grey.shade300,
              onChanged: (values) => controller.updateSegmentInterval(
                index,
                segment.copyWithInterval(values.start, values.end),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Center(
              child:
                  Text('${segment.interval.item1} - ${segment.interval.item2}'),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
