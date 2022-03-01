import 'package:e_com/Pages/Homepage.dart';
import 'package:e_com/Pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return CustomSplash(
      imagePath: 'assets/sinbad.png',
      animationEffect: 'top-down',
      logoSize: 200,
      home: NavBarScreen(
        type: 'splash',
      ),
      duration: 2500,
      type: CustomSplashType.StaticDuration,
    );
  }
}
