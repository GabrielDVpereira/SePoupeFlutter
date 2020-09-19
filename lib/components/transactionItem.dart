import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function(String) onDelete;

  TransactionItem({this.transaction, this.onDelete});

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$${transaction.value}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat(
            'd MMM Y',
          ).format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                onPressed: () => onDelete(transaction.id),
                icon: Icon(Icons.delete),
                label: Text('Excluir'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => onDelete(transaction.id),
              ),
      ),
    );
  }
}
