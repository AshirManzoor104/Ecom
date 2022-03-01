import 'dart:convert';

import 'package:e_com/Pages/Homepage.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String email;
  String id;
  String dbemail;
  String dbname;
  String password;
  String name;
  Future GoToSignup() async {
    var ApiUrl = 'http://sinbadapp.theazsoft.com/public/api/register';
    Map maped = {
      'name': name.toString(),
      'email': email.toString(),
      'password': password.toString(),
      'type': 'simple',
    };
    final response = await http.post(Uri.parse(ApiUrl), body: maped);
    final jsondata = jsonDecode(response.body);
    if (jsondata["Message"] == "Registered successfully.") {
      Map obj = jsondata['Self Registeration:'];
      id = obj['id'].toString();
      dbname = obj['name'].toString();
      dbemail = obj['email'].toString();

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('id', id);
      preferences.setString('dbname', dbname);
      preferences.setString('dbemail', dbemail);
      preferences.setString('type', 'simple');
      final location = preferences.getString('location');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    } else if (jsondata['message'] == 'Validation Error!') {
      Map obj1 = jsondata['Errors'];
      if (obj1['email'].toString() == '[The email has already been taken.]') {
        Toast.show("This email is already registered", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: Colors.white,
        title: Text(S.of(context).Signup),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  //color: Colors.white,
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
                      margin: EdgeInsets.only(top: 30),
                      child: Image(image: AssetImage('assets/sinbad.png')),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Center(
                      child: Text(
                    S.of(context).Enteryourdetails,
                    // 'Enter your details:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      S.of(context).Name,
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
                              child: Icon(Icons.person)),
                          Container(
                            alignment: Alignment.bottomLeft,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextField(
                              onChanged: (value) {
                                name = value;
                              },
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  hintText: S.of(context).EnterName,
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      S.of(context).EMailAddress,
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
                              keyboardType: TextInputType.emailAddress,
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
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      if (name == null) {
                        Toast.show(S.of(context).nameerror1, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (name.length < 3) {
                        Toast.show(S.of(context).nameerror2, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (email == null) {
                        Toast.show(S.of(context).emailerror1, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (email.length < 5) {
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
                        GoToSignup();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            context.theme.buttonColor)),
                    child: S.of(context).Signup.text.white.make(),
                  ).w48(context)),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
