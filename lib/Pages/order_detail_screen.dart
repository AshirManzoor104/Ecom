import 'dart:convert';
import 'package:e_com/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:e_com/Model/order_history.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderDetailScreen extends StatefulWidget {
  final int index;
  const OrderDetailScreen({Key key, @required this.index}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<OrderHistory> _order = new List();
  String id;
  bool isloading = true;
  getid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    GetAllOrders();
  }

  Future GetAllOrders() async {
    http.Response response = await http.get(Uri.parse(
        "http://sinbadapp.theazsoft.com/public/api/orderhistory/" + id));
    Map data = jsonDecode(response.body);
    print(response.body.toString());
    if (data["Message"] == "Orders found Successfully") {
      for (int i = 0; i < data["OrderHistory"].length; i++) {
        Map obj = data["OrderHistory"][i];
        OrderHistory pos = new OrderHistory();
        pos = OrderHistory.fromJson(obj);
        _order.add(pos);
      }
      setState(() {
        isloading = false;
      });
    } else {
      setState(() {
        // isloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).Orderhistory),
          centerTitle: true,
        ),
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: context.theme.canvasColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey[600])),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  margin: EdgeInsets.only(top: 30),
                                  child: Image(
                                      image: AssetImage('assets/sinbad.png')),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: Container(
                                  child: Text(
                                    S.of(context).Orderdetails != null
                                        ? S.of(context).Orderdetails
                                        : 'hello',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _order[widget.index]
                                      .pacakgeDetails
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: context.theme.cardColor),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      height: 80,
                                                      width: 80,
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: Image(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(_order[
                                                                        widget
                                                                            .index]
                                                                    .pacakgeDetails[
                                                                        index]
                                                                    .productData
                                                                    .helperImage ==
                                                                null
                                                            ? ''
                                                            : _order[widget
                                                                    .index]
                                                                .pacakgeDetails[
                                                                    index]
                                                                .productData
                                                                .helperImage),
                                                      )),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.8,
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    child: Text(
                                                        (S
                                                                    .of(context)
                                                                    .English ==
                                                                "عربي")
                                                            ? _order[widget.index]
                                                                        .pacakgeDetails[
                                                                            index]
                                                                        .productData
                                                                        .nameEn !=
                                                                    null
                                                                ? _order[widget
                                                                        .index]
                                                                    .pacakgeDetails[
                                                                        index]
                                                                    .productData
                                                                    .nameEn
                                                                : 'name'
                                                            : _order[widget
                                                                    .index]
                                                                .pacakgeDetails[
                                                                    index]
                                                                .productData
                                                                .nameAr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20,
                                                        left: 4,
                                                        right: 10),
                                                    child: Text(
                                                        'KWD' +
                                                            _order[widget.index]
                                                                .pacakgeDetails[
                                                                    index]
                                                                .productData
                                                                .salePrice
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Text(
                                                      'Qunatity: ' +
                                                          _order[widget.index]
                                                              .pacakgeDetails[
                                                                  index]
                                                              .quantity,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Text('',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              SizedBox(
                                height: 30,
                              ),
                            ]))
                  ],
                ),
              ));
  }
}
