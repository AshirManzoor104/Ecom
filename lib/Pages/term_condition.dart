import 'package:e_com/generated/l10n.dart';
import 'package:flutter/material.dart';

class TermsandConditionScreen extends StatefulWidget {
  const TermsandConditionScreen({Key key}) : super(key: key);

  @override
  _TermsandConditionScreenState createState() =>
      _TermsandConditionScreenState();
}

class _TermsandConditionScreenState extends State<TermsandConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).TermsConditions),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                S.of(context).TermsandConditionh1,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(S.of(context).TermsandConditiond1),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                S.of(context).TermsandConditionh2,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(S.of(context).TermsandConditiond2),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                S.of(context).TermsandConditionh3,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(S.of(context).TermsandConditiond3),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                S.of(context).TermsandConditionh4,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(S.of(context).TermsandConditiond4),
            ),
          ],
        ),
      ),
    );
  }
}
