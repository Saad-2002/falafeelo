import 'package:flutter/material.dart';
import 'package:falafeelo/providers&models/styles.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:falafeelo/providers&models/authentication.dart';

enum Current { signUp, login, newUser }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String firstFieldPassword, email, password, userName;
  Current current = Current.signUp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(
              height: current == Current.signUp ? 70 : 150,
            ),
            CircleAvatar(
              backgroundColor: Colors.red[800],
              radius: 60,
              backgroundImage: NetworkImage(
                'https://image.freepik.com/free-vector/cartoon-chef-cook-mascot-logo_10308-52.jpg',
              ),
            ),
            if (current == Current.signUp)
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 8, left: 8, right: 8),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black45),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'User Name'),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black45),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Email'),
                validator: (value) {
                  if (!value.endsWith('.com') || !value.contains('@'))
                    return 'please enter a valid Email';
                  return null;
                },
                onChanged: (value) => email = value,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black45),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Password'),
                validator: (value) {
                  if (value.length <= 6) return 'weak password';
                  return null;
                },
                onChanged: (value) {
                  firstFieldPassword = value;
                },
                obscureText: true,
              ),
            ),
            if (current == Current.signUp)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black45),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Confirm Password'),
                  validator: (value) {
                    if (value != firstFieldPassword)
                      return 'passwords doesn\'t match';
                    return null;
                  },
                  onChanged: (value) {
                    if (value == firstFieldPassword) password = value;
                  },
                  obscureText: true,
                ),
              ),
            FlatButton(
              child: Text(
                  current == Current.signUp
                      ? 'I have an account'
                      : 'new member!',
                  style: normalText.copyWith(fontSize: 20)),
              onPressed: () {
                if (current == Current.login)
                  setState(() {
                    current = Current.signUp;
                  });
                else
                  setState(() {
                    current = Current.login;
                  });
              },
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 125),
              color: Colors.red[800],
              onPressed: () async {
                try {
                  if (current == Current.signUp)
                    await Auth().signUp(email, password);
                  else if (current == Current.login)
                    await Auth()
                        .signIn(email, password)
                        .then((_) => Auth().getUID());
                } catch (e) {
                  print(e);
                }
              },
              child: Text(current == Current.login
                  ? 'Log In'
                  : current == Current.signUp ? 'Sign up' : 'Log Out'),
              elevation: 5,
            ),
            SignInButton(
              Buttons.Facebook,
              text: 'Sign up with Facebook',
              onPressed: () {
                Auth().facebookLogin();
              },
            ),
            SignInButton(
              Buttons.Google,
              text: 'Sign up with Google',
              onPressed: () {
                Auth().signInWithGoogle();
              },
            ),
            Image.asset('assets/images/logo.png')
          ],
        ),
      ),
    );
  }
}
