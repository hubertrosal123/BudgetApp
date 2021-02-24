import 'package:budget_app_final/models/item.dart';
import 'package:budget_app_final/service/item_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewItem extends StatefulWidget {
  final int id;
  NewItem(this.id);
  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  var _item = ItemSecond();
  var _itemService = ItemService();
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  var dateController = TextEditingController();
  DateTime _dateTime = DateTime.now();

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
        dateController.text = DateFormat.yMMMd().format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0XFF3F51B5),
      title: Text('Add Item', style: TextStyle(color: Colors.white)),
      content: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
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
                controller: amountController,
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
                controller: dateController,
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
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  FlatButton(
                    child: Text(
                      'Add Item',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () async {
                      _item.itemName = titleController.text;
                      _item.amount = double.parse(amountController.text);
                      _item.date = dateController.text;
                      _item.categoryID = widget.id;

                      if (_item.itemName.isEmpty || _item.amount == null || _item.date.isEmpty) {
                        return;
                      } 
                        var result = await _itemService.saveItemS(_item);
                        print(result);
                        Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
