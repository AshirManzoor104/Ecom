import 'package:e_com/newmodels/productmodel.dart';
import 'package:e_com/widget/themes.dart';
import 'package:flutter/material.dart';
import 'package:e_com/Model/product_model.dart';
import 'package:e_com/widget/add_to_cart.dart';
import 'package:flutter_html/flutter_html.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:velocity_x/velocity_x.dart';
import 'package:e_com/generated/l10n.dart';

class HomeDetailPage extends StatefulWidget {
  final Products catalog;

  const HomeDetailPage({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  _HomeDetailPageState createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  List<Products> relatedProducts = [];
  relatedproducts() {
    relatedProducts = CatalogModel.items
        .where((element) =>
            element.categories[0].pivot.categoryId ==
                widget.catalog.categories[0].pivot.categoryId &&
            element.id != widget.catalog.id)
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    relatedproducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: S.of(context).English == "عربي"
              ? Text(
                  widget.catalog.nameEn != null
                      ? widget.catalog.nameEn
                      : 'name',
                  style: TextStyle(
                      fontSize: 16,
                      color: context.accentColor,
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  widget.catalog.nameAr != null
                      ? widget.catalog.nameAr
                      : 'name',
                  style: TextStyle(
                      fontSize: 16,
                      color: context.accentColor,
                      fontWeight: FontWeight.bold),
                ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: context.canvasColor,
        bottomNavigationBar: Container(
          color: context.cardColor,
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            buttonPadding: EdgeInsets.zero,
            children: [
              "\KWD${widget.catalog.salePrice}".text.bold.xl4.red800.make(),
              AddToCart(catalog: widget.catalog).wh(160, 50),
            ],
          ).p16(),
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: Key(widget.catalog.id.toString()),
                  child: Image.network(widget.catalog.images[0].url),
                ).h32(context),
                VxArc(
                  height: MediaQuery.of(context).size.height * 0.02,
                  arcType: VxArcType.CONVEY,
                  edge: VxEdge.TOP,
                  child: Container(
                    color: context.cardColor,
                    width: context.screenWidth,
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        children: [
                          S.of(context).English == "عربي"
                              ? Text(
                                  widget.catalog.nameEn != null
                                      ? widget.catalog.nameEn
                                      : 'name',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: context.accentColor,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  widget.catalog.nameAr != null
                                      ? widget.catalog.nameAr
                                      : 'name',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: context.accentColor,
                                      fontWeight: FontWeight.bold),
                                ),

                          // catalog.nameEn.text.xl2
                          //     .color(context.accentColor)
                          //     .bold
                          //     .make()
                          //     .px16()
                          // : .text.xl2
                          //     .color(context.accentColor)
                          //     .bold
                          //     .make()
                          //     .px16()
                          //     .toString(),
                          S.of(context).English == "عربي"
                              ? Container(
                                  //margin: EdgeInsets.only(left: 16, right: 16),
                                  child: Html(
                                    data:
                                        widget.catalog.descEn.toString() != null
                                            ? widget.catalog.descEn.toString()
                                            : 'description',
                                    defaultTextStyle: TextStyle(fontSize: 16),
                                  ),
                                )
                              : Container(
                                  // margin: EdgeInsets.only(left: 16, right: 16),
                                  child: Html(
                                    data:
                                        widget.catalog.descAr.toString() != null
                                            ? widget.catalog.descAr.toString()
                                            : 'description',
                                    defaultTextStyle: TextStyle(fontSize: 16),
                                  ),

                                  //  .text.xl
                                  //       .textStyle(context.captionStyle)
                                  //       .make()
                                  //       .px16()
                                  //       .toString(),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.height * 0.01,
                                  // )
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Related Products',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 0, right: 6),
                            height: MediaQuery.of(context).size.height * .28,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: relatedProducts.length,
                                itemBuilder: (context, index) {
                                  final catalog = relatedProducts[index];

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
                                      margin: EdgeInsets.only(right: 6),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.12,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.6,
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
                                                2.4,
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
                                                2.4,
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
                        ],
                      ).py32(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
