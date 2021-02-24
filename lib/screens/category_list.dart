import 'package:budget_app_final/models/category.dart';
import 'package:budget_app_final/screens/second_screen.dart';
import 'package:budget_app_final/service/category_service.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Category> _categoryList = List<Category>();
  var _categoryService = CategoryService();


  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  getAllCategories() async{
    _categoryList = List<Category>();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.id = category['id'];
        categoryModel.categoryName = category['categoryName'];
        categoryModel.budgetLimit = category['budgetLimit'];
        _categoryList.add(categoryModel);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: ListView.builder( 
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
        final a = _categoryList[index].id;
        final b = _categoryList[index].categoryName;
        final c = _categoryList[index].budgetLimit;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondScreen(a, b, c),
              ),
            );
          },
          child: Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: ListTile(
              leading: Icon(Icons.star, color: Color(0XFFFF9800), size: 35),
              title: Text(
                _categoryList[index].categoryName,
                style: TextStyle(
                  fontFamily: 'OpenSans', 
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(_categoryList[index].budgetLimit.toStringAsFixed(2)),
              trailing: Icon(Icons.arrow_right),
            ),
          ),
        );
        },
        itemCount: _categoryList.length,
      ),
    );
  }
}

