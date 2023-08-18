import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField({
    required this.controller,
    required this.onSubmitted,
    this.keyboardType,
    required this.label,
    super.key,
  });

  final TextEditingController controller;
  final void Function() onSubmitted;
  final TextInputType? keyboardType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              onSubmitted: (_) => onSubmitted(),
              keyboardType: keyboardType,
              controller: controller,
              placeholder: label,
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
            ),
          )
        : TextField(
            onSubmitted: (_) => onSubmitted(),
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
