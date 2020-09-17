import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_textField.dart';
import 'adaptative_datepicker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate;

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() async {
    DateTime dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now());
    if (dt == null) {
      return;
    }
    setState(() {
      _selectedDate = dt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: <Widget>[
                AdaptativeTextField(
                  controller: _titleController,
                  label: 'Título',
                ),
                AdaptativeTextField(
                    onSubmitted: (value) => _submitForm(),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: _valueController,
                    label: 'Valor (R\$)'),
                AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Adaptative_Button(
                      label: 'Nova transação',
                      onPressed: _submitForm,
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
