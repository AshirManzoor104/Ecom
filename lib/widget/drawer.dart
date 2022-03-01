import 'package:e_com/Pages/account_screen.dart';
import 'package:e_com/Pages/login_details.dart';
import 'package:e_com/Pages/login_page.dart';
import 'package:e_com/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:e_com/changelanguage.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/generated/intl/messages_all.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_com/widget/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      color: context.theme.canvasColor,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 150,
              width: 40,
              child: DrawerHeader(
                  decoration: BoxDecoration(),
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/sinbad.png'),
                  )),
            ),
            id == null
                ? ListTile(
                    leading: IconTheme(
                        data: new IconThemeData(
                            color: context.theme.indicatorColor),
                        child: Icon(Icons.login)),
                    title: Text(
                      S.of(context).Login,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginDetails()));
                    },
                  )
                : ListTile(
                    leading: IconTheme(
                        data: new IconThemeData(
                            color: context.theme.indicatorColor),
                        child: Icon(Icons.person)),
                    title: Text(
                      S.of(context).Account,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountScreen()));
                    },
                  ),
            Divider(
              color: Colors.green,
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: IconTheme(
                  data: new IconThemeData(color: context.theme.indicatorColor),
                  child: Icon(Icons.language_sharp)),
              title: Text(
                S.of(context).English,
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                if (S.of(context).English == "عربي") {
                  context.read<ChangeLaanguage>().changelocale("ar");
                } else {
                  context.read<ChangeLaanguage>().changelocale("en");
                }

                Navigator.pop(context);
              },
            ),
            id == null
                ? Container()
                : Divider(
                    color: Colors.green,
                  ),
            id == null
                ? Container()
                : ListTile(
                    leading: IconTheme(
                        data: new IconThemeData(
                            color: context.theme.indicatorColor),
                        child: Icon(Icons.logout)),
                    title: Text(
                      S.of(context).Logout,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      logout();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
