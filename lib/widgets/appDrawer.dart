import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark()
          .copyWith(canvasColor: Colors.black87.withOpacity(0.6)),
      child: Drawer(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://image.freepik.com/free-vector/cartoon-chef-cook-mascot-logo_10308-52.jpg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'User name',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.red[800],
                  fontFamily: 'MarckScript',
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.white,
            ),
            ListTile(
              title: Text('Log In'),
              onTap: () => Navigator.pushNamed(context, '/authScreen'),
            ),
            Divider(
              endIndent: 75,
              thickness: 1,
              color: Colors.white,
            ),
            ListTile(
              title: Text('Your Cart'),
              leading: Icon(Icons.shopping_cart),
              onTap: () => Navigator.pushNamed(context, '/cartScreen'),
            ),
          ],
        ),
      ),
    );
  }
}
