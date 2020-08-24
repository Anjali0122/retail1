import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adobe_xd/pinned.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              headerbox(context),
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
        if (snapshot.data == null) return CircularProgressIndicator();
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
                      color: const Color(0xff0d82e8),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
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
                      color: const Color(0xff2699fb),
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
                      color: const Color(0xff2699fb),
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
                      color: const Color(0xff2699fb),
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
                    products['price'] +" Rs",
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 14,
                      color: const Color(0xff020910),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(92.9, 360),
                  child: SvgPicture.string(
                    _svg_anv1s8,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(110.5, 320),
                  child:
                      // Adobe XD layer: 'shopping_cart-24px' (group)
                      SizedBox(
                    width: 104.0,
                    height: 86.0,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(80.0, 0.0, 24.0, 24.0),
                          size: Size(104.0, 86.1),
                          pinRight: true,
                          pinTop: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child: SvgPicture.string(
                            _svg_c5ribp,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 56.0, 31.5, 30.1),
                          size: Size(104.0, 86.1),
                          pinLeft: true,
                          pinBottom: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child: SvgPicture.string(
                            _svg_t06ttx,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(168.6, 376.5),
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 20,
                      color: const Color(0xff00060c),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
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
const String _svg_c5ribp =
    '<svg viewBox="80.0 0.0 24.0 24.0" ><path transform="translate(80.0, 0.0)" d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_t06ttx =
    '<svg viewBox="0.0 56.0 31.5 30.1" ><path transform="translate(-1.0, 54.0)" d="M 10.44913959503174 26.04838943481445 C 8.716797828674316 26.04838943481445 7.315175533294678 27.4011116027832 7.315175533294678 29.0544376373291 C 7.315175533294678 30.70776557922363 8.716797828674316 32.06048583984375 10.44913959503174 32.06048583984375 C 12.18148231506348 32.06048583984375 13.59885311126709 30.70776557922363 13.59885311126709 29.0544376373291 C 13.59885311126709 27.4011116027832 12.18148231506348 26.04838943481445 10.44913959503174 26.04838943481445 Z M 0.9999998807907104 2 L 0.9999998807907104 5.006049156188965 L 4.149713516235352 5.006049156188965 L 9.819196701049805 16.41400337219238 L 7.693141460418701 20.09641075134277 C 7.441164016723633 20.51725769042969 7.299427509307861 21.01325798034668 7.299427509307861 21.53931617736816 C 7.299427509307861 23.1926441192627 8.716797828674316 24.54536437988281 10.44913959503174 24.54536437988281 L 29.34741401672363 24.54536437988281 L 29.34741401672363 21.53931617736816 L 11.11058044433594 21.53931617736816 C 10.89009952545166 21.53931617736816 10.71686553955078 21.37398338317871 10.71686553955078 21.16356086730957 L 10.76411151885986 20.98319625854492 L 12.18148231506348 18.53326797485352 L 23.91416168212891 18.53326797485352 C 25.09530448913574 18.53326797485352 26.13471221923828 17.91702651977539 26.6701602935791 16.98515319824219 L 32.30815124511719 7.230525016784668 C 32.43413543701172 7.020102024078369 32.49713134765625 6.76458740234375 32.49713134765625 6.509073734283447 C 32.49713134765625 5.68241024017334 31.78844451904297 5.006049633026123 30.92227363586426 5.006049633026123 L 7.630146980285645 5.006049633026123 L 6.149781703948975 2.000000953674316 L 0.9999998807907104 2.000000953674316 Z M 26.19770431518555 26.04838943481445 C 24.46536064147949 26.04838943481445 23.06373977661133 27.4011116027832 23.06373977661133 29.0544376373291 C 23.06373977661133 30.70776557922363 24.46536254882812 32.06048583984375 26.19770431518555 32.06048583984375 C 27.9300422668457 32.06048583984375 29.34741401672363 30.70776557922363 29.34741401672363 29.0544376373291 C 29.34741401672363 27.4011116027832 27.93004608154297 26.04838943481445 26.19770431518555 26.04838943481445 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_anv1s8 =
    '<svg viewBox="92.9 631.4 212.5 54.9" ><path transform="translate(92.9, 631.4)" d="M 27.24042892456055 0 L 185.2349090576172 0 C 200.2793884277344 0 212.4753570556641 12.30002212524414 212.4753570556641 27.47286987304688 C 212.4753570556641 42.64571762084961 200.2793884277344 54.94573974609375 185.2349090576172 54.94573974609375 L 27.24042892456055 54.94573974609375 C 12.19595527648926 54.94573974609375 0 42.64571762084961 0 27.47286987304688 C 0 12.30002212524414 12.19595527648926 0 27.24042892456055 0 Z" fill="#2699fb" stroke="#4f227d" stroke-width="1" stroke-opacity="0.09" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
