import 'package:flutter/material.dart';
import 'package:indglobalyomess/screens/home_screen.dart';
import 'package:indglobalyomess/utils/constant.dart';

class OrderPlaceSuccessfulScreen extends StatefulWidget {
  @override
  _OrderPlaceSuccessfulScreenState createState() =>
      _OrderPlaceSuccessfulScreenState();
}

class _OrderPlaceSuccessfulScreenState
    extends State<OrderPlaceSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kSecondaryTextColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Order Placed',
          style: TextStyle(
              color: kTextColor, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/img/orderplace.png'),
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Order Place Successfully',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              height: 50,
              minWidth: 100,
              color: kRegularColor,
              child: Text('Go To Home'),
            ),
          ],
        ),
      ),
    );
  }
}
