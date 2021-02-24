import 'package:budget_app_final/models/category.dart';
import 'package:budget_app_final/service/category_service.dart';
import 'package:flutter/material.dart';

class NewCategory extends StatefulWidget {
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  var _category = Category();
  var _categoryService = CategoryService();
  var _categoryNameController = TextEditingController();
  var _budgetLimitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _categoryNameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Category Name',
                labelStyle: TextStyle(color: Colors.white),
                icon: Icon(
                  Icons.category,
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )),
            style: TextStyle(color: Colors.white, fontSize: 18),
            onSubmitted: (_) {},
          ),
          TextField(
            controller: _budgetLimitController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Budget Limit',
                labelStyle: TextStyle(color: Colors.white),
                icon: Icon(
                  Icons.money_off,
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )),
            style: TextStyle(color: Colors.white, fontSize: 18),
            onSubmitted: (_) {},
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Enter',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () async {
                  _category.categoryName = _categoryNameController.text;
                  _category.budgetLimit =
                      double.parse(_budgetLimitController.text);

                  if (_category.categoryName.isEmpty ||
                      _category.budgetLimit == null) {
                    return;
                  }
                  var result = await _categoryService.saveCategory(_category);
                  print(result);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
