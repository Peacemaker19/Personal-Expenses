import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/widgets/chart.dart';
import './widgets/new_transactioin.dart';
import './widgets/theme.dart';
import './widgets/transaction_list.dart';
import './models/Transaction.dart';

void main() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(MyApp());
}


// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Themeing(MyHomePage());
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final List<Transaction> _txList = [];
  var _showchart = false;

  List<Transaction> get transactionList {
    return _txList.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _txList.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _txList.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: New_Transaction(_addTransaction),
        );
      },
    );
  }

  List<Widget> _buildLandscapeMode(MediaQueryData mediaQuery,AppBar appbar,Widget txNotes){
          return [Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Chart'),
                  Switch(
                    value: _showchart,
                    onChanged: (val) {
                      setState(
                        () {
                          _showchart = val;
                        },
                      );
                    },
                  ),
                ],
              ), _showchart
                  ? Container(
                      height: ((mediaQuery.size.height -
                              appbar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.80),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Chart(transactionList))
                  : txNotes];

  }
  List<Widget> _buildPortraitMode(MediaQueryData mediaQuery,AppBar appbar,Widget txNotes){
    return [Container(
                height: ((mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.31),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Chart(transactionList),
              ),
             txNotes];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;
    final appbar = AppBar(
      title: const Text('Expenses'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddnewTransaction(context),
          icon: const Icon(Icons.add),
        )
      ],
    );

    final _txNotes = SizedBox(
      height: ((mediaQuery.size.height -
              appbar.preferredSize.height -
              mediaQuery.padding.top) *
          0.80),
      child: TransactionList(_txList, _deleteTransaction),
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           if (isLandscape) ..._buildLandscapeMode(mediaQuery,appbar,_txNotes),
            if (!isLandscape) ..._buildPortraitMode(mediaQuery,appbar,_txNotes),   
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddnewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
