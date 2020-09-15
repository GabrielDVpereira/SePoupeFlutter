import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Adaptative_Button extends StatelessWidget {
  final String label;
  final Function onPressed;

  Adaptative_Button({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Theme.of(context).primaryColor,
            child: Text(label),
            onPressed: onPressed,
          )
        : RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(label),
            onPressed: onPressed,
            textColor: Colors.white,
          );
  }
}
