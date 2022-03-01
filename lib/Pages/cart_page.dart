import 'dart:convert';
import 'package:e_com/Pages/login_page.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/newmodels/productmodel.dart';
import 'package:e_com/widget/add_to_cart.dart';
import 'package:e_com/widget/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_com/core/store.dart';
import 'package:e_com/Model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:velocity_x/velocity_x.dart';
import 'package:toast/toast.dart';
import 'billing_detail.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final String location;
  const CartPage({this.location, Key key}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

List<Products> _list = [];

List<int> _itemquantity = [];
List<double> _itemprice = [];

class _CartPageState extends State<CartPage> {
  // List<ProductIds> category = [];

  String id;
  gettoken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    //  fetchapi();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken();
  }

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;

    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: S.of(context).Cart.text.make(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _CartList().expand(),
          //Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatefulWidget {
  @override
  __CartTotalState createState() => __CartTotalState();
}

class __CartTotalState extends State<_CartTotal> {
  String id;
  getid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');

    setState(() {});
  }

  String isSuccess;
  String message;
  String validationError;
  String invoiceId;
  String invoiceUrl;
  String customerReference;
  String userDefinedFiels;

  void initState() {
    super.initState();
    getid();
  }

  @override
  Widget build(BuildContext context) {
    int availablestock;

    final CartModel _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      //height: MediaQuery.of(context).size.height * 0.08,
      child: Container(
        decoration: BoxDecoration(
            color: context.theme.cardColor,
            // border:
            //     Border(top: BorderSide(width: 1, color: Colors.grey.shade400)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 10,
            ),
            VxBuilder(
              mutations: {AddMutation, RemoveMutation, UpdateMutation},
              builder: (context, _) {
                return Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            )),
                        Text(
                          "KWD${_cart.totalPrice.toStringAsFixed(3)}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                );
              },
            ),
            //
            //  30.widthBox,

            GestureDetector(
              onTap: () {
                _itemquantity.clear();
                _itemprice.clear();
                for (int i = 0; i < _cart.items.length; i++) {
                  _itemquantity.add(_cart.items[i].number);
                  _itemprice.add(_cart.items[i].finalPrice);
                }
                if (_cart.totalPrice == 0) {
                  Toast.show('Your cart is empty', context,
                      gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
                } else if (id == null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetail12(
                                price: _cart.totalPrice,
                                idzz: _cart.idzzzz,
                                itemprice: _itemprice,
                                itemquantity: _itemquantity,
                              )));
                } //sendPayment();
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: MyTheme.redColor,
                    borderRadius: BorderRadius.circular(4)),
                height: 36,
                alignment: Alignment.center,
                child: S.of(context).Checkout.text.xl.semiBold.white.make(),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     _itemquantity.clear();
            //     _itemprice.clear();
            //     for (int i = 0; i < _cart.items.length; i++) {
            //       _itemquantity.add(_cart.items[i].number);
            //       _itemprice.add(_cart.items[i].finalPrice);
            //     }
            //     if (_cart.totalPrice == 0) {
            //       Toast.show('Your cart is empty', context,
            //           gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
            //     } else if (id == null) {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => LoginPage()));
            //     } else {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => OrderDetail12(
            //                     price: _cart.totalPrice,
            //                     idzz: _cart.idzzzz,
            //                     itemprice: _itemprice,
            //                     itemquantity: _itemquantity,
            //                   )));
            //     } //sendPayment();
            //   },
            //   style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(Colors.red)),
            //   child: S.of(context).Checkout.text.white.make(),
            // )
          ],
        ),
      ),
    );
  }
}

class HTML {}

class _CartList extends StatefulWidget {
  @override
  __CartListState createState() => __CartListState();
}

int quantity = 1;
int availablestock;
int numberrr;
num pricing;
String checkprice;

class __CartListState extends State<_CartList> {
  // List<ProductIds> category = [];
  // Future<ProductIds> fetchapi() async {
  //   http.Response response = await http.get(Uri.parse(
  //       "https://sinbadapp.theazsoft.com/api/order_product_history/18"));
  //   Map data = jsonDecode(response.body);

  //   if (data["Message"] == "Products Ids found") {
  //     print('this is response' + response.body.toString());
  //     for (int i = 0; i < data["product_ids"].length; i++) {
  //       Map obj = data["product_ids"][i];
  //       ProductIds pos = new ProductIds();
  //       pos = ProductIds.fromJson(obj);
  //       category.add(pos);
  //     }
  //     setState(() {
  //       //  isCategotyLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       // isCategotyLoading = true;
  //     });
  //   }
  // }

