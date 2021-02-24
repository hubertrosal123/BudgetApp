import 'package:budget_app_final/models/category.dart';
import 'package:budget_app_final/models/item.dart';
import 'package:flutter/material.dart';

const TWO_PI = 3.14 * 2;

class RadialChart extends StatefulWidget {
  final int id;
  final String name;
  final double budlimit;
  RadialChart(this.id, this.name, this.budlimit);

  @override
  _RadialChartState createState() => _RadialChartState();
}

class _RadialChartState extends State<RadialChart> {
  Category categoryList;
  List<Item> itemList = List<Item>();

  double totalItems() {
    double totalValue = 0;
    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i].categoryID == widget.id) totalValue += itemList[i].amount;
    }
    return totalValue;
  }

  double totalUsed() {
    double totalUsedItems;
    totalUsedItems = totalItems() / widget.budlimit;
    return totalUsedItems;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final sz = 200.0;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(8)),
            Container(
              height: 250.0,
              width: size.width - 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: totalUsed()),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  return Container(
                    width: sz,
                    height: sz,
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return SweepGradient(
                                startAngle: 0.0,
                                endAngle: TWO_PI,
                                stops: [value, value],
                                center: Alignment.center,
                                colors: [
                                  Colors.blue,
                                  Colors.grey.withAlpha(55)
                                ]).createShader(rect);
                          },
                          child: Container(
                            width: sz,
                            height: sz,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: sz - 40.0,
                            height: sz - 40.0,
                            child: Center(
                              child: Text(
                                "₱ " +
                                    totalItems().toString() +
                                    " / ₱ ${widget.budlimit}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
