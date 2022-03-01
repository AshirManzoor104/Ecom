//import 'dart:ffi';
import 'package:e_com/Pages/order_history.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'changepassword.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String name;
  String email;
  String type;
  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    name = preferences.getString('dbname');
    email = preferences.getString('dbemail');
    type = preferences.getString('type');

    setState(() {});
  }

  logout() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.GoogleLogout();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.remove('id');
    await preferences.remove('dbname');
    await preferences.remove('dbemail');
    Navigator.pop(context);
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Accountdetails),
        centerTitle: true,
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: context.theme.canvasColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey[600])),
              child: Column(
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
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.theme.canvasColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            S.of(context).Name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2, right: 2),
                          child: Text(
                            name == null ? '' : name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.theme.canvasColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          child: Text(
                            S.of(context).Email,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2, right: 2),
                          child: Text(
                            email == null ? '' : email,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  type == null
                      ? Container()
                      : type == 'google'
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePassword()));
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: context.theme.canvasColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text(
                                        S.of(context).Changepassword,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Icon(Icons.arrow_forward_ios))
                                  ],
                                ),
                              ),
                            ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderHistory1()));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.theme.canvasColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                S.of(context).Myorders,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('logout');
                      logout();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OrderHistory1()));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.theme.canvasColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                S.of(context).Logout,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                    ),
                  ),
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
