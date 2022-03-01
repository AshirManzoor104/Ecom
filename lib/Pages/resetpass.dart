import 'dart:convert';

import 'package:e_com/Pages/login_details.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({Key key, @required this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String newpass;
  Future GoToReset() async {
    final response = await http.get(Uri.parse(
        'http://sinbadapp.theazsoft.com/public/api/resetpass/' +
            widget.email +
            '/' +
            newpass));
    Map jsondata = jsonDecode(response.body);
    if (jsondata['Message'] == 'No email exist') {
      Toast.show('No account registered with this email', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginDetails()));
    } else if (jsondata['Message'] == 'Password updated Successfully') {
      Toast.show('Password updated successfully', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginDetails()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          'Reset password',
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
                        'New Password:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        // height: 40,
                        decoration: BoxDecoration(
                            color: context.theme.canvasColor,
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
                                decoration: InputDecoration(
                                    hintText: 'Enter your new password',
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: ElevatedButton(
                      onPressed: () {
                        if (newpass == null) {
                          Toast.show('Password cannot be empty', context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.CENTER);
                        } else if (newpass.length < 6) {
                          Toast.show(
                              'Password should be 6 characters long', context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.CENTER);
                        } else {
                          GoToReset();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              context.theme.buttonColor)),
                      child: "Confirm".text.xl.white.make(),
                    ).w48(context)),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
