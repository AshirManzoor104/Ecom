import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class CatalogHeader extends StatefulWidget {
  const CatalogHeader({Key key}) : super(key: key);
  @override
  _CatalogHeaderState createState() => _CatalogHeaderState();
}

class _CatalogHeaderState extends State<CatalogHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 3),
            height: 30,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 3),
            color: Colors.blue.shade800,
            child: Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Text(
                "Sinbad",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            )),
        SizedBox(
          height: 180.0,
          width: double.infinity,
          child: Carousel(
            images: [
              Image.asset(
                "assets/b1.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "assets/b2.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "assets/b3.jpg",
                fit: BoxFit.cover,
              ),
            ],
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Colors.lightGreenAccent,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.purple.withOpacity(0.5),
            borderRadius: false,
            moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
            overlayShadow: true,
            overlayShadowColors: Colors.white,
            overlayShadowSize: 0.7,
          ),
        ),
      ],
    );
  }
}
