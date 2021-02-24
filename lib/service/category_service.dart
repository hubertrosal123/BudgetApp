import 'package:budget_app_final/models/category.dart';
import 'package:budget_app_final/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  //Create data
  saveCategory(Category category) async{
    return  await _repository.insertData('categories', category.categoryMap());
  }

  //Read data from table
  readCategories() async {
    return _repository.readData('categories');
  }
}