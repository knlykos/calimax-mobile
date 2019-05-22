import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/add_product.dart';
import 'package:mobile/screens/update_product.dart';
import 'package:mobile/widgets/drawer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _printFn() {
    _scaffoldKey.currentState.openDrawer();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(document.data['description']),
            subtitle: Text('\$' + document.data['price'].toString()),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('EDITAR'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: const Text('ELIMINAR'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            var id =
                Firestore.instance.collection('products').document().documentID;
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddProduct(
                id: id,
                code: '',
                description: '',
                price: 0,
              );
            }));
          },
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('products')
              .orderBy('code')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading...');
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          },
        ),
        // body: Container(
        //   child: Column(
        //     children: <Widget>[
        //       Card(
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             const ListTile(
        //               leading: Icon(Icons.card_giftcard),
        //               title: Text('4554 4545 5454'),
        //               subtitle:
        //                   Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        //               enabled: true,
        //             ),
        //           ],
        //         ),
        //       ),
        //       Card(
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             const ListTile(
        //               leading: Icon(Icons.card_giftcard),
        //               title: Text('4554 4545 5454'),
        //               subtitle:
        //                   Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        //               enabled: true,
        //             ),
        //           ],
        //         ),
        //       ),
        //       Card(
        //         elevation: 5.0,
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             const ListTile(
        //               leading: Icon(Icons.card_giftcard),
        //               title: Text('4554 4545 5454'),
        //               subtitle:
        //                   Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        //               enabled: true,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          title: Text('Restaurante'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: _printFn,
          ),
        ),
        drawer: CxDrawer(),
        key: _scaffoldKey);
  }
}

