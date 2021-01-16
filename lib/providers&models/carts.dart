import 'package:flutter/foundation.dart';

class CartItem {
  final String id, title, imageUrl,userNote;
  final double price;
  final int quantity;
  final size, meatQuantity, cheeseQuantity;

  CartItem(
      {@required this.title,
      @required this.price,
      @required this.id,
      @required this.quantity,
      @required this.imageUrl,
      @required this.size,
      this.meatQuantity,
      this.cheeseQuantity,
      this.userNote
      });
}

class Carts with ChangeNotifier {
  Map<String, CartItem> _carts = {};

  Map<String, CartItem> get carts {
    return _carts;
  }

  int getItemCount() {
    return _carts.length;
  }

  void addCartItem(
      {@required String title,
      @required double price,
      @required String imageUrl,
      @required String productID,
      @required int quantity,
      @required size,
      meatQuantity,
      cheeseQuantity,
      userNote
      }) {
    if (_carts.containsKey(productID) && _carts[productID].size == size) {
      _carts.update(
        productID,
        (value) {
          return CartItem(
            title: value.title,
            price: value.price,
            imageUrl: value.imageUrl,
            id: value.id,
            size: value.size,
            meatQuantity: value.meatQuantity,
            cheeseQuantity: value.cheeseQuantity,
            userNote: value.userNote,
            quantity: value.quantity + 1,
          );
        },
      );
    } else {
      _carts.putIfAbsent(
        productID,
        () => CartItem(
          quantity: quantity,
          title: title,
          imageUrl: imageUrl,
          price: price,
          size: size,
          userNote: userNote,
          meatQuantity: meatQuantity,
          cheeseQuantity: cheeseQuantity,
          id: DateTime.now().toString(),
        ),
      );

      notifyListeners();
    }
  }

  double get total {
    double totalSum = 0;
    _carts.forEach((key, value) {
      totalSum =totalSum +(value.price*value.quantity);
    });
    return totalSum;
  }

  void removeSingleItem(String id) {
    if (!_carts.containsKey(id)) {
      return;
    } else if (_carts[id].quantity == 1) {
      _carts.remove(id);
    } else {
      _carts.update(
        id,
        (existingItem) => CartItem(
          imageUrl: existingItem.imageUrl,
          title: existingItem.title,
          id: existingItem.id,
          price: existingItem.price,
          size: existingItem.size,
          cheeseQuantity: existingItem.cheeseQuantity,
          meatQuantity: existingItem.meatQuantity,
          userNote: existingItem.userNote,
          quantity: existingItem.quantity - 1,
        ),
      );
    }
    notifyListeners();
  }
}
