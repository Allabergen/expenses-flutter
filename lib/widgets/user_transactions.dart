import 'package:expenses_flutter/models/transaction.dart';
import 'package:expenses_flutter/widgets/new_transactions.dart';
import 'package:expenses_flutter/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 34.3, date: DateTime.now()),
    Transaction(id: 't2', title: 'Laptop', amount: 350.5, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Watermelon', amount: 6.3, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Input expenses
        NewTransaction(_addNewTransaction),
        // Expenses List
        TransactionList(transactions: _userTransactions),
      ],
    );
  }
}
