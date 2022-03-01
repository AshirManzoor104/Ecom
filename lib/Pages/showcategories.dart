import 'package:e_com/Model/category.dart';
import 'package:e_com/core/store.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/newmodels/productmodel.dart';
import 'package:e_com/widget/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:convert';

import 'Product_detail.dart';
import 'category_detail.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isCategotyLoading = true;
  var getCatId;
  bool statusof = false;

  List<Categoriesmodel> category = new List();
  Future<Categoriesmodel> fetchapi() async {
    http.Response response = await http.get(
        Uri.parse("http://sinbadapp.theazsoft.com/public/api/cateogories"));
    Map data = jsonDecode(response.body);
    print(data.toString());
    if (data["Message"] == "Categories found Successfully") {
      for (int i = 0; i < data["categories"].length; i++) {
        Map obj = data["categories"][i];
        // getCatId = data['categories'][0];
        print('Category Id====' + getCatId.toString());
        Categoriesmodel pos = new Categoriesmodel();
        pos = Categoriesmodel.fromJson(obj);
        category.add(pos);
      }
      if (statusof == false) {
        getCatId = category[0].categoryId.toString();
        print('cat' + getCatId.toString());
        fetch_categoryproducts();
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

  bool is_status = true;
  var pagenumber = 1;
  bool isloadallproduct = false;
  var getIndex;

  bool is_products_loading = true;
  List<CatalogModel> categoryproducts = [];
  fetch_categoryproducts() async {
    print('catid ' + getCatId.toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var loc = sharedPreferences.getString('location');
    print(loc.toString());

    final response = await http.get(
      Uri.parse(
          'https://sinbadapp.theazsoft.com/api/products/filters?is_for_only_quwait=$loc&page=$pagenumber&cat=' +
              getCatId),
    );
    final jsondata = jsonDecode(response.body);
    print(response.body.toString());

    if (jsondata["Message"] == "Products found Successfully") {
      var produtsData = jsondata["products"]['data'];
      CateoryMutation(getIndex.toString(), 'yes');
      if ((VxState.store as MyStore).items == null ||
          (VxState.store as MyStore).items.toString() == '[]') {
        CatalogModel.items = CatalogModel.items
          ..addAll(List.from(produtsData)
              .map<Products>((item) => Products.fromJson(item))
              .toList());
      } else {
        for (int i = 0; i < produtsData.length; i++) {
          CateoryMutation(getIndex.toString(), 'yes');

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
      CateoryMutation(getCatId, 'yes');

      setState(() {
        is_products_loading = false;
        isloadallproduct = false;
        onlyproductsloadig = false;
      });
      print('length' + (VxState.store as MyStore).items.toString());
    } else {
      CateoryMutation(getIndex.toString(), 'yes');
      setState(() {
        is_products_loading = false;
        isloadallproduct = false;
        onlyproductsloadig = false;
      });
    }
  }

  bool onlyproductsloadig = false;
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    fetchapi();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        pagenumber++;

        setState(() {
          isloadallproduct = true;
        });
        fetch_categoryproducts();
      }
    });
    // fetch_category_details();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Categories'),
      ),
      body: isCategotyLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,
                        //     mainAxisSpacing: 10,
                        //     crossAxisSpacing: 10,
                        //     childAspectRatio: 2 / 2),
                        itemCount: category.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      statusof = true;
                                      print('checking index===' +
                                          index.toString());
                                      print(category[index]
                                          .categoryId
                                          .toString());
                                      setState(() {
                                        //is_products_loading = true;
                                        onlyproductsloadig = true;
                                      });
                                      getCatId =
                                          category[index].categoryId.toString();

                                      CateoryMutation(getCatId, 'yes');
                                      fetch_categoryproducts();
                                      print('kia ha ' + getCatId.toString());

                                      getIndex = index;

                                      // CateoryMutation(
                                      //     category[index].categoryId.toString(), 'yes');
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(
                                      //         // ignore: missing_return
                                      //         builder: (context) {
                                      // Category_details(
                                      //   location: '1',
                                      //   category_id: category[index]
                                      //       .categoryId
                                      //       .toString(),
                                      //   name:
                                      //       S.of(context).English == "عربي"
                                      //           ? category[index].name
                                      //           : category[index].arName,
                                      // );
                                      //  }));
                                    },
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 10),
                                      child: Column(
                                        children: [
                                          // Image.network(
                                          //   category[index].image != null
                                          //       ? category[index].image
                                          //       : CircleAvatar(),
                                          //   fit: BoxFit.cover,
                                          // ),
                                          // SizedBox(
                                          //   height: MediaQuery.of(context)
                                          //           .size
                                          //           .height *
                                          //       0.01,
                                          // ),
                                          Container(
                                            child: Text(
                                              S.of(context).English == "عربي"
                                                  ? category[index].name != null
                                                      ? category[index].name
                                                      : 'name'
                                                  : category[index].arName !=
                                                          null
                                                      ? category[index].arName
                                                      : 'name',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Divider(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.001,
                                            thickness: 2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  // Container(
                  //   width: 1,
                  //   height: double.infinity,
                  //   color: Colors.black,
                  //   //margin: const EdgeInsets.only(right: 4),
                  // ),
                  // Divider(
                  //   height: MediaQuery.of(context).size.height,
                  //   thickness: 1.0,
                  //   color: Colors.black,
                  // ),
                  onlyproductsloadig
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.8,
                          margin: EdgeInsets.all(10),
                          child: VxBuilder(
                            mutations: {SearchMutation},
                            builder: (context, _) => GridView.builder(
                                //physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 2 / 4.7),
                                itemCount:
                                    (VxState.store as MyStore).items.length,
                                itemBuilder: (BuildContext context, index) {
                                  final catalog =
                                      (VxState.store as MyStore).items[index];

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeDetailPage(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.16,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            margin: EdgeInsets.only(
                                                top: 4,
                                                bottom: 4,
                                                left: 6,
                                                right: 4),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            margin: EdgeInsets.only(
                                                left: 6, right: 4),
                                            child: Text(
                                              "KWD " +
                                                          catalog.salePrice
                                                              .toString() !=
                                                      null
                                                  ? "KWD " +
                                                      catalog.salePrice
                                                          .toString() +
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
                                                      left: 6,
                                                      right: 6,
                                                      top: 10),
                                                  decoration: BoxDecoration(),
                                                  child: Text(
                                                    S.of(context).Outofstock,
                                                    style: TextStyle(
                                                        color: Colors.red),
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
}
