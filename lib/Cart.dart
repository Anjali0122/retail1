import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retail/services/crud.dart';

class Cart extends StatefulWidget {
  Cart({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Cart createState() => _Cart();
}

class _Cart extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            buildStreamBuilder(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

StreamBuilder<QuerySnapshot> buildStreamBuilder() {
  String _userId;
  crudMethods crudObj = new crudMethods();
  FirebaseAuth.instance.currentUser().then((user) {
    _userId = user.uid;
  });
  return StreamBuilder(
      stream: Firestore.instance
          .collection("CartData")
          .where("uid", isEqualTo: _userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Text(
            'Scan Barcode',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        return Container(
            height: 510,
            width: 400,
            child: ListView.separated(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot cartData = snapshot.data.documents[index];
                  return ItemCard(products: cartData);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20);
                }));
      });
}

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.blue,
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(
      "My Orders",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}

class BottomBar extends StatelessWidget {
  BottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(),
          Divider(
            height: 1,
            color: Colors.grey[700],
          ),
          quantity(),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 25),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: <Widget>[
                  Center(
                    child: Text(
                      "   Next",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

Container quantity() {
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.symmetric(vertical: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Quantity",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            )),
      ],
    ),
  );
}

Container totalAmount() {
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.all(25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Total:",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        ),
      ],
    ),
  );
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
    @required this.products,
  }) : super(key: key);

  final DocumentSnapshot products;

  @override
  Widget build(BuildContext context) {
    String _userId;
    crudMethods crudObj = new crudMethods();
    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(1.0),
              height: 80,
              width: 100,
              decoration: BoxDecoration(
                  color: Color(0xFF3D82AE),
                  borderRadius: BorderRadius.circular(16)),
              child: Image.network(products['img']),
            ),
          ],
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0 / 4),
          child: Text(
            products['name'],
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Text(
              "\₹ " + products['price'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 100,
            ),
            GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: () {
                Map<String, dynamic> cartData = {
                  'barcode': products['barcode'],
                  'img': products['img'],
                  'name': products['name'],
                  'netweight': products['netweight'],
                  'price': products['price'],
                  'uid': _userId
                };
                crudObj.deleteData(cartData).then((result) {
                  dialogTrigger(context);
                }).catchError((e) {
                  print(e);
                });
              },
            ),
          ],
        )
      ],
    );
  }
}

Future<bool> dialogTrigger(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Job done', style: TextStyle(fontSize: 22.0)),
          content: Text(
            'Added Successfully',
            style: TextStyle(fontSize: 20.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Alright',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
