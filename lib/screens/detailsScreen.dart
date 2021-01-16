import 'package:flutter/material.dart';
import 'package:falafeelo/providers&models/meals.dart';
import 'package:falafeelo/providers&models/carts.dart';
import 'package:falafeelo/providers&models/styles.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

enum Size { Big, Average, small }
enum Quantity { little, normal, alot }

class DetailsScreen extends StatelessWidget {
  final Meal meal;

  DetailsScreen(this.meal);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/placeHolder.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(height: double.infinity),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: FadeInImage(
                      placeholder:
                          AssetImage('assets/images/placeHolder.png'),
                      image: NetworkImage(meal.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Text(
                      meal.title,
                      style:
                          TextStyle(fontFamily: 'Caveat', fontSize: 35),
                    ),
                    top: 20,
                    left: 10,
                  ),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      radius: 30,
                      child: Text(
                        '\$${meal.price}',
                        style: TextStyle(
                            color: Colors.red[800],
                            fontFamily: 'MarckScript',
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    bottom: 15,
                    left: 15,
                  ),
                ],
              ),
              Text(
                meal.description,
                style: TextStyle(fontFamily: 'Caveat', fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              UserPreferences(meal),
              Image.asset('assets/images/logo.png')
            ],
          ),
        ),
      ),
    );
  }
}

class UserPreferences extends StatefulWidget {
  final Meal meal;

  UserPreferences(this.meal);
  @override
  _UserPreferencesState createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  Size chosenSize = Size.Average;
  Quantity meatQuantity = Quantity.normal, cheeseQuantity = Quantity.normal;
  int quantity = 1;
  String userNote;

  String get sizeText {
    switch (chosenSize) {
      case Size.small:
        return 'small';
        break;
      case Size.Big:
        return 'big';
        break;
      default:
        return 'normal';
    }
  }

  String get meatQuantityText {
    switch (meatQuantity) {
      case Quantity.little:
        return 'Little';
        break;
      case Quantity.alot:
        return 'a lot';
        break;
      default:
        return 'normal';
    }
  }

  String get cheeseQuantityText {
    switch (cheeseQuantity) {
      case Quantity.little:
        return 'Little';
        break;
      case Quantity.alot:
        return 'a lot';
        break;
      default:
        return 'normal';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Carts>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Sliders((value) {
          setState(() {
            if (value == 0)
              chosenSize = Size.small;
            else if (value == 1)
              chosenSize = Size.Average;
            else
              chosenSize = Size.Big;
          });
        }, sizeText, 'Size'),
        if (widget.meal.meat)
          Sliders((value) {
            setState(() {
              if (value == 0)
                meatQuantity = Quantity.little;
              else if (value == 1)
                meatQuantity = Quantity.normal;
              else
                meatQuantity = Quantity.alot;
            });
          }, meatQuantityText, 'Meat Quantity'),
        if (widget.meal.cheese)
          Sliders((value) {
            setState(() {
              if (value == 0)
                cheeseQuantity = Quantity.little;
              else if (value == 1)
                cheeseQuantity = Quantity.normal;
              else
                cheeseQuantity = Quantity.alot;
            });
          }, cheeseQuantityText, 'Cheese Quantity'),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 80),
                child: const Text(
                  'Quantity',
                  style: normalText,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 50),
                child: RaisedButton(
                  color: Colors.red[900],
                  child: Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                quantity.toString(),
                style: TextStyle(
                    color: Colors.red[800],
                    fontFamily: 'Caveat',
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 15,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 50),
                child: RaisedButton(
                  color: Colors.red[900],
                  child: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        SizedBox(
          width: double.infinity,
          height: 65,
          child: TextField(
            onChanged: (value) {
              userNote = value;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintStyle: const TextStyle(
                  color: Colors.black45, fontFamily: 'Caveat', fontSize: 25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding: EdgeInsets.only(top: 5, left: 5),
              hintText: 'Type your note here',
            ),
            maxLength: 100,
            style: TextStyle(color: Colors.black),
          ),
        ),
        RaisedButton(
          color: Colors.red[900],
          child: const Text(
            'Add to cart',
            style: TextStyle(
              fontFamily: 'Caveat',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50),
          onPressed: () {
            cartData.addCartItem(
                title: widget.meal.title,
                price: widget.meal.price,
                imageUrl: widget.meal.imageUrl,
                productID: widget.meal.id,
                quantity: quantity,
                size: chosenSize,
                meatQuantity: meatQuantity,
                cheeseQuantity: cheeseQuantity,
                userNote: userNote);
            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black45,
                content: Text(
                  'Item was added to cart',
                  style: normalText.copyWith(fontSize: 15),
                ),
                action: SnackBarAction(
                  label: 'Undo',
                  textColor: Colors.red[800],
                  onPressed: () => cartData.removeSingleItem(widget.meal.id),
                ),
              ),
            );
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class Sliders extends StatefulWidget {
  final Function function;
  final String chipText, title;

  Sliders(this.function, this.chipText, this.title);

  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  double sliderVal = 1;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 100,maxWidth: 100),
          child: Text(
            widget.title,
            style: normalText.copyWith(fontSize: 20),
            softWrap: false,

          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: mediaQuery.width * 0.5),
          child: Slider(
            value: sliderVal,
            divisions: 2,
            min: 0,
            max: 2,
            inactiveColor: Colors.white,
            onChanged: (value) {
              sliderVal = value;
              widget.function(value);
            },
            activeColor: Colors.red[900],
          ),
        ),
        Text(
          widget.chipText,
          style: TextStyle(
              color: Colors.red[800],
              fontFamily: 'Caveat',
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
