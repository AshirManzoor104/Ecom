import 'dart:convert';

import 'package:e_com/Pages/Homepage.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class LoggedInWidget extends StatefulWidget {
  const LoggedInWidget({Key key}) : super(key: key);

  @override
  _LoggedInWidgetState createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  String id;
  String dbname;
  String dbemail;
  String name;
  String email;
  Future GoToSignup() async {
    var ApiUrl = 'http://sinbadapp.theazsoft.com/public/api/register';
    Map maped = {
      'name': name.toString(),
      'email': email.toString(),
      'type': 'google',
    };
    final response = await http.post(Uri.parse(ApiUrl), body: maped);
    final jsondata = jsonDecode(response.body);
    if (jsondata["Message"] == "Registered successfully.") {
      Map obj = jsondata['Google Registeration'];
      id = obj['id'].toString();
      dbname = obj['name'].toString();
      dbemail = obj['email'].toString();

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('id', id);
      preferences.setString('dbname', dbname);
      preferences.setString('dbemail', dbemail);
      preferences.setString('type', 'google');
      final location = preferences.getString('location');

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).LoggedinDetails),
        centerTitle: true,
      ),
      body: Container(
        //alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: context.theme.canvasColor,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey[600])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        child:
                            Image(image: AssetImage('assets/sinbadlogo.jpg')),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        child: Text(
                          S.of(context).Googleaccountdetails,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(user.photoURL),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'Name: ' + user.displayName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          'Email: ' + user.email,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                        child: ElevatedButton(
                      onPressed: () {
                        name = user.displayName.toString();
                        email = user.email.toString();
                        GoToSignup();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              context.theme.buttonColor)),
                      child: S.of(context).Continue.text.xl.white.make(),
                    ).w48(context)),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: ElevatedButton(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.GoogleLogout();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              context.theme.buttonColor)),
                      child: S.of(context).Logout.text.xl.white.make(),
                    ).w48(context)),
                    SizedBox(
                      height: 20,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       final provider = Provider.of<GoogleSignInProvider>(
                    //           context,
                    //           listen: false);
                    //       provider.GoogleLogout();
                    //     },
                    //     child: Text("Logout"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
