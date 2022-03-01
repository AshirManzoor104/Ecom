class Productsearch {
  String productId;
  String name;
  String arName;
  String description;
  String image;
  String price;
  String discountedPrice;
  String discount;
  String availableStock;
  String categoryId;
  String status;
  String createdAt;
  String updatedAt;

  Productsearch(
      {this.productId,
      this.name,
      this.arName,
      this.description,
      this.image,
      this.price,
      this.discountedPrice,
      this.discount,
      this.availableStock,
      this.categoryId,
      this.status,
      this.createdAt,
      this.updatedAt});

  Productsearch.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    arName = json['ar_name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
    discount = json['discount'];
    availableStock = json['available_stock'];
    categoryId = json['category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['ar_name'] = this.arName;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discounted_price'] = this.discountedPrice;
    data['discount'] = this.discount;
    data['available_stock'] = this.availableStock;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
