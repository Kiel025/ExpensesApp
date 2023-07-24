import 'package:expenses/components/transaction_user.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas Pessoais"),
      ),
      body: const Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 5,
              child: Text(
                "Gráfico",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TransactionUser()
        ],
      ),
    );
  }
}
