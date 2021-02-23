import 'package:flutter/material.dart';
import 'package:fintrack/models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList({this.transactions, this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No Transactions Added Yet!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 27,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          '₹${transactions[index].amount}',
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTx(transactions[index].id),
                    color: Theme.of(context)
                        .errorColor, // can simply use Colors.red also
                    iconSize: 28,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
