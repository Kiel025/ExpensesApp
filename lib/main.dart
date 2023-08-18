import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.blue[900],
          secondary: Colors.grey,
        ),
        textTheme: theme.textTheme.copyWith(
          titleMedium: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 10 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) => element.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(onPressed: fn, icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final appBar = AppBar(
      title: const Text("Despesas Pessoais"),
      actions: [
        if (isLandscape)
          _getIconButton(
            _showChart ? iconList : chartList,
            () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        _getIconButton(
          Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionFormModal(context),
        ),
      ],
    );

    final availableHeigh = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final actions = [
      if (_showChart || !isLandscape)
        SizedBox(
          height: availableHeigh * (isLandscape ? 0.7 : 0.25),
          child: Chart(_recentTransactions),
        ),
      if (!_showChart || !isLandscape)
        SizedBox(
          height: availableHeigh * (isLandscape ? 1 : 0.75),
          child: TransactionList(_transactions, _deleteTransaction),
        ),
    ];

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: actions,
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Despesas Pessoais"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
