import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction({this.addTx});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime _selectedDate;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addTx(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Container(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 10,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                      onSubmitted: (_) => _submitData(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(),
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: _selectedDate == null
                                ? Text('No Date Chosen')
                                : Text(
                                    'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                                  ),
                          ),
                          Platform.isIOS
                              ? CupertinoButton(
                                  onPressed: _presentDatePicker,
                                  child: Text(
                                    'Choose Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              : FlatButton(
                                  onPressed: _presentDatePicker,
                                  textColor: Theme.of(context).primaryColor,
                                  child: Text(
                                    'Choose Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      splashColor: Colors.purple,
                      onPressed: () {
                        _submitData();

                        if (_titleController.text.isNotEmpty &&
                            double.parse(_amountController.text) > 0) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      child: Text('Add Transaction'),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: media.viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }
}
