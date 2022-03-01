import 'package:e_com/Model/product_model.dart';
import 'package:e_com/core/store.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/newmodels/productmodel.dart';
import 'package:e_com/widget/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'Product_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShowSearchProducts extends StatefulWidget {
  final String location;
  final String keyword;
  const ShowSearchProducts(
      {@required this.keyword, @required this.location, Key key})
      : super(key: key);

  @override
  _ShowSearchProductsState createState() => _ShowSearchProductsState();
}

class _ShowSearchProductsState extends State<ShowSearchProducts> {
  bool isloading = true;
  bool is_status = true;
  var pagenumber = 1;
  List<CatalogModel> _showSearch = new List();
  Future<CatalogModel> fetch_search() async {
    final response = await http.get(Uri.parse(
        'https://sinbadapp.theazsoft.com/api/products/filters?is_for_only_quwait=' +
            widget.location +
            '&page=$pagenumber&cat=0&product_name=' +
            widget.keyword));
    final jsondata = jsonDecode(response.body);
    print(response.body.toString());

    if (jsondata["Message"] == "Products found Successfully") {
      var produtsData = jsondata["products"]['data'];
      SearchMutation(widget.keyword.toString());
      if ((VxState.store as MyStore).items == null ||
          (VxState.store as MyStore).items.toString() == '[]') {
        CatalogModel.items = CatalogModel.items
          ..addAll(List.from(produtsData)
              .map<Products>((item) => Products.fromJson(item))
              .toList());
      } else {
        for (int i = 0; i < produtsData.length; i++) {
          SearchMutation(widget.keyword.toString());

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
      SearchMutation(widget.keyword.toString());

      setState(() {
        is_products_loading = false;
        isloadallproduct = false;
      });
      print('length' + (VxState.store as MyStore).items.toString());
    } else {
      SearchMutation(widget.keyword.toString());
      setState(() {
        is_products_loading = false;
        isloadallproduct = false;
      });
    }
  }

  bool is_products_loading = true;
  bool isloadallproduct = false;
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    fetch_search();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        pagenumber++;
        // checkConnectivity();
        setState(() {
          isloadallproduct = true;
        });
        fetch_search();
      }
    });
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
        title: Text('Search products'),
        centerTitle: true,
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
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // color: Colors.blue,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.16,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          catalog.image,
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
