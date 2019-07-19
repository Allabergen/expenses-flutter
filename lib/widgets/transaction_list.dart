import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: transactions.isEmpty
          // No transaction Image
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No Transactions',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Image.asset(
                    'assets/images/nothing.png',
                    height: constraints.maxHeight * 0.5,
                  ),
                ],
              );
            })
          // List of transactions
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: ListTile(
                    // Amount in circle
                    leading: CircleAvatar(
                      radius: 30.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    // Title
                    title: Text(
                      transactions[index].title,
                    ),
                    // Date
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(fontSize: 12.0),
                    ),
                    // Delete Button
                    trailing: MediaQuery.of(context).size.width > 450
                        ? FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transactions[index].id),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
