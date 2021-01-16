import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/waitingScreen.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
