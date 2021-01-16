import 'package:falafeelo/providers&models/meals.dart';
import 'package:falafeelo/widgets/mealItem.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final Category ctgs;
  CategoryScreen(this.ctgs);
  @override
  Widget build(BuildContext context) {
    final meals = Provider.of<Meals>(context).meals;
    final List catMeals =
        meals.where((element) => element.category == ctgs.ctg).toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            ctgs.title,
            style: TextStyle(
              fontFamily: 'MarckScript',
              color: Colors.red[800],
              fontSize: 30,
            ),
          ),
          backgroundColor: Colors.black45.withOpacity(1),
        ),
        body: Container(
          padding: EdgeInsets.only(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/placeHolder.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.827,
                child: ListView.builder(
                  itemBuilder: (context, index) => MealItem(catMeals[index]),
                  itemCount:catMeals.length,
                ),
              ),
              Image.asset('assets/images/logo.png')
            ],
          ),
        ),
      ),
    );
  }
}
