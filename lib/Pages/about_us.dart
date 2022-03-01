import 'package:e_com/generated/l10n.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).AboutUs),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).Aboutus1,
                style: TextStyle(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).Aboutus2,
                style: TextStyle(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).Aboutus3,
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
