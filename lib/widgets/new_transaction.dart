import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  NewTransaction({this.addTx});

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    addTx(
      titleController.text,
      double.parse(amountController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              splashColor: Colors.purple,
              onPressed: () {
                submitData();

                if (titleController.text.isNotEmpty &&
                    double.parse(amountController.text) > 0) {
                  FocusScope.of(context).unfocus();
                }
              },
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
