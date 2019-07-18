import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Theme.of(context).backgroundColor,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'No Transactions',
                  style: TextStyle(fontSize: 24.0),
                ),
                Image.asset(
                  'assets/images/nothing.png',
                  width: 150.0,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueGrey, width: 2.0)),
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              transactions[index].title,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              DateFormat('yMMMd')
                                  .format(transactions[index].date),
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
