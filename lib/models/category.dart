class Category {
  int id;
  String categoryName;
  double budgetLimit;

  categoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['categoryName'] = categoryName;
    mapping['budgetLimit'] = budgetLimit;

    return mapping;
  }
}