import 'dart:convert';

import 'package:e_com/Pages/Homepage.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String oldpass;
  String newpass;
  String id;

  getid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
  }

  Future Changepass() async {
    final response = await http.get(Uri.parse(
        'http://sinbadapp.theazsoft.com/public/api/chnagepass/' +
            id +
            '/' +
            oldpass +
            '/' +
            newpass));

    final jsondata = jsonDecode(response.body);
    if (jsondata['Message'] == 'Password updated Successfully') {
      Toast.show(S.of(context).PasswordupdatedSuccessfully, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    } else {
      Toast.show(S.of(context).Oldpasswordiswrong, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  void initState() {
    super.initState();
    getid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Changepassword),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 30),
                      child: Image(image: AssetImage('assets/sinbad.png')),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        S.of(context).Changepassword,
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
                    child: Text(
                      S.of(context).OldPassword,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      // height: 40,
                      decoration: BoxDecoration(
                          color: context.theme.cardColor,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.grey[600])),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              child: Icon(Icons.vpn_key_outlined)),
                          Container(
                            alignment: Alignment.bottomLeft,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextField(
                              obscureText: true,
                              onChanged: (value) {
                                oldpass = value;
                              },
                              decoration: InputDecoration(
                                  hintText: S.of(context).Enteryourpassword,
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      S.of(context).NewPassword,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      // height: 40,
                      decoration: BoxDecoration(
                          color: context.theme.cardColor,
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
                                newpass = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: S.of(context).Password),
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
                      if (oldpass == null) {
                        Toast.show(
                            S.of(context).Oldpasswordcannotbeempty, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (oldpass.length < 5) {
                        Toast.show(
                            S.of(context).Oldpasswordshouldbe6characterslong,
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.CENTER);
                      } else if (newpass == null) {
                        Toast.show(
                            S.of(context).Newpasswordcannotbeempty, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (newpass.length < 6) {
                        Toast.show(
                            S.of(context).Newpasswordshouldbe6characterslong,
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.CENTER);
                      } else {
                        Changepass();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            context.theme.buttonColor)),
                    child: S.of(context).Changepassword.text.xl.white.make(),
                  ).w64(context)),
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
