import 'package:fintrack/models/transactions.dart';
import 'package:fintrack/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:fintrack/main.dart';

import 'chart.dart';
import 'new_transaction.dart';

class PageBody extends StatefulWidget {
  void startAddingNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
            addTx: addNewTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  _PageBodyState createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  final List<Transaction> transactions = [
    Transaction(
        title: 'New Shows',
        id: DateTime.now().toString(),
        amount: 23,
        date: DateTime.now()),
    Transaction(
        title: 'New Shoes',
        id: DateTime.now().toString(),
        amount: 24,
        date: DateTime.now()),
    Transaction(
        title: 'New Shirt',
        id: DateTime.now().toString(),
        amount: 30,
        date: DateTime.now()),
    Transaction(
        title: 'New cow',
        id: DateTime.now().toString(),
        amount: 34,
        date: DateTime.now()),
    Transaction(
        title: 'New Shall',
        id: DateTime.now().toString(),
        amount: 21,
        date: DateTime.now()),
    Transaction(
        title: 'New town',
        id: DateTime.now().toString(),
        amount: 42,
        date: DateTime.now()),
    Transaction(
        title: 'New Shows2',
        id: DateTime.now().toString(),
        amount: 25,
        date: DateTime.now()),
    Transaction(
        title: 'New Shows3',
        id: DateTime.now().toString(),
        amount: 213,
        date: DateTime.now()),
  ];

  bool showChart = false;

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      id: DateTime.now().toString(),
      amount: txAmount,
      date: chosenDate,
    );

    setState(
      () {
        transactions.insert(0, newTx); // to insert new element at top always
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;

    final appBar = AppBar(
      actions: [
        IconButton(
          splashColor: Colors.yellow,
          iconSize: 30,
          icon: Icon(Icons.add),
          onPressed: () => startAddingNewTransaction(context),
          color: Colors.yellow,
        ),
      ],
      title: Text(
        'FinTrack',
      ),
      centerTitle: true,
    );

    final txListWidget = Container(
      height: (media.size.height -
              appBar.preferredSize.height -
              media.padding.top) *
          0.65, //65%
      child: TransactionList(
        transactions: transactions,
        deleteTx: deleteTransaction,
      ),
    );

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    value: showChart,
                    onChanged: (val) {
                      setState(() {
                        showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (media.size.height -
                        appBar.preferredSize.height -
                        media.padding.top) *
                    0.35, //35%
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              showChart
                  ? Container(
                      height: (media.size.height -
                              appBar.preferredSize.height -
                              media.padding.top) *
                          0.7, //35%
                      child: Chart(
                        recentTransactions: _recentTransactions,
                      ),
                    )
                  : txListWidget,
          ],
        ),
      ),
    );
  }
}
