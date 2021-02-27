import 'package:flutter/material.dart';
import 'widgets/new_transaction.dart';
import 'models/transactions.dart';
import 'widgets/transaction_list.dart';
import 'models/PageBody.dart';

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

    final pageBody = PageBody(
      addNewtransaction: _addNewTransaction(txTitle, txAmount, chosenDate),
      transactions: _transactions,
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
