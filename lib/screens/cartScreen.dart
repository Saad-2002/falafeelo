import 'package:falafeelo/providers&models/carts.dart';
import 'package:falafeelo/providers&models/styles.dart';
import 'package:falafeelo/providers&models/orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falafeelo/providers&models/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _fireStore = Firestore.instance;

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Carts>(context);
    final orderData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(1),
        title: Text(
          'Your Cart',
          style: TextStyle(
            fontFamily: 'MarckScript',
            color: Colors.red[700],
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/placeHolder.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Text(
                    'Delivery time \n(10:00 AM - 11:00 PM)',
                    style: normalText.copyWith(fontSize: 20),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.3),
                  height: 80,
                  width: 80,
                  child: Image.asset(
                    'assets/images/Basket.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.48,
              child: cartData.total == 0
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.40,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/noCarts.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'There is no meals..Add some',
                          style: normalText.copyWith(fontSize: 20),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: cartData.carts.length,
                      itemBuilder: (context, index) => Column(
                        children: <Widget>[
                          Dismissible(
                            confirmDismiss: (direction) => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text(
                                    'this will remove one item from your cart'),
                                actions: <Widget>[
                                  FlatButton(
                                      child: Text('yes'),
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      }),
                                  FlatButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) =>
                                Provider.of<Carts>(context, listen: false)
                                    .removeSingleItem(
                                        cartData.carts.keys.toList()[index]),
                            key: UniqueKey(),
                            background: Card(
                              color: Colors.red,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 3),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                cartData.carts.values.toList()[index].title,
                                style: normalText.copyWith(fontSize: 20),
                              ),
                              trailing: Chip(
                                backgroundColor: Colors.white,
                                label: Text(cartData.carts.values
                                    .toList()[index]
                                    .quantity
                                    .toString()),
                                labelStyle: TextStyle(
                                  fontFamily: 'Numbers',
                                  fontSize: 20,
                                  color: Colors.red[800],
                                ),
                              ),
                              subtitle: Text(
                                  '\$ ${cartData.carts.values.toList()[index].price.toString()}'),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            ListTile(
              title: Text(
                'Total',
                style: normalText,
              ),
              trailing: Chip(
                backgroundColor: Colors.red[800],
                label: Text(
                  '\$ ${cartData.total}',
                  style: TextStyle(fontFamily: 'Numbers', fontSize: 15),
                ),
              ),
            ),
            RaisedButton(
              color: Colors.red[900],
              elevation: 5,
              padding: EdgeInsets.symmetric(horizontal: 75),
              child: Text(
                'Order NOW!',
                style: normalText,
              ),
              onPressed: () async {
                final String uid= await Auth().getUID();
                await _fireStore.collection('orders').document(uid).setData({
                  'date': DateTime.now().toIso8601String(),
                  'items': cartData.carts.values
                      .map((e) => {
                    'quantity': e.quantity,
                    'size': e.size.toString(),
                    'price': e.price,
                    'title': e.title,
                    'userNote': e.userNote,
                    'cheeseQuantity': e.cheeseQuantity.toString(),
                    'meatQuantity': e.meatQuantity.toString()
                  })
                      .toList(),
                  'total': cartData.total
                });
                //orderData.addOrder(cartData.carts.values.toList(), cartData.total);
              },
            ),
            Image.asset('assets/images/logo.png')
          ],
        ),
      ),
    );
  }
}
