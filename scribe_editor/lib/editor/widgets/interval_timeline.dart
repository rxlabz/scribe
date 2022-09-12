import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../editor_controller.dart';

class IntervalTimeLine extends StatelessWidget {
  const IntervalTimeLine({super.key});

  @override
  Widget build(BuildContext context) => Column(
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
            child: Selector<CharacterEditorController, List<EditableSegment>>(
              selector: (context, controller) => controller.segments,
              builder: (context, segments, _) => ListView.separated(
                itemCount: segments.length,
                itemBuilder: (context, index) {
                  final segment = segments[index];
                  return TimelineTile(
                    index: index,
                    segment: segment,
                    key: Key('segment_$index'),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 1),
              ),
            ),
          ),
        ],
      );
}

class TimelineTile extends StatelessWidget {
  final int index;

  final EditableSegment segment;

  const TimelineTile({
    required this.segment,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: Colors.grey.shade100,
        child: Row(
          children: [
            SizedBox(
                width: 80, child: Center(child: Text('Layer ${index + 1}'))),
            Expanded(
              child: RangeSlider(
                values:
                    RangeValues(segment.interval.item1, segment.interval.item2),
                divisions: 100,
                activeColor: Colors.blueGrey,
                inactiveColor: Colors.grey.shade300,
                onChanged: (values) => context
                    .read<CharacterEditorController>()
                    .updateSegmentInterval(
                      index,
                      segment.copyWithInterval(values.start, values.end),
                    ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Center(
                child: Text(
                  '${segment.interval.item1} - ${segment.interval.item2}',
                ),
              ),
            ),
          ],
        ),
      );
}
