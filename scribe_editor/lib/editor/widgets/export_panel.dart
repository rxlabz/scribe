import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../editor_controller.dart';

class ExportPanel extends StatelessWidget {
  const ExportPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CharacterEditorController>();

    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 240,
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
          color: Colors.grey.shade200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(Icons.copy),
                tooltip: 'Copy to clipboard',
                onPressed: controller.saveCharacter,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.segments.length,
                itemBuilder: (context, index) {
                  final segment = controller.segments[index];
                  return ListTile(
                    title: Text(segment.svg, style: textTheme.bodySmall),
                    dense: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
