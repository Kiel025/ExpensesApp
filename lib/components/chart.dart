import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions, {super.key});

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      // final totalSum = recentTransactions
      //     .where((element) =>
      //         element.date.day == weekDay.day &&
      //         element.date.month == weekDay.month &&
      //         element.date.year == weekDay.year)
      //     .map((e) => e.value)
      //     .toList();
      // .reduce((value, [element = 0]) => value + element)
      // .toDouble();

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + (element['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: e['day'].toString(),
                      value: e['value'] as double,
                      percentage: (e['value'] as double) / _weekTotalValue,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
