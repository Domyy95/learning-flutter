import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required Transaction this.transaction,
    required this.deleteTrx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTrx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor = Colors.black;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
      Colors.yellow
    ];
    _bgColor = availableColors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(child: Text('\$${widget.transaction.amount}')),
          ),
        ),
        title: Text(widget.transaction.title,
            style: Theme.of(context).textTheme.headline1),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () => widget.deleteTrx(widget.transaction.id),
                icon: Icon(Icons.delete),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Theme.of(context).errorColor)),
                label: const Text('Delete'))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTrx(widget.transaction.id),
              ),
      ),
    );
  }
}
