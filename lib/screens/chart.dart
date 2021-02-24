import 'package:budget_app_final/models/item.dart';
import 'package:budget_app_final/screens/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Chart extends StatelessWidget {
  List<Item> recentItem;
  Chart(this.recentItem);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) { 
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (var i = 0; i < recentItem.length; i++) {
        if (recentItem[i].date.day == weekDay.day &&
            recentItem[i].date.month == weekDay.month &&
            recentItem[i].date.year == weekDay.year) {
          totalAmount += recentItem[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalAmount,
      };
    }).reversed.toList(); //para reversed ang list, ma-adto sa right side
  }

  double get perTotalAmount {
    return groupTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue += element['amount'];
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(13),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text('Weekly Spending',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 18, color: Colors.black), 
                  onPressed: null,
                ),
                Text('Nov. 10, 2019 - Nov. 16, 2019',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black), 
                  onPressed: null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupTransactionValues.map((e) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    e['day'],
                    e['amount'],
                    perTotalAmount == 0.0
                      ? 0.0
                      : (e['amount'] as double) / perTotalAmount),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}


