import 'dart:convert';
import 'package:e_com/Model/order_history.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import 'order_detail_screen.dart';

class OrderHistory1 extends StatefulWidget {
  const OrderHistory1({Key key}) : super(key: key);

  @override
  _OrderHistory1State createState() => _OrderHistory1State();
}

class _OrderHistory1State extends State<OrderHistory1> {
  String id;
  bool status = true;
  bool isloading = true;
  List<OrderHistory> _order = new List();
  changeDate(var date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  getid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    GetAllOrders();
  }

  Future GetAllOrders() async {
    print(id);
    http.Response response = await http.get(Uri.parse(
        "http://sinbadapp.theazsoft.com/public/api/orderhistory/" + id));
    print(response.body.toString());
    Map<String, dynamic> data = jsonDecode(response.body);
    if (data["Message"] == "Orders found Successfully") {
      for (int i = 0; i < data["OrderHistory"].length; i++) {
        Map obj = data["OrderHistory"][i];
        OrderHistory pos = new OrderHistory();
        pos = OrderHistory.fromJson(obj);
        _order.add(pos);
      }
      setState(() {
        status = false;
        isloading = false;
      });
    } else if (data["Message"] == "No orders found") {
      setState(() {
        isloading = false;
        status = true;
      });
    } else {
      setState(() {
        isloading = false;
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
                    isloading
                        ? Expanded(
                            child: Center(child: CircularProgressIndicator()))
                        : status
                            ? Expanded(
                                flex: 1,
                                child: Center(
                                  child: Container(
                                    child: Text(
                                      S.of(context).Noordersfound,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: context.theme.canvasColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.grey[600])),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                margin:
                                                    EdgeInsets.only(top: 30),
                                                child: Image(
                                                    image: AssetImage(
                                                        'assets/sinbad.png')),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Center(
                                              child: Container(
                                                child: Text(
                                                  S.of(context).Yourorders,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: _order.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OrderDetailScreen(
                                                                            index:
                                                                                index,
                                                                          )));
                                                        },
                                                        child: Container(
                                                          height: 120,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: context
                                                                      .theme
                                                                      .cardColor),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            10),
                                                                    child: Text(
                                                                      S.of(context).OrderId +
                                                                          ' ' +
                                                                          _order[index]
                                                                              .id
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            10),
                                                                    child: Text(
                                                                        'KWD ' +
                                                                            _order[index]
                                                                                .totalPrice
                                                                                .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
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
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            10),
                                                                    child: Text(
                                                                      S.of(context).Products +
                                                                          ' ' +
                                                                          _order[index]
                                                                              .pacakgeDetails
                                                                              .length
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            10),
                                                                    child: Text(
                                                                        changeDate(DateTime.parse(_order[index].orderDate))
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   height: 30,
                                                      // ),
                                                    ],
                                                  );
                                                })
                                          ]))
                                ],
                              ),
                  ],
                ),
              ));
  }
}
