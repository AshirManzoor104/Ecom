// //import 'dart:convert';
// import 'dart:core';
// import 'dart:convert';

// import 'package:e_com/core/store.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CatalogModel {
//   static List<Products> items = [];

//   Products getById(int id) =>
//       items.firstWhere((element) => element.id == id, orElse: null);
//   // Get item by position
//   Products getByPosition(int pos) => items[pos];
// }

// class Products {
//   int id;
  
//   final String name;
//   final String arName;
//   final String description;
//   final String ardescription;
//   final String image;
//   num price;
//   num finalPrice;
//   int number;
//   final String discountedPrice;
//   final String discount;
//   final String availableStock;
//   final String categoryId;
//   final String status;
//   final String createdAt;
//   final String updatedAt;

//   Products(
//       {this.id,
//       this.number,
//       this.name,
//       this.arName,
//       this.description,
//       this.ardescription,
//       this.image,
//       this.price,
//       this.finalPrice,
//       this.discountedPrice,
//       this.discount,
//       this.availableStock,
//       this.categoryId,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   Products copyWith({
//     int id,
//     int number,
//     final String name,
//     final String arName,
//     final String description,
//     final String ardescription,
//     final String image,
//     final num price,
//     final num finalPrice,
//     final String discountedPrice,
//     final String discount,
//     final String availableStock,
//     final String categoryId,
//     final String status,
//     final String createdAt,
//     final String updatedAt,
//   }) {
//     return Products(
//         id: id ?? this.id,
//         number: number ?? this.number,
//         name: name ?? this.name,
//         arName: arName ?? this.arName,
//         description: description ?? this.description,
//         ardescription: ardescription ?? this.ardescription,
//         price: price ?? this.price,
//         finalPrice: finalPrice ?? this.finalPrice,
//         discountedPrice: discountedPrice ?? this.discountedPrice,
//         image: image ?? this.image,
//         discount: discount ?? this.discount,
//         availableStock: availableStock ?? this.availableStock,
//         categoryId: categoryId ?? this.categoryId,
//         status: status ?? this.status,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt);
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'number': number,
//       'name': name,
//       'arName': arName,
//       'description': description,
//       'ardescription': ardescription,
//       'price': price,
//       'finalPrice': finalPrice,
//       'discountedPrice': discountedPrice,
//       'discount': discount,
//       'availableStock': availableStock,
//       'categoryId': categoryId,
//       'status': status,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'image': image,
//     };
//   }

//   factory Products.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Products(
//         id: map['id'],
//         number: 1,
//         name: map['name_en'],
//         arName: map['name_ar'],
//         description: map['desc_en'],
//         ardescription: map['desc_ar'],
//         price: double.parse(map['sale_price']),
//         finalPrice: double.parse(map['sale_price']),
//         discountedPrice: null,
//         image: map['image'],
//         discount: map['discount'],
//         availableStock: map['stock'],
//         categoryId: map['category_id'],
//         status: map['status'],
//         createdAt: map['created_at'],
//         updatedAt: map['updated_at']);
//   }

//   String toJson() => json.encode(toMap());

//   factory Products.fromJson(String source) =>
//       Products.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Products(id: $id, number:$number, name: $name, arName:$arName, description: $description,ardescription: $ardescription, price: $price, finalPrice:$finalPrice, discountedPrice:$discountedPrice, image: $image, discount:$discount, categoryId:$categoryId, status:$status, createdAt:$createdAt, updatedAt:$updatedAt)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Products &&
//         other.id == id &&
//         other.number == number &&
//         other.name == name &&
//         other.arName == arName &&
//         other.description == description &&
//         other.ardescription == ardescription &&
//         other.price == price &&
//         other.finalPrice == finalPrice &&
//         other.discountedPrice == discountedPrice &&
//         other.discount == discount &&
//         other.image == image &&
//         other.categoryId == categoryId &&
//         other.status == status &&
//         other.createdAt == createdAt &&
//         other.updatedAt == updatedAt;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         number.hashCode ^
//         name.hashCode ^
//         arName.hashCode ^
//         description.hashCode ^
//         ardescription.hashCode ^
//         price.hashCode ^
//         finalPrice.hashCode ^
//         discountedPrice.hashCode ^
//         discount.hashCode ^
//         image.hashCode ^
//         categoryId.hashCode ^
//         status.hashCode ^
//         createdAt.hashCode ^
//         updatedAt.hashCode;
//   }
// }

// class SearchMutation extends VxMutation<MyStore> {
//   final String query;

//   SearchMutation(this.query);
//   @override
//   perform() {
//     if (query.length >= 1) {
//       store.items = CatalogModel.items
//           .where((element) => (element.name.toLowerCase()).contains(query))
//           .toList();
//     } else {
//       store.items = CatalogModel.items;
//     }
//   }
// }

// class CateoryMutation extends VxMutation<MyStore> {
//   final String id;
//   final String cat;

//   CateoryMutation(this.id, this.cat);

//   @override
//   perform() {
//     if (cat == 'yes') {
//       store.items = CatalogModel.items
//           .where((element) => element.categoryId == id.toString())
//           .toList();
//     } else {
//       store.items = CatalogModel.items;
//     }
//   }
// }
