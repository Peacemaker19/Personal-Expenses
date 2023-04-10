import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          Container(
            height: constraint.maxHeight > 20 ? 20 : constraint.maxHeight,
            width: constraint.maxWidth * 0.8,
            margin: const EdgeInsets.all(3),
            child: FittedBox(
              child: Text(
                '\$${spendingAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight > 5 ? 5 : constraint.maxHeight
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: constraint.maxHeight > 100 ? 100 : constraint.maxHeight,
            width: constraint.maxWidth > 25 ? 25 : constraint.maxWidth,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                ),
                FractionallySizedBox(
                    heightFactor: spendingPctTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight > 5 ? 5 : constraint.maxHeight,
          ),
          Container(
           height: constraint.maxHeight > 20 ? 20 : constraint.maxHeight,
            width: constraint.maxWidth > 30 ? 30 : constraint.maxWidth,
            margin: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                label,
                style: const TextStyle(
                    fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    });
  }
}
