import 'package:e_com/core/store.dart';
import 'package:e_com/Model/product_model.dart';
import 'package:e_com/newmodels/productmodel.dart';
import 'package:velocity_x/velocity_x.dart';

String idddd;

class CartModel {
  CatalogModel _catalog;

  final List<int> _itemIds = [];
  final List<int> _itemnum = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  List<Products> get items =>
      _itemIds.map((id) => _catalog.getById(id)).toList();
  List<Products> get items1 =>
      _itemnum.map((number) => _catalog.getById(number)).toList();

  // Get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.finalPrice);
  List<int> get idzzzz => _itemIds;
  List<int> get number => _itemnum;
}

class AddMutation extends VxMutation<MyStore> {
  final Products item;

  AddMutation(this.item);
  @override
  perform() {
    store.cart._itemIds.add(item.id);
    idddd = store.cart._itemIds.toString();
  }
}

class UpdateMutation extends VxMutation<MyStore> {
  final Products item;
  UpdateMutation(this.item);
  @override
  perform() {
    store.cart._itemIds.toSet();
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Products item;

  RemoveMutation(this.item);
  @override
  perform() {
    store.cart._itemIds.remove(item.id);
  }
}
