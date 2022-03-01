import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_com/Model/category.dart';
import 'package:e_com/Pages/Product_detail.dart';
import 'package:e_com/Pages/category_detail.dart';
import 'package:e_com/newmodels/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:e_com/Model/product_model.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:e_com/widget/add_to_cart.dart';
import 'image.dart';
import 'dart:convert';

class CatalogList extends StatefulWidget {
  @override
  _CatalogListState createState() => _CatalogListState();
}

class _CatalogListState extends State<CatalogList> {
  List<Categoriesmodel> category = [];

  Future fetchapi() async {
    http.Response response = await http.get(
        Uri.parse("http://sinbadapp.theazsoft.com/public/api/cateogories"));
    Map data = jsonDecode(response.body);
    // print(data);
    if (data["Message"] == "Categories found Successfully") {
      for (int i = 0; i < data["categories"].length; i++) {
        Map obj = data["categories"][i];
        Categoriesmodel pos = new Categoriesmodel();
        pos = Categoriesmodel.fromJson(obj);
        category.add(pos);
        // print(category);
      }
      setState(() {
        //   isloading = false;
      });
    } else {
      setState(() {
        //   isloading = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
            height: 160,
            width: double.infinity,
            child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Category_details(
                                    category_id:
                                        category[index].categoryId.toString(),
                                    name: category[index].name,
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                      width: 90,
                      height: 90,
                      child: Column(
                        children: [
                          Image.network(
                            category[index].image,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            // margin: EdgeInsets.only(left: 10),
                            child: Text(
                              category[index].name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          !context.isMobile
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 20.0),
                  shrinkWrap: true,
                  itemCount: CatalogModel.items.length,
                  itemBuilder: (context, index) {
                    final catalog = CatalogModel.items[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeDetailPage(catalog: catalog),
                        ),
                      ),
                      child: CatalogItem(catalog: catalog),
                    );
                  },
                )
              : Container(
                  //color: Colors.red,
                  margin: EdgeInsets.only(left: 8, right: 8),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 8),
                    shrinkWrap: true,
                    itemCount: CatalogModel.items.length,
                    itemBuilder: (context, index) {
                      final catalog = CatalogModel.items[index];
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeDetailPage(catalog: catalog),
                          ),
                        ),
                        child: CatalogItem(catalog: catalog),
                      );
                    },
                  ),
                ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Products catalog;

  const CatalogItem({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var children2 = [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: context.canvasColor,
              ),
              child: Center(
                child: Container(
                  color: context.canvasColor,
                  height: 70,
                  width: 70,
                  child: Image(
                    image: NetworkImage(
                      catalog.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 6, top: 20),
              child: Text(
                'KWD: ' + catalog.salePrice.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8, top: 10),
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
              catalog.nameEn,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
              margin: EdgeInsets.only(right: 4, top: 10),
              child: AddToCart(catalog: catalog))
        ],
      )
    ];
    return VxBox(
      child: context.isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children2,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: children2,
            ),
    ).color(context.cardColor).rounded.square(150).make().py4();
  }
}
