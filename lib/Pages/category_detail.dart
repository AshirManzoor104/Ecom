import 'dart:convert';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/newmodels/productmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:e_com/Model/product_model.dart';
import 'package:e_com/core/store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Product_detail.dart';
import 'package:e_com/widget/add_to_cart.dart';

class Category_details extends StatefulWidget {
  final String category_id;
  final String name;
  final String location;
  const Category_details({this.category_id, this.name, this.location, Key key})
      : super(key: key);

  @override
  _Category_detailsState createState() => _Category_detailsState();
}

class _Category_detailsState extends State<Category_details> {
  bool is_status = true;
  var pagenumber = 1;
  bool isloadallproduct = false;

  bool is_products_loading = true;
  List<CatalogModel> categoryproducts = [];
  fetch_categoryproducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var loc = sharedPreferences.getString('location');
    print(loc.toString());

    final response = await http.get(
      Uri.parse(
          'https://sinbadapp.theazsoft.com/api/products/filters?is_for_only_quwait=$loc&page=$pagenumber&cat=' +
              widget.category_id),
    );
    final jsondata = jsonDecode(response.body);
    print(response.body.toString());

    if (jsondata["Message"] == "Products found Successfully") {
      var produtsData = jsondata["products"]['data'];
      CateoryMutation(widget.category_id.toString(), 'yes');
      if ((VxState.store as MyStore).items == null ||
          (VxState.store as MyStore).items.toString() == '[]') {
        CatalogModel.items = CatalogModel.items
          ..addAll(List.from(produtsData)
              .map<Products>((item) => Products.fromJson(item))
              .toList());
      } else {
        for (int i = 0; i < produtsData.length; i++) {
          CateoryMutation(widget.category_id.toString(), 'yes');

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
      CateoryMutation(widget.category_id, 'yes');

      setState(() {
        is_products_loading = false;
        isloadallproduct = false;
      });
      print('length' + (VxState.store as MyStore).items.toString());
    } else {
      CateoryMutation(widget.category_id.toString(), 'yes');
      setState(() {
        is_products_loading = false;
        isloadallproduct = false;
      });
    }
  }

  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    fetch_categoryproducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        pagenumber++;
        // checkConnectivity();
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

  @override
  Widget build(BuildContext context) {
    final MyStore store = VxState.store;
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
      ),
      body: is_products_loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   child: Text(
                  //     'No product found',
                  //     style: TextStyle(fontSize: 18),
                  //   ),
                  // )
                  Container(
                    margin: EdgeInsets.all(10),
                    child: VxBuilder(
                      mutations: {CateoryMutation},
                      builder: (context, _) => GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2 / 2.7),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   width: 1,
                                  //   color: Colors.grey,
                                  // ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // color: Colors.blue,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.14,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
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
                                      margin: EdgeInsets.only(
                                          top: 4, bottom: 4, left: 6, right: 4),
                                      child: Text(
                                        // context
                                        //         .read<ChangeLaanguage>()
                                        //         .changelocale("en")
                                        //     ?
                                        S.of(context).English == "عربي"
                                            ? catalog.nameEn != null
                                                ? catalog.nameEn
                                                : 'name'
                                            : catalog.nameAr != null
                                                ? catalog.nameAr
                                                : 'name',
                                        //: product_list[index].arName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 6, right: 4),
                                      child: Text(
                                        "KWD " + catalog.salePrice.toString() !=
                                                null
                                            ? "KWD " +
                                                catalog.salePrice.toString()
                                            : ' no price',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red.shade600),
                                      ),
                                    ),
                                    AddToCart(catalog: catalog)
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
