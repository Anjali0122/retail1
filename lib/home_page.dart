import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode = 'Unknown';
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
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue[400],
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Retail",
            style: TextStyle(color: Colors.black),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              FutureBuilder(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return UserAccountsDrawerHeader(
                          accountName: Text(
                            "Name: ${snapshot.data.displayName}",
                            style: TextStyle(fontSize: 20),
                          ),
                          accountEmail: Text(
                            "Email: ${snapshot.data.email}",
                            style: TextStyle(fontSize: 17),
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
        body: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(28.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue,
                Colors.lightBlueAccent,
              ]),
            ),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 72.0,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: () => scanBarcodeNormal(),
                      padding: EdgeInsets.all(12),
                      color: Colors.black38,
                      child: Text("Start barcode scan",
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: () => startBarcodeScanStream(),
                      padding: EdgeInsets.all(12),
                      color: Colors.black38,
                      child: Text("Start barcode scan stream",
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Scan result : $_scanBarcode\n',
                        style: TextStyle(fontSize: 20))
                  ])
            ])));
  }
}
