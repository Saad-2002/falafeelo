import 'package:flutter/foundation.dart';

enum Categories {
  arabicFood,
  westernFood,
  broasted,
  grillsSandwich,
  appetizer,
  coldDrinks,
  hotDrinks
}

class Meal {
  final String title, description, id, imageUrl;
  final double price;
  final bool cheese, meat;
  final Categories category;

  Meal(
      {@required this.imageUrl,
      @required this.price,
      @required this.id,
      @required this.description,
      @required this.title,
      @required this.cheese,
      @required this.meat,
      @required this.category});
}

class Category {
  final String title, imageUrl;
  final Categories ctg;
  Category({@required this.title, @required this.imageUrl, @required this.ctg});
}

class Meals with ChangeNotifier {
  List<Meal> _meals = [
    Meal(
        id: '111',
        imageUrl:
            'https://cdn0.vox-cdn.com/thumbor/YiPiP8BLj70i8o9O6TpGEVoUkLY=/0x444:7115x5187/1280x853/cdn0.vox-cdn.com/uploads/chorus_image/image/49565113/shutterstock_333689708.0.0.jpg',
        price: 29,
        description: 'bla bla la ',
        title: 'Hamburger',
        meat: true,
        cheese: true,
        category: Categories.westernFood),
    Meal(
        id: '122',
        imageUrl:
            'https://www.eatthis.com/wp-content/uploads/2017/12/mcdonalds-french-fries.jpg',
        price: 29,
        description: 'bla bla la ',
        title: 'Botato fries',
        meat: false,
        cheese: false,
        category: Categories.appetizer),
    Meal(
        id: '133',
        imageUrl:
            'http://3.bp.blogspot.com/_FS4nnKdTUZo/TLIrH2If2kI/AAAAAAAAALM/p-FPQ_JgJVE/s1600/IMG_0422.JPG',
        price: 29,
        description: 'bla bla la ',
        title: 'Crispy',
        meat: true,
        cheese: false,
        category: Categories.grillsSandwich)
  ];

  List<Meal> get meals {
    return [..._meals];
  }

  List<Category> _category = [
    Category(
        title: 'Arabic food',
        imageUrl:
            'https://images.ctfassets.net/sd2voc54sjgs/4BP0E1ov2gIqmI2MKuUyUC/990858e31e6fa72c70f78bbe62ccabdb/UAE_Article_2_hero_1440x900px.jpg',
        ctg: Categories.arabicFood),
    Category(
        title: 'Western food',
        imageUrl:
            'https://tastychomps.com/wp-content/uploads/2019/09/ezgif-1-7c7fb89edfd4.jpg',
        ctg: Categories.westernFood),
    Category(
        title: 'Broasted',
        imageUrl:
            'https://3gwtod2hg0th1ikege3y0nok-wpengine.netdna-ssl.com/wp-content/uploads/2017/05/Fried-Chicken.jpg',
        ctg: Categories.broasted),
    Category(
        title: 'Grills Sandwich',
        imageUrl:
            'https://www.vegrecipesofindia.com/wp-content/uploads/2018/12/veg-grilled-sandwich-1.jpg',
        ctg: Categories.grillsSandwich),
    Category(
        title: 'Appetizers',
        imageUrl:
            'https://c1.staticflickr.com/7/6179/6156326035_38396fd19a_b.jpg',
        ctg: Categories.appetizer),
    Category(
        title: 'Cold Drinks',
        imageUrl:
            'https://th.bing.com/th/id/OIP.wiOFs5MqGT7j91sJ--83NAHaE7?pid=Api&rs=1',
        ctg: Categories.coldDrinks),
    Category(
        title: 'Hot Drinks',
        imageUrl:
            'https://www.seriouseats.com/2018/02/20180205-nonalcoholic-hot-drinks-recipes-roundup-collage-1500x1125.jpg',
        ctg: Categories.hotDrinks),
  ];

  List<Category> get ctgs {
    return _category;
  }
}
