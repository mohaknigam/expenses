import 'package:fintrack/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'new_transaction.dart';
import 'package:fintrack/models/transactions.dart';
import 'package:fintrack/widgets/new_transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transactions = [
    Transaction(
      title: 'New Shoes',
      amount: 69.9,
      id: 't1',
      date: DateTime.now(),
    ),
    Transaction(
      title: 'New Shirt',
      amount: 87.0,
      id: 't2',
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      id: DateTime.now().toString(),
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.insert(0, newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          addTx: _addNewTransaction,
        ),
        TransactionList(
          transactions: _transactions,
        ),
      ],
    );
  }
}
