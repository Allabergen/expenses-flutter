import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function newTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.newTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // Title
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
            ),
            // Amount
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
            ),
            // Add Transaction button
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.blueGrey,
              onPressed: () {
                newTx(
                    titleController.text, double.parse(amountController.text));
              },
            ),
          ],
        ),
      ),
    );
  }
}
