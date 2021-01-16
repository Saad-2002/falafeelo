import 'package:falafeelo/screens/categoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:falafeelo/providers&models/meals.dart';
import 'package:falafeelo/screens/detailsScreen.dart';

class MealItem extends StatelessWidget {
  final Meal mealItem;
  MealItem(this.mealItem);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(mealItem))),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: Colors.red[800])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     List: [
                //       Color.fromRGBO(0, 0, 0, 1),
                //       Color.fromRGBO(0, 0, 0, 0.4),
                //     ],
                //     begin: Alignment.centerLeft,
                //     end: Alignment.centerRight,
                //   ),
                // ),
                child: Text(
                  mealItem.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Caveat',
                  ),
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/images/placeHolder.png'),
                  image: NetworkImage(mealItem.imageUrl),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  CategoryItem(this.category);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(category))),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: Colors.red[800])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     List: [
                //       Color.fromRGBO(0, 0, 0, 1),
                //       Color.fromRGBO(0, 0, 0, 0.4),
                //     ],
                //     begin: Alignment.centerLeft,
                //     end: Alignment.centerRight,
                //   ),
                // ),
                child: Text(
                  category.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Caveat',
                  ),
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/images/placeHolder.png'),
                  image: NetworkImage(category.imageUrl),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

