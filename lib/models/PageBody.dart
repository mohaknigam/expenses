import 'package:fintrack/models/transactions.dart';
import 'package:fintrack/widgets/chart.dart';
import 'package:fintrack/widgets/new_transaction.dart';
import 'package:fintrack/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class PageBody extends StatefulWidget {
  final List<Transaction> transactions;
  final Function addNewtransaction;

  PageBody({this.transactions, this.addNewtransaction});
  @override
  _PageBodyState createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  List<Transaction> get _recentTransactions {
    return widget.transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _startAddingNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
            addTx: widget.addNewTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      widget.transactions.removeWhere((tx) => tx.id == id);
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
          onPressed: () => _startAddingNewTransaction(context),
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
        transactions: widget.transactions,
        deleteTx: _deleteTransaction,
      ),
    );

    bool _showChart = false;

    return SingleChildScrollView(
      child: Column(
        children: [
          if (isLandscape)
            Container(
              height: (media.size.height -
                      appBar.preferredSize.height -
                      media.padding.top) *
                  0.18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
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
            _showChart
                ? Container(
                    height: (media.size.height -
                            appBar.preferredSize.height -
                            media.padding.top) *
                        0.7, //35%
                    child: Chart(
                      recentTransactions: _recentTransactions,
                    ),
                  )
                : Container(
                    height: (media.size.height -
                            appBar.preferredSize.height -
                            media.padding.top) *
                        0.82,
                    child: txListWidget,
                  ),
        ],
      ),
    );
  }
}