  addq() {
    numberrr < availablestock
        ? setState(() {
            numberrr = numberrr + 1;
          })
        : numberrr = numberrr;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken();
    // fetchapi();
    //fetchRelated();
  }

  String id;
  gettoken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    print('id' + id.toString());
    //fetchRelated();
    fetchapi();
  }

  fetchapi() async {
    setState(() {
      id == null ? againloading = false : againloading = true;
    });

    http.Response response = await http.get(Uri.parse(
        "https://sinbadapp.theazsoft.com/api/order_product_history/$id"));
    Map data = jsonDecode(response.body);
    //print('this is response' + response.body.toString());

    if (data["Message"] == "Products Ids found") {
      var produtsData = data["product_ids"];
      print('this is response 234' + data['product_ids'].toString());

      for (int i = 0; i < produtsData.length; i++) {
        // CateoryMutation(widget.category_id.toString(), 'yes');

        Map obj = data["product_ids"][i];
        Products pop = new Products();
        pop = Products.fromJson(obj);
        _list.add(pop);

        if ((CatalogModel.items
                .firstWhere((it) => it.id == pop.id, orElse: () => null)) !=
            null) {
          if (((VxState.store as MyStore)
                  .cart
                  .items
                  .firstWhere((it) => it.id == pop.id, orElse: () => null)) !=
              null) {
          } else {
            orderagainproducts.add(pop);
          }
        } else {
          CatalogModel.items = CatalogModel.items..add(pop);
          orderagainproducts.add(pop);
        }
      }
      (VxState.store as MyStore).items = CatalogModel.items;
      setState(() {
        againloading = false;
      });
      print('this is list ' + _list.toString());
    } else {
      setState(() {
        againloading = false;
        // isCategotyLoading = true;
      });
    }
  }

  List<Products> relatedproducts = [];
  List<Products> orderagainproducts = [];

  fetchRelated() {
    if ((VxState.store as MyStore).cart.items.length > 0) {
      relatedproducts = CatalogModel.items
          .where((element) =>
              element.categories[0].pivot.categoryId ==
              (VxState.store as MyStore)
                  .cart
                  .items[0]
                  .categories[0]
                  .pivot
                  .categoryId)
          .toList();
      setState(() {});

      print('related ' + relatedproducts.toString());
    }
  }

  String len;
  bool againloading = true;
  // updatedlist() {
  //   orderagainproducts.clear();
  //   for (int i = 0; i < _list.length; i++) {
  //     if (((VxState.store as MyStore)
  //             .cart
  //             .items
  //             .firstWhere((it) => it.id == _list[i].id, orElse: () => null)) !=
  //         null) {
  //       print('yes');
  //     } else {
  //       print('nooooo');

  //       orderagainproducts.add(_list[i]);
  //     }
  //   }
  //   setState(() {
  //     againloading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    VxState.listen(context, to: [RemoveMutation, UpdateMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    return
        //  _cart.items.isEmpty
        //     ? "Nothing to show".text.xl3.makeCentered()
        //:
        SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            againloading
                ? Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : orderagainproducts.length > 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Order again',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 0, right: 6),
                              height: MediaQuery.of(context).size.height * .128,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: orderagainproducts.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(left: 6),
                                      //   width: MediaQuery.of(context).size.width * 0.04,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 6, left: 4, right: 4),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.08,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5.2,
                                              child: Image(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    orderagainproducts[index]
                                                        .helperImage),
                                              )),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          //   AddToCart(catalog: _list[index])
                                          GestureDetector(
                                            onTap: () {
                                              AddMutation(
                                                  orderagainproducts[index]);
                                              setState(() {
                                                //againloading = true;
                                                orderagainproducts.remove(
                                                    orderagainproducts[index]);
                                                //   orderagainproducts.clear();
                                              });
                                              //updatedlist();
                                              // orderagainproducts = orderagainproducts =
                                              //     CatalogModel.items
                                              //         .where((element) =>
                                              //             element.id !=
                                              //             (VxState.store as MyStore)
                                              //                 .c
                                              //                 )
                                              //         .toList();
                                              setState(() {});
                                            },
                                            child: Text('ADD',
                                                style: TextStyle(
                                                  color: MyTheme.redColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                        ],
                                      ),
                                    );
                                  })),
                        ],
                      )
                    : Container(),
            _cart.items.isEmpty
                ? Container(
                    height: orderagainproducts.length > 0
                        ? MediaQuery.of(context).size.height / 2
                        : MediaQuery.of(context).size.height / 1.5,
                    child: "Cart is Empty".text.xl2.semiBold.makeCentered())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Total: ${_cart.items.length} items',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                            color: context.theme.cardColor),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                  itemCount: _cart.items.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Container(
                                      alignment: Alignment.topCenter,
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      // height: MediaQuery.of(context).size.height * 0.28,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 6,
                                                      left: 4,
                                                      right: 4),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5.2,
                                                  child: Image(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                      // _cart.items[index].images
                                                      //             .length >
                                                      //         0
                                                      //     ?
                                                      //     _cart.items[index]
                                                      //         .images[0].url
                                                      //     :

                                                      _cart.items[index]
                                                          .helperImage,
                                                    ),
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                  // height:
                                                  //     MediaQuery.of(context).size.height *
                                                  //         0.14,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.2,
                                                  child: Column(
                                                    // mainAxisAlignment:
                                                    // MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        (S
                                                                    .of(context)
                                                                    .English ==
                                                                "عربي")
                                                            ? _cart.items[index]
                                                                        .nameEn !=
                                                                    null
                                                                ? _cart
                                                                    .items[
                                                                        index]
                                                                    .nameEn
                                                                : 'name'
                                                            : _cart.items[index]
                                                                        .nameAr !=
                                                                    null
                                                                ? _cart
                                                                    .items[
                                                                        index]
                                                                    .nameAr
                                                                : 'name',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Container(
                                                          // height: MediaQuery.of(context)
                                                          //         .size
                                                          //         .height *
                                                          //     0.023,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 2),
                                                          child: Text(
                                                            "KWD" + "${_cart.items[index].finalPrice}" !=
                                                                    null
                                                                ? "KWD" +
                                                                    "${_cart.items[index].finalPrice.toStringAsFixed(3)}"
                                                                : 'no price',
                                                            style: TextStyle(
                                                                //  fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .red
                                                                    .shade400),
                                                          )),
                                                    ],
                                                  )),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01,
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.02),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              checkprice =
                                                                  "${_cart.items[index].finalPrice}";

                                                              if (_cart
                                                                      .items[
                                                                          index]
                                                                      .number >
                                                                  1) {
                                                                setState(() {
                                                                  _cart
                                                                      .items[
                                                                          index]
                                                                      .number--;
                                                                });
                                                                setState(() {
                                                                  _cart
                                                                      .items[
                                                                          index]
                                                                      .finalPrice = _cart
                                                                          .items[
                                                                              index]
                                                                          .salePrice *
                                                                      _cart
                                                                          .items[
                                                                              index]
                                                                          .number;
                                                                  UpdateMutation(
                                                                      _cart.items[
                                                                          index]);
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.038,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.08,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: Colors
                                                                    .red
                                                                    .shade100,
                                                              ),
                                                              child: _cart
                                                                          .items[
                                                                              index]
                                                                          .number ==
                                                                      1
                                                                  ? GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        RemoveMutation(
                                                                            _cart.items[index]);
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        CupertinoIcons
                                                                            .delete,
                                                                        size: MediaQuery.of(context).size.height *
                                                                            0.025,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .remove,
                                                                      size: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.022,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.03,
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            // width:
                                                            //     MediaQuery.of(context)
                                                            //             .size
                                                            //             .width *
                                                            //         0.12,
                                                            // decoration: BoxDecoration(
                                                            //     color: Colors
                                                            //         .grey.shade300,
                                                            //     border: Border.all()),
                                                            child: Row(
                                                                children: [
                                                                  Text(
                                                                    _cart
                                                                        .items[
                                                                            index]
                                                                        .number
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        // fontSize: 20,
                                                                        fontWeight: FontWeight.w600

                                                                        // color:
                                                                        //     Colors.blueGrey,
                                                                        ),
                                                                  ),
                                                                  // SizedBox(
                                                                  //   width: 4,
                                                                  // ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      _groupValue =
                                                                          _cart.items[index].number -
                                                                              1;
                                                                      _bottomSheetMore(
                                                                          context,
                                                                          index);
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .arrow_drop_down),
                                                                  )
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.01,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              availablestock =
                                                                  int.parse(_cart
                                                                      .items[
                                                                          index]
                                                                      .stock);
                                                              numberrr = _cart
                                                                  .items[index]
                                                                  .number;

                                                              _cart.items[index]
                                                                          .number <
                                                                      int.parse(_cart
                                                                          .items[
                                                                              index]
                                                                          .stock)
                                                                  ? setState(
                                                                      () {
                                                                      numberrr =
                                                                          _cart.items[index].number +
                                                                              1;
                                                                      _cart
                                                                          .items[
                                                                              index]
                                                                          .number = numberrr;
                                                                    })
                                                                  : Toast.show(
                                                                      "You have reached maximum",
                                                                      context,
                                                                      duration:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: Toast
                                                                          .BOTTOM);
                                                              setState(() {
                                                                _cart
                                                                    .items[
                                                                        index]
                                                                    .finalPrice = _cart
                                                                        .items[
                                                                            index]
                                                                        .salePrice *
                                                                    _cart
                                                                        .items[
                                                                            index]
                                                                        .number;
                                                                UpdateMutation(
                                                                    _cart.items[
                                                                        index]);
                                                              });
                                                            },
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.038,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.08,
                                                              // height: MediaQuery.of(
                                                              //             context)
                                                              //         .size
                                                              //         .height *
                                                              //     0.03,
                                                              // width: MediaQuery.of(
                                                              //             context)
                                                              //         .size
                                                              //         .width *
                                                              //     0.06,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: MyTheme
                                                                          .redColor,
                                                                      // border: Border.all(
                                                                      //     color: Colors
                                                                      //         .black),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                              child: Icon(
                                                                Icons.add,
                                                                size: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.025,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Divider(
                                          //   thickness: 1,
                                          // ),
                                          // Container(
                                          //   margin: EdgeInsets.only(
                                          //       left: MediaQuery.of(context).size.height *
                                          //           0.03),
                                          //   child: TextButton(
                                          //       onPressed: () {
                                          //         RemoveMutation(_cart.items[index]);
                                          //       },
                                          //       child: Text(
                                          //         S.of(context).Remove,
                                          //         style: TextStyle(
                                          //             fontSize: 18.0,
                                          //             color: Colors.red.shade600,
                                          //             fontWeight: FontWeight.w600),
                                          //       )),
                                          //)
                                        ],
                                      ))),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 4, right: 20),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Subtotal'),
                                        Text(
                                          'KWD${_cart.totalPrice.toStringAsFixed(3)}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )
                                      ]))
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Related Products',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 0, right: 6),
                        height: MediaQuery.of(context).size.height * .128,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: relatedproducts.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(left: 6),
                                //   width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 6, left: 4, right: 4),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5.2,
                                        child: Image(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            relatedproducts[index]
                                                .images[0]
                                                .url,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text('ADD',
                                        style: TextStyle(
                                          color: MyTheme.redColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
          ]),
    );
  }
}

