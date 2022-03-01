import 'package:e_com/Model/cart_model.dart';
import 'package:e_com/Pages/Homepage.dart';
import 'package:e_com/Pages/checkingforget.dart';
import 'package:e_com/Pages/splash_page.dart';
import 'package:e_com/core/store.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:e_com/widget/color.dart';
import 'package:flutter/material.dart';

import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFAPILanguage.dart';
import 'package:myfatoorah_flutter/utils/MFNotificationOption.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:velocity_x/velocity_x.dart';

class OrderDetail12 extends StatefulWidget {
  final String location;
  final double price;
  //final double pricefromcart;
  final List<int> idzz;
  final List<int> itemquantity;
  final List<double> itemprice;
  const OrderDetail12(
      {this.location,
      this.price,
      // this.pricefromcart,
      this.itemprice,
      this.itemquantity,
      this.idzz,
      Key key})
      : super(key: key);

  @override
  _OrderDetail12State createState() => _OrderDetail12State();
}

class _OrderDetail12State extends State<OrderDetail12> {
  String name;
  String address;
  String city;
  String phoneno;
  //String email;
  String note;
  String country;
  String type;
  String invoiurl;
  int _groupValue = null;
  String invoiceId;
  static const _con = '';
  String invoiceUrl;
  String id;
  final CartModel _cart = (VxState.store as MyStore).cart;
  var date = DateTime.now();
  getid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    setState(() {});
  }

  var transactiondate;
  var paymentgateway;
  var reference;
  var trackid;
  var transactionid;
  var paymentid;
  var authorizationid;
  var transactionstatus;
  var transactionvalue;
  var customerservicecharge;
  var duevalue;
  var paidcurrency;
  var currency;
  var error;
  var cardnumber;
  var paidcurrencyvalue;
  var ipaddress;
  var countryoftransaction;
  bool isloading = false;

  var email = "tony@starkindustries.com";
  bool isvalidemail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  _launchurl() async {
    if (await canLaunch(invoiurl)) {
      await launch(invoiurl);
      await Future.delayed(Duration(seconds: 3));
      _showdonepopup(context);
    } else {
      throw 'Could not launch $invoiurl';
    }
  }

  String orderid;
  Future sendallordereddata() async {
    var APIURL = 'http://sinbadapp.theazsoft.com/public/api/storeorder';
    Map mapData = {
      'product_id': widget.idzz.toString(),
      'quantity': widget.itemquantity.toString(),
      'user_id': id,
      'date': date.toString(),
      'total_price': widget.price.toString(),
      'price': widget.itemprice.toString(),
      'payment_type': _groupValue == 0 ? 'KNET' : 'COD',
    };

    http.Response response = await http.post(Uri.parse(APIURL), body: mapData);

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (jsonData['Message'].toString() == 'Order saved successfully') {
      orderid = jsonData['OrderId'].toString();
      sendBillingDetails();
      if (_groupValue == 0) {
        sendtransectiondetail();
        sendtransectiondetail2();
      }
      _cart.items.remove(widget.idzz);

      // for (int i = 0; i < _cart.items.length; i++) {
      //   RemoveMutation(_cart.items[i]);
      // }

      Toast.show('Order submitted successfully', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    } else {
      Toast.show('server error', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    }
  }

  Future sendBillingDetails() async {
    var APIUrl = 'http://sinbadapp.theazsoft.com/public/api/shippingdetails';
    Map mapData = {
      "name": name.toString(),
      "address": address.toString(),
      "country": country.toString(),
      "city": city.toString(),
      "phone": phoneno.toString(),
      "email": email.toString(),
      'note': note.toString(),
      'order_id': orderid.toString(),
      'type': _groupValue == 0 ? 'KNET' : 'COD'
    };
    http.Response response = await http.post(Uri.parse(APIUrl), body: mapData);
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (jsonData['Message'].toString() == 'Saved successfully.') {
      Toast.show('Order submitted successfully', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    } else {
      Toast.show('server error', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    }
  }

  Future sendtransectiondetail() async {
    setState(() {
      isloading = true;
    });
    var APIUrl =
        'http://sinbadapp.theazsoft.com/public/api/storeTransactionDetails';
    Map mapData = {
      'OrderId': orderid.toString(),
      'UserId': id,
      "InvoiceId": invoiceId != null ? invoiceId : 'null',
      "InvoiceStatus": invoicestatus != null ? invoicestatus : 'null',
      "InvoiceReference": invoicereference != null ? invoicereference : 'null',
      "CustomerReference":
          customerreference != null ? customerreference : 'null',
      "CreatedDate": createddate.toString(),
      "ExpiryDate": expirydate.toString(),
      'InvoiceValue':
          invoicevalue.toString() != null ? invoicevalue.toString() : 'null',
      'Comments': comments != null ? comments : 'null',
      'CustomerName': customername != null ? customername : 'null',
      'CustomerMobile': customermobile != null ? customermobile : 'null',
      'CustomerEmail': customeremail != null ? customeremail : 'null',
      'UserDefinedField': userdefinedfield != null ? userdefinedfield : 'null',
      'InvoiceDisplayValue': invoicedisplayvlaue.toString() != null
          ? invoicedisplayvlaue.toString()
          : 'display error',
    };
    final response = await http.post(
        Uri.parse(
            'http://sinbadapp.theazsoft.com/public/api/storeTransactionDetails'),
        body: mapData);
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (jsonData['Message'].toString() == 'Transaction history saved') {
      Toast.show('Order submitted successfully', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    } else {
      Toast.show('server error', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    }
    setState(() {
      isloading = false;
    });
  }

  Future sendtransectiondetail2() async {
    setState(() {
      isloading = false;
    });
    var APIUrl =
        'http://sinbadapp.theazsoft.com/public/api/storeTransactiondet';
    Map mapData = {
      "TransactionDate": transactiondate != null ? transactiondate : 'null',
      "PaymentGateway": paymentgateway != null ? paymentgateway : 'null',
      "ReferenceId": reference != null ? reference : 'null',
      "TrackId": trackid != null ? trackid : 'null',
      "TransactionId": transactionid != null ? transactionid : 'null',
      "PaymentId": paymentid != null ? paymentid : 'null',
      'AuthorizationId': authorizationid != null ? authorizationid : 'null',
      'TransactionStatus':
          transactionstatus != null ? transactionstatus : 'null',
      'TransationValue': transactionvalue != null ? transactionvalue : 'null',
      'CustomerServiceCharge':
          customerservicecharge != null ? customerservicecharge : 'null',
      'DueValue': duevalue != null ? duevalue : 'null',
      'PaidCurrency': paidcurrency != null ? paidcurrency : 'null',
      'PaidCurrencyValue':
          paidcurrencyvalue != null ? paidcurrencyvalue : 'null',
      'Currency': currency != null ? currency : 'null',
      'Error': error != null ? error : 'null',
      'CardNumber': cardnumber != null ? cardnumber : 'null',
      'IpAddress': ipaddress != null ? ipaddress : 'null',
      'Country': countryoftransaction != null ? countryoftransaction : 'null',
      'UserId': id,
    };
    http.Response response = await http.post(Uri.parse(APIUrl), body: mapData);
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (jsonData['Message'].toString() == 'Transaction detail saved') {
      Toast.show('Order submitted successfully', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    } else {
      Toast.show('server error', context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Carousel_Page()));
    }
  }

  var invoiceid;
  var invoicestatus;
  var invoicereference;
  var customerreference;
  var createddate;
  var expirydate;
  var invoicevalue;
  var comments;
  var customername;
  var customermobile;
  var customeremail;
  var userdefinedfield;
  var invoicedisplayvlaue;

  String _response = '';
  String _loading = "Loading...";
  final String mAPIKey =
      "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

  @override
  void initState() {
    super.initState();
    getid();

    MFSDK.init(MFBaseURL.TEST, mAPIKey);

    MFSDK.setUpAppBar(
        title: "MyFatoorah Payment",
        titleColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        isShowAppBar: true);

    MFSDK.setUpAppBar(isShowAppBar: false);
    setState(() {});
  }

  void sendPayment() {
    var request = MFSendPaymentRequest(
        invoiceValue: widget.price,
        customerName: name.toString(),
        customerEmail: email.toString(),
        customerMobile: phoneno.toString(),
        callBackUrl: 'http://myreturnapp.com',
        notificationOption: MFNotificationOption.LINK);

    MFSDK.sendPayment(
        this.context,
        MFAPILanguage.EN,
        request,
        (MFResult<MFSendPaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    _response = result.response.toJson().toString();
                    invoiceId =
                        result.response.toJson()['InvoiceId'].toString();
                    invoiceUrl =
                        result.response.toJson()['InvoiceURL'].toString();
                  }),
                  invoiurl = result.response.toJson()['InvoiceURL'].toString(),
                  _launchurl(),
                }
              else
                {
                  setState(() {
                    _response = result.error.message;
                  })
                }
            });

    setState(() {
      _response = _loading;
      // }
    });
  }

  void getPaymentStatus() {
    var request = MFPaymentStatusRequest(invoiceId: invoiceId);

    MFSDK.getPaymentStatus(
        MFAPILanguage.EN,
        request,
        (MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  invoiceid = result.response.toJson()['InvoiceId'],
                  invoicestatus = result.response.toJson()['InvoiceStatus'],
                  invoicereference =
                      result.response.toJson()['InvoiceReference'],
                  customerreference =
                      result.response.toJson()['CustomerReference'],
                  createddate = result.response.toJson()['CreatedDate'],
                  expirydate = result.response.toJson()['ExpiryDate'],
                  invoicevalue = result.response.toJson()['InvoiceValue'],
                  comments = result.response.toJson()['Comments'],
                  customername = result.response.toJson()['CustomerName'],
                  customermobile = result.response.toJson()['CustomerMobile'],
                  customeremail = result.response.toJson()['CustomerEmail'],
                  userdefinedfield =
                      result.response.toJson()['UserDefinedField'],
                  invoicedisplayvlaue =
                      result.response.toJson()['InvoiceDisplayValue'],
                  transactiondate = result.response
                      .toJson()['InvoiceTransactions'][0]['TransactionDate'],
                  paymentgateway = result.response
                      .toJson()['InvoiceTransactions'][0]['PaymentGateway'],
                  reference = result.response.toJson()['InvoiceTransactions'][0]
                      ['ReferenceId'],
                  trackid = result.response.toJson()['InvoiceTransactions'][0]
                      ['TrackId'],
                  transactionid = result.response
                      .toJson()['InvoiceTransactions'][0]['TransactionId'],
                  paymentid = result.response.toJson()['InvoiceTransactions'][0]
                      ['PaymentId'],
                  authorizationid = result.response
                      .toJson()['InvoiceTransactions'][0]['AuthorizationId'],
                  transactionstatus = result.response
                      .toJson()['InvoiceTransactions'][0]['TransactionStatus'],
                  transactionvalue = result.response
                      .toJson()['InvoiceTransactions'][0]['TransationValue'],
                  customerservicecharge =
                      result.response.toJson()['InvoiceTransactions'][0]
                          ['CustomerServiceCharge'],
                  duevalue = result.response.toJson()['InvoiceTransactions'][0]
                      ['DueValue'],
                  paidcurrency = result.response.toJson()['InvoiceTransactions']
                      [0]['PaidCurrency'],
                  currency = result.response.toJson()['InvoiceTransactions'][0]
                      ['Currency'],
                  error = result.response.toJson()['InvoiceTransactions'][0]
                      ['Error'],
                  cardnumber = result.response.toJson()['InvoiceTransactions']
                      [0]['CardNumber'],
                  paidcurrencyvalue = result.response
                      .toJson()['InvoiceTransactions'][0]['PaidCurrencyValue'],
                  ipaddress = result.response.toJson()['InvoiceTransactions'][0]
                      ['IpAddress'],
                  countryoftransaction = result.response
                      .toJson()['InvoiceTransactions'][0]['Country'],
                  _response = result.response.toJson().toString().toString(),
                  // sendtransectiondetail(),
                  // sendtransectiondetail2(),
                  sendallordereddata(),
                  //sendBillingDetails(),
                }
              else
                {
                  setState(() {
                    _response = result.error.message;
                  }),
                  Navigator.of(context, rootNavigator: true),
                  Toast.show(S.of(context).Paymentcannotcomplete, context,
                      gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG),
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).BillingDetails),
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey[600])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.04),
                            child: Image(
                                image: AssetImage('assets/sinbadlogo.jpg')),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Center(
                            child: Text(
                          S.of(context).Enteryourdetails,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).Name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.grey[600])),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Icon(Icons.person)),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: TextField(
                                    onChanged: (value) {
                                      name = value;
                                    },
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                        hintText: S.of(context).EnterName,
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).EnterAddress,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.grey[600])),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Icon(Icons.home)),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: TextField(
                                    onChanged: (value) {
                                      address = value;
                                    },
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                        hintText: S.of(context).EnterAddress,
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).Country,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.grey[600])),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Icon(Icons.flag)),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: TextField(
                                    onChanged: (value) {
                                      country = value;
                                    },
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: S.of(context).Country),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).EnterCity,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.grey[600])),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Icon(Icons.location_city)),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: TextField(
                                    onChanged: (value) {
                                      city = value;
                                    },
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: S.of(context).EnterCity),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).Phone,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.grey[600])),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Icon(Icons.wifi_calling)),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: TextField(
                                    onChanged: (value) {
                                      phoneno = value;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: S.of(context).Phone),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).EmailAddress,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.grey[600])),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Icon(Icons.email)),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: TextFormField(
                                    autovalidate: true,
                                    validator: (value) => isvalidemail()
                                        ? null
                                        : 'Enter valid email',
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: S.of(context).EMailAddress),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).NoteOptional,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 120,
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: Colors.grey[600])),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Icon(Icons.note_add)),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: TextField(
                                    onChanged: (value) {
                                      note = value;
                                    },
                                    maxLines: 5,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: S.of(context).NoteOptional),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Center(
                            child: ElevatedButton(
                          onPressed: () {
                            if (name == null) {
                              Toast.show(S.of(context).nameerror1, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (name.toString().length < 3) {
                              Toast.show(S.of(context).nameerror2, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (address == null) {
                              Toast.show(S.of(context).addresserror1, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (address.toString().length < 5) {
                              Toast.show(S.of(context).addresserror2, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (country == null) {
                              Toast.show(S.of(context).countryerror1, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (country.toString().length < 3) {
                              Toast.show(S.of(context).countryerror2, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (city == null) {
                              Toast.show(S.of(context).cityerror1, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (city.toString().length < 3) {
                              Toast.show(S.of(context).cityerror2, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (phoneno == null) {
                              Toast.show(S.of(context).phoneerror1, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (phoneno.toString().length < 11) {
                              Toast.show(S.of(context).phoneerror2, context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else if (phoneno.toString().length > 11) {
                              Toast.show(S.of(context).phoneerror2, context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else if (email == null) {
                              Toast.show(S.of(context).emailerror1, context,
                                  gravity: Toast.BOTTOM,
                                  duration: Toast.LENGTH_LONG);
                            } else if (email.toString().length < 5) {
                              Toast.show(S.of(context).emailerror2, context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else {
                              _showpayment(context);
                            }

                            setState(() {});
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  context.theme.buttonColor)),
                          child:
                              S.of(context).ConfirmDetails.text.xl.white.make(),
                        ).w64(context)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                ])),
    );
  }

  _showdonepopup(BuildContext context) {
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
                      Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: MediaQuery.of(context).size.height * 0.16,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 16,
                                      left: 10,
                                    ),
                                    child: Icon(
                                      Icons.payments_sharp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8, top: 16),
                                    child: Text(
                                      'My Fatoorah Payment',
                                      //'Payment Method',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  getPaymentStatus();
                                },
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  child: Container(
                                      alignment: Alignment.center,
                                      // margin:
                                      //  EdgeInsets.only(top: 20, left: 10, right: 10),
                                      child: Text(
                                        'Done',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ),
                              ),
                            ],
                          ))
                    ])),
          );
        });
  }

  _showpayment(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 240,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 10),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.payments_sharp,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  S.of(context).PaymentMethod,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              _myRadioButton(
                                // title: 'this',
                                title: S.of(context).KNET,
                                value: 0,
                                onChanged: (newValue) {
                                  setState(() => _groupValue = newValue);

                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                  _showpayment(context);
                                },
                              ),
                              _myRadioButton(
                                title: S.of(context).CashOnDelivery,
                                value: 1,
                                onChanged: (newValue) {
                                  setState(() => _groupValue = newValue);

                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                  _showpayment(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        Divider(
                            //color: Colors.black,
                            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _groupValue == 0
                                    // ignore: unnecessary_statements
                                    ? {
                                        await Future.delayed(
                                            Duration(seconds: 1)),
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog'),
                                        sendPayment(),
                                      }
                                    // ignore: unnecessary_statements
                                    : {
                                        //sendBillingDetails(),
                                        sendallordereddata(),
                                      };
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 16, right: 40, left: 40),
                                child: Text(
                                  S.of(context).Submit,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 16, right: 40, left: 40),
                                child: Text(
                                  S.of(context).Cancel,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(
        title,
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}
