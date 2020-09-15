import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  onSubmitted: (value) => _submitForm(),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _valueController,
                  decoration: InputDecoration(labelText: 'Valor (R\$)'),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data selecionada: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                      )),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Selecionar Data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _showDatePicker,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      child: Text('Nova Transaçãos'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
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
