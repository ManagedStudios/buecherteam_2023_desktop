import 'package:flutter/material.dart';

import '../../Resources/dimensions.dart';

class DialogTextField extends StatelessWidget {
  const DialogTextField(
      {super.key,
      required this.controller,
      required this.onTextChanged,
      required this.hint,
      required this.errorText,
      required this.enabled});

  final TextEditingController controller;
  final Function(String text) onTextChanged;
  final String hint;
  final String? errorText;

  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSmall),
      child: TextField(
        controller: controller,
        onChanged: onTextChanged,
        autocorrect: false,
        decoration: InputDecoration(
            labelText: hint,
            labelStyle: Theme.of(context).textTheme.labelMedium,
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.cornerRadiusSmall)),
            errorText: errorText,
            isDense: true),
        enabled: enabled,
      ),
    );
  }
}
