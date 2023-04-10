// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'transaction_item.dart';
import '../models/Transaction.dart';

// ignore: use_key_in_widget_constructors
class TransactionList extends StatelessWidget {
  List<Transaction> txList;
  final Function deletetx;

  // ignore: use_key_in_widget_constructors
  TransactionList(this.txList, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 450,
      child: txList.isEmpty
          ? Center(
              child: SizedBox(
                  child: Text(
                'No Transactions Added..',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              )),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(singleItem: txList[index], deletetx: deletetx);
              },
              itemCount: txList.length,
            ),
    );
  }
}


