import 'package:budget_app_final/models/item.dart';
import 'package:budget_app_final/screens/category_list.dart';
import 'package:budget_app_final/screens/chart.dart';
import 'package:budget_app_final/screens/new_category.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0XFF3F51B5),
          title: Text('Add Category',
            style: TextStyle(color: Colors.white),
            ),
          content: Container(
            width: double.infinity,
            child: NewCategory(),
          ),
        );
      } 
    );
  }

class _HomeState extends State<Home> {
  final List<Item> _item = [];

  //For the chart
  List<Item> get _recentItems {
    return _item.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF8F8FF),
        appBar: AppBar(
          title: Text('Budget App',
          style: TextStyle(
            fontSize: 24,
          ),
          ),
          centerTitle: true,  
        backgroundColor: Color(0XFF3F51B5),
        actions: [
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
            children: <Widget>[
              Chart(_recentItems),
              CategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}