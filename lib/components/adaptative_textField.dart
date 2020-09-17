import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) onSubmitted;
  final String label;

  AdaptativeTextField(
      {this.controller, this.keyboardType, this.label, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            controller: controller,
            placeholder: label,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          )
        : TextField(
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(labelText: label));
  }
}
