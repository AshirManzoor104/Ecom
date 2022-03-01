import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:e_com/Model/category.dart';
import 'package:e_com/Model/product_model.dart';
import 'package:e_com/Pages/Product_detail.dart';
import 'package:e_com/Pages/category_detail.dart';
import 'package:e_com/Pages/showsearchproducts.dart';
import 'package:e_com/changelanguage.dart';
import 'package:e_com/core/store.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/newmodels/productmodel.dart';
import 'package:e_com/widget/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_com/Pages/cart_page.dart';
import 'package:e_com/Model/cart_model.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_com/widget/drawer.dart';
import 'package:marquee_in_flutter/marquee.dart';
import 'package:e_com/generated/l10n.dart';
import 'errorscreen.dart';

class Carousel_Page extends StatefulWidget {
  final String type;
  const Carousel_Page({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  _Carousel_PageState createState() => _Carousel_PageState();
}

class _Carousel_PageState extends State<Carousel_Page> {
  String loc = '1';
  String values;
  checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // checkingfromsplash();
        fetch_products();

        fetchapi();
        CateoryMutation('null', 'no');
      }
    } on SocketException catch (_) {
      await Future.delayed(Duration(milliseconds: 1500), () {});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ErrorScree()));
    }
  }

  checkingfromsplash() async {
    if (widget.type == 'splash') {
      _showlocationpopup(context);
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      loc = preferences.getString('location');
    }
  }

  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  String location;

  String searching;
  List<Categoriesmodel> category = new List();
  Future<Categoriesmodel> fetchapi() async {
    http.Response response = await http.get(
        Uri.parse("http://sinbadapp.theazsoft.com/public/api/cateogories"));
    Map data = jsonDecode(response.body);
    if (data["Message"] == "Categories found Successfully") {
      for (int i = 0; i < data["categories"].length; i++) {
        Map obj = data["categories"][i];
        Categoriesmodel pos = new Categoriesmodel();
        pos = Categoriesmodel.fromJson(obj);
        category.add(pos);
      }
      setState(() {
        isCategotyLoading = false;
      });
    } else {
      setState(() {
        isCategotyLoading = true;
      });
    }
  }

  final ScrollController _scrollController = new ScrollController();
  bool isCategotyLoading = true;
  TextEditingController _searchController = TextEditingController();

  var pagenumber = 1;
  bool is_products_loading = true;
  List<CatalogModel> product_list = new List();
  fetch_products() async {
    // Map mapdata = {
    //   'is_for_only_quwait': loc,
    //   'page': pagenumber,
    // };
    final response = await http.get(
      Uri.parse(
          'http://sinbadapp.theazsoft.com/public/api/products?is_for_only_quwait=$loc&page=$pagenumber'),
    );
    final jsondata = jsonDecode(response.body.toString());

    print(jsondata.toString());
    if (jsondata["Message"] == "Products found Successfully") {
      var produtsData = jsondata["products"]['data'];
      if (CatalogModel.items.length < 1) {
        CatalogModel.items = CatalogModel.items
          ..addAll(List.from(produtsData)
              .map<Products>((item) => Products.fromJson(item))
              .toList());
      } else {
        for (int i = 0; i < produtsData.length; i++) {
          // CateoryMutation(widget.category_id.toString(), 'yes');

          Map obj = jsondata["products"]['data'][i];
          Products pop = new Products();
          pop = Products.fromJson(obj);
          if ((CatalogModel.items
                  .firstWhere((it) => it.id == pop.id, orElse: () => null)) !=
              null) {
          } else {
            CatalogModel.items = CatalogModel.items..add(pop);
          }
        }
      }
      (VxState.store as MyStore).items = CatalogModel.items;

      setState(() {
        is_products_loading = false;
        isloadallproduct = false;
      });
    } else if (jsondata["Message"] == "No products found") {
      Toast.show('You have reached at the end', context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      setState(() {
        is_products_loading = false;
        isloadallproduct = false;
      });
    } else {
      setState(() {
        is_products_loading = true;
        isloadallproduct = false;
      });
    }
  }

  bool isInCart = true;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
//    gettoken();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        pagenumber++;
        // checkConnectivity();
        setState(() {
          isloadallproduct = true;
        });
        fetch_products();
      }
    });
  }

  bool isloadallproduct = false;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CateoryMutation('null', 'no');
    SearchMutation(values == null ? '' : values);
    final MyStore store = VxState.store;
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      // drawer: DrawerScreen(),
      key: _key,
      appBar: AppBar(
          titleSpacing: 0.00,
          // leading: IconButton(
          //   icon: new Icon(Icons.menu),
          //   onPressed: () => _key.currentState.openDrawer(),
          // ),
          //   elevation: 0,
          title: Container(
            margin: EdgeInsets.only(right: 4, left: 4),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: CupertinoSearchTextField(
                style: TextStyle(color: context.theme.indicatorColor),
                onChanged: (value) {
                  values = value.toLowerCase();
                },
                onSubmitted: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowSearchProducts(
                              keyword: values.toString(), location: '1')));
                },
              ),
            ),
          )),

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
              width: double.infinity,
              child: Carousel(
                images: [
                  Image.asset(
                    "assets/placecarasol1.jpeg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/place1.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/placecarasol4.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/place2.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/placecarasol2.jpg",
                    fit: BoxFit.cover,
                  ),
                ],
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.lightGreenAccent,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.transparent,
                borderRadius: false,
                moveIndicatorFromBottom: 180.0,
                noRadiusForIndicator: true,
                overlayShadow: true,
                dotPosition: DotPosition.bottomRight,
                overlayShadowColors: Colors.white,
                overlayShadowSize: 0.7,
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                'Top Categories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // CateoryMutation(
                        //     category[index].categoryId.toString(), 'yes');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Category_details(
                                      location: loc,
                                      category_id:
                                          category[index].categoryId.toString(),
                                      name: S.of(context).English == "عربي"
                                          ? category[index].name
                                          : category[index].arName,
                                    )));
                      },
                      child: Container(
                        // margin:
                        //     EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                        margin: EdgeInsets.only(top: 20),
                        // width: MediaQuery.of(context).size.width / 6,
                        width: MediaQuery.of(context).size.width * 0.2,
                        //height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  category[index].image != null
                                      ? category[index].image
                                      : CircleAvatar(),
                                ),
                              ),
                            ),
                            // Image.network(
                            //   category[index].image != null
                            //       ? category[index].image
                            //       : CircleAvatar(),
                            //   fit: BoxFit.cover,
                            // ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 12, right: 12),
                              child: Text(
                                S.of(context).English == "عربي"
                                    ? category[index].name != null
                                        ? category[index].name
                                        : 'name'
                                    : category[index].arName != null
                                        ? category[index].arName
                                        : 'name',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    S.of(context).Products4u,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            is_products_loading
                ? Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(10),
                    child: VxBuilder(
                      mutations: {SearchMutation},
                      builder: (context, _) => GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2 / 3.3),
                          itemCount: store.items.length,
                          itemBuilder: (BuildContext context, index) {
                            final catalog = store.items[index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeDetailPage(
                                              catalog: catalog,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   width: 1,
                                    //   color: Colors.grey,
                                    // ),
                                    // borderRadius: BorderRadius.circular(10),
                                    ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          catalog.images[0].url,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      margin: EdgeInsets.only(
                                          top: 4, bottom: 4, left: 6, right: 4),
                                      child: Text(
                                        S.of(context).English == "عربي"
                                            ? catalog.nameEn != null
                                                ? catalog.nameEn
                                                : 'name'
                                            : catalog.nameAr != null
                                                ? catalog.nameAr
                                                : 'name',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.4,
                                      margin:
                                          EdgeInsets.only(left: 6, right: 4),
                                      child: Text(
                                        "KWD " + catalog.salePrice.toString() !=
                                                null
                                            ? "KWD " +
                                                catalog.salePrice.toString() +
                                                '/pieces'
                                            : ' no price',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red.shade600),
                                      ),
                                    ),
                                    (catalog.inStock == '1')
                                        ? AddToCart(catalog: catalog)
                                        : Container(
                                            margin: EdgeInsets.only(
                                                left: 6, right: 6, top: 10),
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              S.of(context).Outofstock,
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
            SizedBox(
                height: 60,
                child: isloadallproduct
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()),
          ],
        ),
      ),
    );
  }

  _showlocationpopup(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: context.theme.canvasColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    spreadRadius: .1)
                              ]),
                          margin: EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 14, left: 10, right: 10),
                                child: ('Select Your Location ')
                                    .text
                                    .xl2
                                    .bold
                                    .make(),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 20,
                                ),
                                child: Text(
                                  'Are you located in Kuwait?',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        loc = '1';
                                        fetch_products();
                                        fetchapi();
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        preferences.setString('location', '1');
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                      },
                                      child: Container(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        loc = '0';
                                        fetch_products();
                                        fetchapi();
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        preferences.setString('location', '0');
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20),
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ])),
          );
        });
  }
}
