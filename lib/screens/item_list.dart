import 'package:budget_app_final/models/item.dart';
import 'package:budget_app_final/service/item_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemList extends StatefulWidget {
  final int id;
  ItemList(this.id);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<ItemSecond> _itemList = List<ItemSecond>();
  var _itemService = ItemService();
  var _item = ItemSecond();
  var edittitleController = TextEditingController();
  var editamountController = TextEditingController();
  var editdateController = TextEditingController();
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  var dateController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  var item;
  var num;

  @override
  void initState() {
    super.initState();
    getAllItems();
  }

  getAllItems() async {
    _itemList = List<ItemSecond>();
    var items = await _itemService.readID(widget.id);
    items.forEach((item) {
      setState(() {
        var itemModel = ItemSecond();
        itemModel.itemID = item['itemID'];
        itemModel.itemName = item['itemName'];
        itemModel.amount = item['amount'];
        itemModel.date = item['date'];
        itemModel.categoryID = item['categoryID'];
        _itemList.add(itemModel);
      });
    });
  }

  // DELETE ITEM
  _deleteDialogBox(BuildContext context, itemID) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0XFFF8F8FF),
          title: Text('Are you sure you want to delete?'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              onPressed: () async {
                var result = await _itemService.deleteItem(itemID);
                if (result > 0) {
                  Navigator.pop(context);
                  getAllItems();
                  show('Deleted!');
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // UPDATE or EDIT ITEM
  _editItems(BuildContext context, itemId) async {
    item = await _itemService.readItembyID(itemId);
    setState(() {
      edittitleController.text = item[0]['itemName'] ?? 'No Name';
      num = item[0]['amount'] ?? 'No Amount';
      editamountController.text = num.toString();
      editdateController.text = item[0]['date'] ?? 'No Date';
    });
    _editItemDialog(context);
  }

  _selectDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        editdateController.text = DateFormat.yMMMd().format(_pickedDate);
      });
    }
  }

  void show(message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _editItemDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0XFF3F51B5),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(
                'Update Item',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () async {
                _item.itemID = item[0]['itemID'];
                _item.itemName = edittitleController.text;
                _item.amount = double.parse(editamountController.text);
                _item.date = editdateController.text;
                _item.categoryID = widget.id;

                var result = await _itemService.updateItemS(_item);
                if (result > 0) {
                  Navigator.pop(context);
                  getAllItems();
                  show('Updated!'); 
                }
              },
            ),
          ],
          title: Text('Edit Item', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: edittitleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Item Name',
                      labelStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.shopping_cart,
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
                  controller: editamountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(color: Colors.white),
                    icon: Icon(Icons.money_off, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  onSubmitted: (_) {},
                ),
                TextField(
                  controller: editdateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    labelStyle: TextStyle(color: Colors.white),
                    icon: Icon(Icons.calendar_today, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onTap: () => _selectDate(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              elevation: 5,
              child: ListTile(
                isThreeLine: true,
                leading: IconButton(
                    icon: Icon(Icons.edit, size: 30),
                    onPressed: () {
                      _editItems(context, _itemList[index].itemID);
                    }),
                title: Text(
                  _itemList[index].itemName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Php -${_itemList[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16, color: Colors.red)),
                    Text(_itemList[index].date),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, size: 30),
                  color: Colors.red,
                  onPressed: () {
                    _deleteDialogBox(context, _itemList[index].itemID);
                  },
                ),
              ),
            );
          },
          itemCount: _itemList.length),
    );
  }
}
