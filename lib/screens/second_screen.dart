import 'package:budget_app_final/screens/item_list.dart';
import 'package:budget_app_final/screens/new_item.dart';
import 'package:budget_app_final/screens/radial_chart.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final int id;
  final String name;
  final double budlimit;
  SecondScreen(this.id, this.name, this.budlimit);
  
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> { 

  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return NewItem(widget.id);
      } 
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF8F8FF),
        appBar: AppBar( 
          centerTitle: true,
          backgroundColor: Color(0XFF3F51B5),
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
              icon: Icon(Icons.add, size: 30),
              onPressed: () => showDialogBox(context),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RadialChart(widget.id, widget.name, widget.budlimit),
              SizedBox(height: 8),
              ItemList(widget.id),
            ],
          ),
        ),
      ),
    );
  }
}
