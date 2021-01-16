import 'package:falafeelo/providers&models/meals.dart';
import 'package:falafeelo/widgets/appDrawer.dart';
import 'package:falafeelo/widgets/mealItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  List urls = [
    'https://thumbs.dreamstime.com/z/junk-food-concept-unhealthy-food-background-fast-food-sugar-burger-sweets-chips-chocolate-donuts-soda-dark-background-137097179.jpg',
    'https://th.bing.com/th/id/OIP.w9kgES7Z_OSfv9DDRUFYoQHaFj?pid=Api&rs=1',
    'https://insanelygoodrecipes.com/wp-content/uploads/2020/02/Burger-and-Fries.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final ctgs = Provider.of<Meals>(context, listen: false).ctgs;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'falafelloo',
            style: TextStyle(
              fontFamily: 'MarckScript',
              color: Colors.red[800],
              fontSize: 35,
            ),
          ),
          backgroundColor: Colors.black45.withOpacity(0),
        ),
        drawer: AppDrawer(),
        backgroundColor: Colors.black45,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: mediaQuery.height * 0.30,
              child: CarouselSlider(
                key: UniqueKey(),
                items: urls
                    .map(
                      (e) => Container(
                        width: double.infinity,
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder:
                              AssetImage('assets/images/placeHolder.png'),
                          image: NetworkImage(
                            e,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.54,
              width: double.infinity,
              child: ListView.builder(
                itemBuilder: (context, index) => CategoryItem(ctgs[index]),
                itemCount: ctgs.length,
              ),
            ),
            Image.asset('assets/images/logo.png')
          ],
        ),
      ),
    );
  }
}
