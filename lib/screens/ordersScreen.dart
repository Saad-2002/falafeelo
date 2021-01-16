import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(1),
        title: Text(
          'Your Orders',
          style: TextStyle(
            fontFamily: 'MarckScript',
            color: Colors.red[700],
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/placeHolder.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(),
      ),
    );
  }
}
