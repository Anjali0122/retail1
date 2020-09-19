import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 10, 15),
                    child: GestureDetector(
                      child: Icon(
                        CupertinoIcons.back,
                        size: 45,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    'Payment Option',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 38),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.black)]),
              width: 245.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.local_atm,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        'Cash On Delivery',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black)]),
              width: 245.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        'Debit/Credit card',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(height: 150),
            Container(
              padding: EdgeInsets.all(125),
              height: 350,
              width: 340,
              decoration: new BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
