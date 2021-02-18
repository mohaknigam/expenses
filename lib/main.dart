import 'package:flutter/material.dart';
import 'transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Transaction> transactions = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expenses App',
          style: TextStyle(color: Colors.yellow, fontSize: 25.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              child: Text('CHART!'),
              elevation: 5,
            ),
          ),
          Card(
            child: Text('List of Txns'),
          ),
        ],
      ),
    );
  }
}