int _groupValue = 0;
void _bottomSheetMore(context, int i) {
  showModalBottomSheet(
    // shape: ShapeBorder(BorderRadius.circular(12)),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,

    context: context,
    builder: (builder) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18))),
        child: Wrap(children: <Widget>[
          Container(
            height: 20,
          ),
          ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index11) {
                //  return
                // StatefulBuilder(builder: (BuildContext context,
                //     StateSetter setState /You can rename this!/) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 0, right: 14),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            value: index11,
                            groupValue: _groupValue,
                            onChanged: (val) {
                              print('qqq' +
                                  _groupValue.toString() +
                                  val.toString());
                              // setState(() {
                              Navigator.pop(context);
                              _groupValue = val;
                              (VxState.store as MyStore).cart.items[i].number =
                                  (index11 + 1);
                              UpdateMutation(
                                  (VxState.store as MyStore).cart.items[i]);
                              // });

                              // setState(() {
                              //  // selectedindex..clear();
                              //   print("checking value" +
                              //       _groupValue.toString());
                              //   finalprice = double.parse(
                              //       _extremedetail[index1]
                              //           .price
                              //           .toString());
                              //   cc = _extremedetail[index1]
                              //       .name
                              //       .toString();
                              //   onlycarprice =
                              //       _extremedetail[index1]
                              //           .price
                              //           .toString();

                              //   print('priceeeee' +
                              //       finalprice.toString());

                              //     _groupValue = val as int;
                              //                                                  });
                            }),
                        Container(
                          //color: Colors.red,
                          width: MediaQuery.of(context).size.width / 1.22,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (index11 + 1).toString(),
                                style: (index11 + 1) ==
                                        (VxState.store as MyStore)
                                            .cart
                                            .items[i]
                                            .number
                                    ? TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue[800])
                                    : TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ((index11 + 1) *
                                        (VxState.store as MyStore)
                                            .cart
                                            .items[i]
                                            .finalPrice)
                                    .toStringAsFixed(3),
                                style: (index11 + 1) ==
                                        (VxState.store as MyStore)
                                            .cart
                                            .items[i]
                                            .number
                                    ? TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue[800])
                                    : TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ]),
                );
              }),
          Container(
            height: 20,
          ),
        ]),
      );
    },
  );
}
