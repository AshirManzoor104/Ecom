import 'package:e_com/Pages/about_us.dart';
import 'package:e_com/Pages/contact_us.dart';
import 'package:e_com/Pages/privacy_policy.dart';
import 'package:e_com/Pages/term_condition.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/provider/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../changelanguage.dart';
import 'account_screen.dart';
import 'login_details.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  logout() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.GoogleLogout();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.remove('id');
    await preferences.remove('dbname');
    await preferences.remove('dbemail');
  }

  String id;
  getid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('More'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              child: Image.asset(
                "assets/sinbad-01.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            id == null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginDetails()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ]),
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height * 0.12,
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LoginDetails()));
                              },
                              child: Text(S
                                  .of(context)
                                  .Logintoyouraccountorregisteranewone)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.004,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context.theme.buttonColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: Text(
                              S.of(context).LoginorRegister,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ]),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LoginDetails()));
                              },
                              child: Text(S
                                  .of(context)
                                  .Logintoyouraccountorregisteranewone)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.004,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context.theme.buttonColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: Text(
                              S.of(context).Account,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                if (S.of(context).English == "عربي") {
                  context.read<ChangeLaanguage>().changelocale("ar");
                } else {
                  context.read<ChangeLaanguage>().changelocale("en");
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.language_sharp),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                    Text(
                      S.of(context).English,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsScreen()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.phone_android),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Text(
                            S.of(context).ContactUs,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsScreen()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.chart_bar),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Text(
                            S.of(context).AboutUs,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsandConditionScreen()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.menu_outlined),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Text(
                            S.of(context).TermsConditions,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyScreen()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.lock),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Text(
                            S.of(context).PrivacyPolicy,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 4, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.copyright_outlined,
                      color: Colors.grey[500],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 6),
                        child: Text(
                          'Sinbad, all rights reserved 2022',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
