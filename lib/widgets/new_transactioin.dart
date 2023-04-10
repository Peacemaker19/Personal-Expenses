import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
class New_Transaction extends StatefulWidget {
  final Function addTx;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  New_Transaction(this.addTx);

  @override
  State<New_Transaction> createState() => _New_TransactionState();
}

// ignore: camel_case_types
class _New_TransactionState extends State<New_Transaction> {
  final titleVal = TextEditingController();
  final amountVal = TextEditingController();
  DateTime _selectedDate;

   void _pickupDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickDate;
      });
    });
  }

  void submitData() {
    if (amountVal == null) {
      return;
    }
    final title = titleVal.text;
    final amount = double.parse(amountVal.text);
    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          margin: const EdgeInsetsDirectional.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleVal,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                controller: amountVal,
                onSubmitted: (_) => submitData(),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen.'
                            : DateFormat.yMd().format(_selectedDate),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'OpenSans'),
                      ),
                    ),
                    TextButton(
                        onPressed: _pickupDate,
                        child: const Text(
                          'Pick Date',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ))
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submitData,
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
