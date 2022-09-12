import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../editor_controller.dart';

class LayerListView extends StatelessWidget {
  const LayerListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CharacterEditorController>();

    return Container(
      constraints: BoxConstraints.loose(const Size(240, double.infinity)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: Colors.grey.shade300),
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _NewLayerButton(onTap: controller.addSegment),
          Expanded(
            child: Selector<CharacterEditorController, List<EditableSegment>>(
              selector: (context, controller) => controller.segments,
              builder: (context, segments, _) => ReorderableListView.builder(
                itemCount: math.max(segments.length, 1),
                buildDefaultDragHandles: false,
                itemBuilder: (context, index) {
                  if (segments.isEmpty) {
                    return _SegmentLayerTile(
                      index: index,
                      selected: true,
                      onDeleteSegment: () {},
                      onSelection: () {},
                      deletable: false,
                      key: const Key('Empty segment'),
                    );
                  }

                  final segment = segments[index];
                  return _SegmentLayerTile(
                    index: index,
                    selected: index == controller.selectedLayerIndex,
                    onDeleteSegment: () => controller.deleteSegment(segment),
                    onSelection: () => controller.selectSegment(index),
                    deletable: segments.length > 1,
                    key: ValueKey(segment),
                  );
                },
                onReorder: (_, __) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewLayerButton extends StatelessWidget {
  final VoidCallback onTap;

  const _NewLayerButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade100, Colors.grey.shade300],
            stops: const [.8, .95, 1],
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: TextButton.icon(
          label: const Text('New layer'),
          icon: const Icon(Icons.library_add),
          onPressed: onTap,
        ),
      );
}

class _SegmentLayerTile extends StatelessWidget {
  final int index;
  final bool selected;
  final bool deletable;
  final VoidCallback onDeleteSegment;
  final VoidCallback onSelection;

  const _SegmentLayerTile({
    required this.index,
    required this.selected,
    required this.deletable,
    required this.onDeleteSegment,
    required this.onSelection,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onSelection,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(Icons.drag_indicator, color: Colors.grey.shade400),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Layer ${index + 1}',
                    style: TextStyle(
                      color: selected ? theme.primaryColor : Colors.black,
                    ),
                  ),
                ),
              ),
              if (deletable)
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.orange.shade300),
                  onPressed: onDeleteSegment,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
