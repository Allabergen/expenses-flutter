import 'dart:io';

import 'package:expenses_flutter/widgets/chart.dart';
import 'package:expenses_flutter/widgets/new_transactions.dart';
import 'package:expenses_flutter/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, ]); // set device orientations
  SystemChrome.setEnabledSystemUIOverlays([]); // hide status bar
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            title: 'Expenses',
            theme: CupertinoThemeData(
              primaryColor: Colors.blueGrey,
              primaryContrastingColor: Colors.pinkAccent,
              scaffoldBackgroundColor: Colors.white,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(fontFamily: 'ReefKafi', fontSize: 16.0),
              ),
            ),
            home: MyHomePage(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Expenses',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              accentColor: Colors.pinkAccent,
              cardColor: Colors.grey[100],
              backgroundColor: Colors.white,
              fontFamily: 'ReemKufi',
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(fontFamily: 'ReemKafi', fontSize: 16.0),
                    button: TextStyle(color: Colors.white),
                  ),
            ),
            home: MyHomePage(),
          );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 34.3, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Laptop', amount: 350.5, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'Watermelon', amount: 6.3, date: DateTime.now()),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(
            _addNewTransaction,
          ),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final txList = Container(
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appBar.preferredSize.height) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Switch
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() => _showChart = val);
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        // mediaQuery.padding.top -
                        appBar.preferredSize.height) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape)
              txList,
            if (isLandscape)
              _showChart
                  // Chart
                  ? Container(
                      height: (mediaQuery.size.height -
                              // mediaQuery.padding.top -
                              appBar.preferredSize.height) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  :
                  // Transaction List
                  txList,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
