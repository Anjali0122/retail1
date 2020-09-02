import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode;

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: buildAppBar(),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              FutureBuilder(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return UserAccountsDrawerHeader(
                          currentAccountPicture: new CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                "https://cdn2.iconfinder.com/data/icons/website-icons/512/User_Avatar-512.png"),
                          ),
                          accountEmail: Text(
                            "${snapshot.data.email}",
                            style: TextStyle(fontSize: 19),
                          ));
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text(
                  "Purchase History",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  "Log out",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  FirebaseAuth.instance.signOut().then(
                    (value) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/loginpage', (Route<dynamic> route) => false);
                    },
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              headerbox(context),
              SizedBox(height: 30),
              Container(
                height: 500,
                child: Stack(
                  children: [buildStreamBuilder()],
                ),
              )
            ],
          ),
        ));
  }

  Container headerbox(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
            ),
            height: MediaQuery.of(context).size.height * 0.2 - 10,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Hi User!',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilder() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("products")
          .where("barcode", isEqualTo: "$_scanBarcode")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Text(
            'Scan Barcode',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot products = snapshot.data.documents[index];
            return Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0.0, 20),
                  child: Container(
                    width: 412.0,
                    height: 371.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(73.0),
                      color: Colors.blue[300],
                      border: Border.all(width: 1.0, color: Colors.blue[300]),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(90.4, 23),
                  child: Container(
                    width: 224.0,
                    height: 110.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: const Color(0x00707070)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        products['img'],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(4.0, 140),
                  child: Container(
                    width: 262.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xffbce0fd)),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(4.0, 140),
                  child: Container(
                    width: 105.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                      border: Border.all(
                          width: 1.0, color: const Color(0xff2699fb)),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(16.0, 158),
                  child: Text(
                    'PRODUCT NAME',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xff0d0000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(162.8, 156),
                  child: Text(
                    products['name'],
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 14,
                      color: const Color(0xff01060a),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(4.0, 210),
                  child: SvgPicture.string(
                    _svg_sd12o8,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(4.0, 210),
                  child: Container(
                    width: 106.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                      border: Border.all(
                          width: 1.0, color: const Color(0x2b2699fb)),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(25.0, 228),
                  child: Text(
                    'NET WEIGHT',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xff0f0202),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(162.8, 226),
                  child: Text(
                    products['netweight'],
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 14,
                      color: const Color(0xff020d16),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(4.0, 280),
                  child: SvgPicture.string(
                    _svg_dkb2rz,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(4.0, 280),
                  child: Container(
                    width: 105.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                      border: Border.all(
                          width: 1.0, color: const Color(0x782699fb)),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(41.0, 297.5),
                  child: Text(
                    'PRICE',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: const Color(0xff070000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(162.8, 295),
                  child: Text(
                    products['price'] + " Rs",
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 14,
                      color: const Color(0xff020910),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(95, 360),
                  child: SizedBox(
                    width: 200.0,
                    height: 50,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text('Add to Cart',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                          ],
                        ),
                        color: Colors.blue),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Scan&Pay",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget floatingBar() => Ink(
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
        ),
        child: FloatingActionButton.extended(
          onPressed: () => scanBarcodeNormal(),
          backgroundColor: Colors.black,
          icon: Icon(
            FontAwesomeIcons.barcode,
            color: Colors.white,
          ),
          label: Text(
            "SCAN",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
}

const String _svg_sd12o8 =
    '<svg viewBox="4.0 476.9 262.0 50.0" ><path transform="translate(4.0, 476.89)" d="M 0 0 L 262 0 L 262 50 L 0 50 L 0 0 Z" fill="#ffffff" stroke="#bce0fd" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dkb2rz =
    '<svg viewBox="4.0 553.6 262.0 50.0" ><path transform="translate(4.0, 553.63)" d="M 0 0 L 262 0 L 262 50 L 0 50 L 0 0 Z" fill="#ffffff" stroke="#bce0fd" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
