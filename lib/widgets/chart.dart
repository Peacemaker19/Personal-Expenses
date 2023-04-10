import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';
import '../widgets/chart_bar.dart';

// ignore: use_key_in_widget_constructors
class Chart extends StatelessWidget {
  List<Transaction> txList;

  Chart(this.txList);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(
      7,
      (index) {
        final weekday = DateTime.now().subtract(Duration(days: index));

        var totalsum = 0.0;
        for (int i = 0; i < txList.length; i++) {
          if (txList[i].date.day == weekday.day &&
              txList[i].date.month == weekday.month &&
              txList[i].date.year == weekday.year) {
            totalsum += txList[i].amount;
          }
        }

        return {'day': DateFormat.E().format(weekday), 'amount': totalsum};
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransaction.fold(0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blueGrey,
      elevation: 25,
      child: Container(
        padding: const EdgeInsets.all(3),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransaction.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: data['day'],
                    spendingAmount: data['amount'],
                    spendingPctTotal: totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList()),
      ),
    );
  }
}
