import 'package:falafeelo/providers&models/carts.dart';
import 'package:falafeelo/providers&models/meals.dart';
import 'package:falafeelo/providers&models/orders.dart';
import 'package:falafeelo/screens/authScreen.dart';
import 'package:falafeelo/screens/cartScreen.dart';
import 'package:falafeelo/screens/mainScreen.dart';
import 'package:falafeelo/screens/waitingScreen.dart';
import 'screens/mapScreen.dart';
import 'screens/ordersScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Meals(),
        ),
        ChangeNotifierProvider.value(
          value: Carts(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/waitingScreen': (context) => WaitingScreen(),
          '/authScreen': (context) => AuthScreen(),
          '/cartScreen': (context) => CartScreen(),
          '/ordersScreen': (context) => OrdersScreen()
        },
      ),
    );
  }
}
