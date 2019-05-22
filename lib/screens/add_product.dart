import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  AddProduct({this.id, this.code, this.description, this.price});
  final String id;
  final String code;
  final String description;
  final num price;

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _codeController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    print(widget.id);
    _codeController = TextEditingController(text: widget.code);
    _descriptionController = TextEditingController(text: widget.description);
    _priceController = TextEditingController(text: widget.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            controller: _codeController,
            decoration: InputDecoration(isDense: true, labelText: 'Code'),
          ),
          TextField(
            controller: _descriptionController,
            decoration:
                InputDecoration(isDense: true, labelText: 'Description'),
          ),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(isDense: true, labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          RaisedButton(
            child: Text('Registrar'),
            onPressed: () {
              Firestore.instance.collection('products').document(widget.id);
              Map<String, dynamic> data = {
                'code': _codeController.text,
                'description': _descriptionController.text,
                'price': int.parse(_priceController.text)
              };
              Firestore.instance
                  .collection('products')
                  .document(widget.id)
                  .setData(data)
                  .whenComplete(() {
                print('Actualizacion realizada');
              });
            },
          )
        ],
      ),
      appBar: AppBar(
        title: Text(widget.description),
      ),
    );
  }
}
