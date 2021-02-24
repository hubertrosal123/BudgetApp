import 'package:budget_app_final/models/item.dart';
import 'package:budget_app_final/repositories/repository.dart';

class ItemService {
  Repository _repository;

  ItemService() {
    _repository = Repository();
  }

  //Create data
  saveItem(Item item) async{
    return  await _repository.insertData('items', item.itemMap());
  }

  //Create data
  saveItemS(ItemSecond item) async{
    return  await _repository.insertData('items', item.itemMapS());
  }

  //Read data from table
  readItems() async {
    return _repository.readData('items');
  }

  //Read ID from table
  readID(itemID) async {
    return await _repository.readDataWithID('items', itemID);
  }

  //Delete data from table
  deleteItem(itemID) async {
    return await _repository.deleteData('items', itemID);
  }

  //Update data
  updateItem(Item item) async{
    return await _repository.updateData('items', item.itemMap());
  } 

  //Update data
  updateItemS(ItemSecond item) async{
    return await _repository.updateData('items', item.itemMapS());
  } 

  readItembyID(itemId) async {
    return await _repository.readDataByID('items', itemId);
  }
} 