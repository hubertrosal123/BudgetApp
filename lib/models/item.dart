//Getting
//For Chart
class Item {
  int itemID, categoryID;
  String itemName;
  DateTime date;
  double amount;
  
  itemMap() {
    var mapping = Map<String, dynamic>();
    mapping['itemID'] = itemID;
    mapping['itemName'] = itemName;
    mapping['amount'] = amount;
    mapping['date'] = date;
    mapping['categoryID'] = categoryID;

    return mapping;
  }
}

class ItemSecond {
  int itemID, categoryID;
  String itemName;
  String date;
  double amount;
  
  itemMapS() {
    var mapping = Map<String, dynamic>();
    mapping['itemID'] = itemID;
    mapping['itemName'] = itemName;
    mapping['amount'] = amount;
    mapping['date'] = date;
    mapping['categoryID'] = categoryID;

    return mapping;
  }
}