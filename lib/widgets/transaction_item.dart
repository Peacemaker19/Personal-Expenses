import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';
class TransactionItem extends StatelessWidget {
   const TransactionItem({
    Key key,
    @required this.singleItem,
    @required this.deletetx,
  }) : super(key: key);

  final Transaction singleItem;
  final Function deletetx;

  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              child: Text(
                singleItem.amount.toStringAsFixed(2),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
        title: Text(
          singleItem.title,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(singleItem.date),
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.start,
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: () {
                  deletetx(
                    singleItem.id,
                  );
                },
                icon: const Icon(
                  Icons.delete, color: Colors.red,
                ),label: const Text('Delete',style: TextStyle(color: Colors.red),),
              )
            : IconButton(
                onPressed: () {
                  deletetx(
                    singleItem.id,
                  );
                },
                icon: const Icon(
                  Icons.delete,
                ),
                color: Colors.red,
              ),
      ),
    );
  }
}