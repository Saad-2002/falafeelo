import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'carts.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth=FirebaseAuth.instance;
FirebaseUser loggedInUser;
final _fireStore = Firestore.instance;

class OrderItem {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final double total;

  OrderItem({
    @required this.id,
    @required this.items,
    @required this.date,
    @required this.total,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double total) async {
    getCurrentUser();
    loggedInUser.uid;
    final DateTime time = DateTime.now();

//    add({
//      'date': DateTime.now().toIso8601String(),
//      'items': cartItems
//          .map((e) => {
//        'quantity': e.quantity,
//        'size': e.size.toString(),
//        'price': e.price,
//        'title': e.title,
//        'userNote': e.userNote,
//        'cheeseQuantity': e.cheeseQuantity.toString(),
//        'meatQuantity': e.meatQuantity.toString()
//      })
//          .toList(),
//      'total': total
//    });
    _orders.add(
      OrderItem(
        id: DateTime.now().toString(),
        items: cartItems,
        date: time,
        total: total,
      ),
    );
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
}
