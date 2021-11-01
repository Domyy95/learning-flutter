import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  Function deleteTrx;

  TransactionList(this._userTransactions, this.deleteTrx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _userTransactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No trasactions added yet!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView(
              children: _userTransactions
                  .map(
                    (tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTrx: deleteTrx,
                    ),
                  )
                  .toList()),
    );
  }
}
