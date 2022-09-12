import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../editor_controller.dart';

class LayerListView extends StatelessWidget {
  const LayerListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CharacterEditorController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: SizedBox(
        width: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NewLayerButton(onTap: controller.addLayer),
            Expanded(
              child: ReorderableListView(
                buildDefaultDragHandles: false,
                children: enumerate(controller.segments)
                    .map(
                      (e) => SegmentLayerTile(
                        e.value.points,
                        index: e.index,
                        selected: e.index == controller.selectedCurveIndex,
                        onDeleteSegment: () =>
                            controller.deleteSegment(e.value),
                        onSelection: () => controller.selectLayer(e.index),
                        key: ValueKey(e),
                      ),
                    )
                    .toList(),
                onReorder: (_, __) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewLayerButton extends StatelessWidget {
  final VoidCallback onTap;

  const NewLayerButton({Key? key, required this.onTap}) : super(key: key);

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

class SegmentLayerTile extends StatelessWidget {
  final int index;
  final List<CurvePoint> segment;
  final bool selected;
  final VoidCallback onDeleteSegment;
  final VoidCallback onSelection;

  const SegmentLayerTile(
    this.segment, {
    required this.index,
    required this.selected,
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
