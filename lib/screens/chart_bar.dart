import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double budgetLimit;
  final double total;
  ChartBar(this.label, this.budgetLimit, this.total);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text('₱${total.toStringAsFixed(0)}'),
        ),
        SizedBox(height: 6),
        Container(
          height: 75,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: total,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0XFF3F51B5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(label)
      ],
    );
  }
}