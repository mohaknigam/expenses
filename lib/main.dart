import 'package:flutter/material.dart';
import 'widgets/new_transaction.dart';
import 'models/transactions.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  color: Colors.yellow,
                  fontFamily: 'OpenSans',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    //   Transaction(
    //       title: 'New Shows',
    //       id: DateTime.now().toString(),
    //       amount: 23,
    //       date: DateTime.now()),
    //   Transaction(
    //       title: 'New Shoes',
    //       id: DateTime.now().toString(),
    //       amount: 24,
    //       date: DateTime.now()),
    //   Transaction(
    //       title: 'New Shirt',
    //       id: DateTime.now().toString(),
    //       amount: 30,
    //       date: DateTime.now()),
    //   Transaction(
    //       title: 'New cow',
    //       id: DateTime.now().toString(),
    //       amount: 34,
    //       date: DateTime.now()),
    //   Transaction(
    //       title: 'New Shall',
    //       id: DateTime.now().toString(),
    //       amount: 21,
    //       date: DateTime.now()),
    //   Transaction(
    //       title: 'New town',
    //       id: DateTime.now().toString(),
    //       amount: 42,
    //       date: DateTime.now()),
    //   Transaction(
    //       title: 'New Shows2',
    //       id: DateTime.now().toString(),
    //       amount: 25,
    //       date: DateTime.now()),
    //   Transaction(
    //       title: 'New Shows3',
    //       id: DateTime.now().toString(),
    //       amount: 213,
    //       date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      id: DateTime.now().toString(),
      amount: txAmount,
      date: chosenDate,
    );

    setState(
      () {
        _transactions.insert(0, newTx); // to insert new element at top always
      },
    );
  }

  void _startAddingNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
            addTx: _addNewTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
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
        transactions: _transactions,
        deleteTx: _deleteTransaction,
      ),
    );

    final pageBody = SingleChildScrollView(
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

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.yellow,
        onPressed: () => _startAddingNewTransaction(context),
        child: Icon(
          Icons.add,
          color: Colors.yellow,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: (isLandscape)
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.centerFloat,
    );
  }
}
