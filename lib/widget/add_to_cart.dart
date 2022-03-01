import 'package:e_com/generated/l10n.dart';
import 'package:e_com/newmodels/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_com/core/store.dart';
import 'package:e_com/Model/product_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:e_com/Pages/cart_page.dart';
import 'package:e_com/Model/cart_model.dart';

class AddToCart extends StatelessWidget {
  final Products catalog;
  AddToCart({
    Key key,
    @required this.catalog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.listen(context, to: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    bool isInCart = _cart.items.contains(catalog) ?? false;

    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
      //  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          if (!isInCart) {
            AddMutation(catalog);
          }
        },
        child: Container(
            alignment: Alignment.center,
            height: 28,
            width: 28,
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(width: 2, color: Colors.red.shade500)),
            child: isInCart
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 20,
                          )
                        ]),
                  )
                : Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  )
            // Text(
            //     S.of(context).Addtocart,
            //     style: TextStyle(
            //       color: Colors.blueGrey.shade500,
            //     ),
            //   ),
            ),
      ),
    );
  }
}
