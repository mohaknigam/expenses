import 'package:fintrack/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                child: Text('CHART!'),
                elevation: 5,
              ),
            ),
            UserTransaction(),
          ],
        ),
      ),
    );
  }
}
