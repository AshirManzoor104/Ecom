import 'package:e_com/Pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ErrorScree extends StatefulWidget {
  const ErrorScree({Key key}) : super(key: key);

  @override
  _ErrorScreeState createState() => _ErrorScreeState();
}

class _ErrorScreeState extends State<ErrorScree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      // height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/error.png'),
          ),
          Material(
            borderRadius: BorderRadius.circular(8),
            color: Colors.yellow,
            child: InkWell(
              onTap: () => {
                checkConnectivity(),
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: 150,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "RETRY",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashPage()));
      }
    } on SocketException catch (_) {
      await Future.delayed(Duration(milliseconds: 1500), () {});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ErrorScree()));
    }
  }
}
