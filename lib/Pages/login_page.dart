import 'dart:convert';
import 'dart:ui';

import 'package:e_com/Pages/Homepage.dart';
import 'package:e_com/Pages/checkingforget.dart';
import 'package:e_com/Pages/navbar.dart';
import 'package:e_com/Pages/signup_page.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/provider/google_sign_in.dart';
import 'package:e_com/widget/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  String id;
  String name;
  String dbemail;
  String dbname;

  Future GoToLogin() async {
    final response = await http.get(Uri.parse(
        'http://sinbadapp.theazsoft.com/public/api/loginapi/' +
            email +
            '/' +
            password));
    final jsondata = jsonDecode(response.body);

    if (jsondata["Message"] == "No email exist") {
      Toast.show('No email exist', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (jsondata["Message"] == "No data found") {
      Toast.show('Invalid email or password', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (jsondata['Message'] == 'Data found Successfully') {
      Toast.show('Login Successful', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      Map obj = jsondata['login'];
      id = obj['id'].toString();
      dbemail = obj['email'].toString();
      dbname = obj['name'].toString();

      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setString('id', id);
      preferences.setString('dbemail', dbemail);
      preferences.setString('dbname', dbname);

      preferences.setString('type', 'simple');
      final location = preferences.getString('location');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavBarScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Login),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey[600])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.06),
                      child: Image(image: AssetImage('assets/sinbad.png')),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        S.of(context).Accountlogin,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      S.of(context).EMailAddress,
                      // 'E-Mail Address:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      // height: 40,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.grey[600])),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              child: Icon(Icons.email)),
                          Container(
                            alignment: Alignment.bottomLeft,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  hintText: S.of(context).EmailAddress,
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      S.of(context).Password,
                      // 'Password:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      // height: 40,
                      decoration: BoxDecoration(
                          //  color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.grey[600])),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              child: Icon(Icons.vpn_key)),
                          Container(
                            alignment: Alignment.bottomLeft,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextField(
                              onChanged: (value) {
                                password = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: S.of(context).Enteryourpassword),
                            ),
                          ),
                        ],
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Emailverification()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Text(
                        S.of(context).ForgetPassword + "?",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      if (email == null) {
                        Toast.show(S.of(context).emailerror1, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (email.length < 6) {
                        Toast.show(S.of(context).emailerror2, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (password == null) {
                        Toast.show(S.of(context).Passwordcannotbeempty, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (password.length < 5) {
                        Toast.show(S.of(context).Passwordmustbe6characterslong,
                            context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else {
                        GoToLogin();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            context.theme.buttonColor)),
                    child: S.of(context).Login.text.xl.white.make(),
                  ).w64(context)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        S.of(context).NewCustomer,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            context.theme.buttonColor)),
                    child: S.of(context).Signup.text.xl.white.make(),
                  ).w64(context)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  // Center(
                  //   child: Container(
                  //     child: ElevatedButton.icon(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: context.theme.buttonColor,
                  //         onPrimary: Colors.white,
                  //         // minimumSize: Size(double.infinity, 50),
                  //       ),
                  //       icon: FaIcon(
                  //         FontAwesomeIcons.google,
                  //         color: Colors.red,
                  //       ),
                  //       label: Text(S.of(context).Signupwithgoogle),
                  //       onPressed: () {
                  //         final provider = Provider.of<GoogleSignInProvider>(
                  //             context,
                  //             listen: false);
                  //         provider.GoogleLogin();
                  //       },
                  //     ),
                  //   ).w64(context),
                  // ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
