import 'package:e_com/Model/product_model.dart';
import 'package:e_com/newmodels/productmodel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:e_com/Model/cart_model.dart';

class MyStore extends VxStore {
  CatalogModel catalog;
  CartModel cart;
  List<Products> items;

  MyStore() {
    catalog = CatalogModel();
    cart = CartModel();
    cart.catalog = catalog;
  }
}
