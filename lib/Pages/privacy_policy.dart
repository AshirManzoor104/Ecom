import 'package:e_com/generated/l10n.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key key}) : super(key: key);

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).PrivacyPolicy),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                S.of(context).PrivacyPolicyh1,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(S.of(context).PrivacyPolicyd1),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                S.of(context).PrivacyPolicyh2,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(S.of(context).PrivacyPolicyd2),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                S.of(context).PrivacyPolicyh3,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(S.of(context).PrivacyPolicyd3),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                S.of(context).PrivacyPolicyh4,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(S.of(context).PrivacyPolicyd4),
            ),
          ],
        ),
      ),
    );
  }
}
