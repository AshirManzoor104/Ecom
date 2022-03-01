import 'dart:io';

import 'package:e_com/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  _openwhatsapp() async {
    var whatsapp = "+923001761619";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).ContactUs),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  // color: darkcolor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 65.0),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Container(
                  // color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Image.asset(
                      "assets/placecarasol2.jpg",
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                'Sinbad Online Shop',
                style: TextStyle(
                    fontSize: 22,
                    //         fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              highlightColor: Colors.transparent,
              onTap: () {
                _openwhatsapp();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Cardetails()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                alignment: Alignment.center,
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text("Contact us on WhatsApp",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0)),
                      ),
                      Container(
                          height: 44,
                          margin: EdgeInsets.only(right: 10),
                          child: Image(
                            image: AssetImage('assets/whatsappiconmam.png'),
                            fit: BoxFit.cover,
                          )),
                    ]),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _makePhoneCall('tel:03001761619');
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                alignment: Alignment.center,
                height: 60,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text("Call us on +92 300 1761619",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0)),
                      ),
                      Container(
                          height: 40,
                          margin: EdgeInsets.only(right: 10),
                          child: Image(
                            image: AssetImage('assets/phoneiconmam.png'),
                            fit: BoxFit.cover,
                          )),
                    ]),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Container(
                  child: Text(
                'For admin support contact on given number',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.copyright_outlined),
                    Container(
                        margin: EdgeInsets.only(left: 6),
                        child: Text(
                          'Sinbad, all rights reserved 2022',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
