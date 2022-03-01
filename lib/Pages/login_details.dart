import 'package:e_com/Pages/Homepage.dart';
import 'package:e_com/Pages/google_user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class LoginDetails extends StatefulWidget {
  const LoginDetails({Key key}) : super(key: key);

  @override
  _LoginDetailsState createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<LoginDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return LoggedInWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
