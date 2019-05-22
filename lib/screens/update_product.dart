import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({this.id, this.code, this.description, this.price});
  final String id;
  final String code;
  final String description;
  final num price;

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
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
            decoration: InputDecoration(isDense: true, labelText: 'code'),
          ),
          TextField(
            controller: _descriptionController,
            decoration:
                InputDecoration(isDense: true, labelText: 'description'),
          ),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(isDense: true, labelText: 'price'),
            keyboardType: TextInputType.number,
          ),
          RaisedButton(
            child: Text('Actualizar'),
            onPressed: () {
              print(int.parse(_priceController.text).runtimeType);
              DocumentReference ref =
                  Firestore.instance.collection('products').document(widget.id);
              Map<String, dynamic> data = {
                'code': _codeController.text,
                'description': _descriptionController.text,
                'price': int.parse(_priceController.text)
              };

              Firestore.instance
                  .collection('products')
                  .document(widget.id)
                  .updateData(data)
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
