import 'package:flutter/material.dart';

class AutocompleteField extends StatelessWidget {
  const AutocompleteField({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
  }) : super(key: key);

  final FocusNode focusNode;

  final VoidCallback onFieldSubmitted;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.font_download),
          labelText: 'Font',
          suffixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
        ),
        onFieldSubmitted: (String value) => onFieldSubmitted(),
      );
}
