import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  AdaptativeDatePicker({this.onDateChanged, this.selectedDate});

  _showDatePicker(BuildContext context) async {
    DateTime dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now());
    if (dt == null) {
      return;
    }
    onDateChanged(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  selectedDate == null
                      ? 'Nenhuma data selecionada!'
                      : 'Data selecionada: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                )),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Selecionar Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _showDatePicker(context),
                )
              ],
            ),
          );
  }
}
