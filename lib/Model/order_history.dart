class OrderHistory {
  int id;
  String userId;
  String totalPrice;
  String orderDate;
  String paymentType;
  String status;
  String createdAt;
  String updatedAt;
  List<PacakgeDetails> pacakgeDetails;

  OrderHistory(
      {this.id,
      this.userId,
      this.totalPrice,
      this.orderDate,
      this.paymentType,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.pacakgeDetails});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    totalPrice = json['total_price'];
    orderDate = json['order_date'];
    paymentType = json['payment_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['pacakge_details'] != null) {
      pacakgeDetails = <PacakgeDetails>[];
      json['pacakge_details'].forEach((v) {
        pacakgeDetails.add(new PacakgeDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['total_price'] = this.totalPrice;
    data['order_date'] = this.orderDate;
    data['payment_type'] = this.paymentType;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pacakgeDetails != null) {
      data['pacakge_details'] =
          this.pacakgeDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PacakgeDetails {
  int id;
  String orderId;
  String productId;
  String quantity;
  String price;
  String createdAt;
  String updatedAt;
  ProductData productData;

  PacakgeDetails(
      {this.id,
      this.orderId,
      this.productId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.productData});

  PacakgeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productData = json['product_data'] != null
        ? new ProductData.fromJson(json['product_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productData != null) {
      data['product_data'] = this.productData.toJson();
    }
    return data;
  }
}

class ProductData {
  int id;
  String slug;
  String nameAr;
  String nameEn;
  String descAr;
  String descEn;
  var image;
  String sku;
  String isForOnlyQuwait;
  String costPrice;
  String regularPrice;
  String salePrice;
  String discount;
  String stock;
  var categoryId;
  var subCategoryId;
  String views;
  String isRecommended;
  String isActive;
  String inStock;
  String weight;
  String percentAddedTax;
  String percentAddedTaxStatus;
  String deletedAt;
  String createdAt;
  String updatedAt;
  String tempIsActive;
  String helperCat;
  String helperImage;
  String helperCatSync;
  String helperImageSync;

  ProductData(
      {this.id,
      this.slug,
      this.nameAr,
      this.nameEn,
      this.descAr,
      this.descEn,
      this.image,
      this.sku,
      this.isForOnlyQuwait,
      this.costPrice,
      this.regularPrice,
      this.salePrice,
      this.discount,
      this.stock,
      this.categoryId,
      this.subCategoryId,
      this.views,
      this.isRecommended,
      this.isActive,
      this.inStock,
      this.weight,
      this.percentAddedTax,
      this.percentAddedTaxStatus,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.tempIsActive,
      this.helperCat,
      this.helperImage,
      this.helperCatSync,
      this.helperImageSync});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descAr = json['desc_ar'];
    descEn = json['desc_en'];
    image = json['image'];
    sku = json['sku'];
    isForOnlyQuwait = json['isForOnlyQuwait'];
    costPrice = json['cost_price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    stock = json['stock'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    views = json['views'];
    isRecommended = json['is_recommended'];
    isActive = json['is_active'];
    inStock = json['in_stock'];
    weight = json['weight'];
    percentAddedTax = json['percent_added_tax'];
    percentAddedTaxStatus = json['percent_added_tax_status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tempIsActive = json['temp_is_active'];
    helperCat = json['helper_cat'];
    helperImage = json['helper_image'];
    helperCatSync = json['helper_cat_sync'];
    helperImageSync = json['helper_image_sync'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['desc_ar'] = this.descAr;
    data['desc_en'] = this.descEn;
    data['image'] = this.image;
    data['sku'] = this.sku;
    data['isForOnlyQuwait'] = this.isForOnlyQuwait;
    data['cost_price'] = this.costPrice;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['discount'] = this.discount;
    data['stock'] = this.stock;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['views'] = this.views;
    data['is_recommended'] = this.isRecommended;
    data['is_active'] = this.isActive;
    data['in_stock'] = this.inStock;
    data['weight'] = this.weight;
    data['percent_added_tax'] = this.percentAddedTax;
    data['percent_added_tax_status'] = this.percentAddedTaxStatus;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['temp_is_active'] = this.tempIsActive;
    data['helper_cat'] = this.helperCat;
    data['helper_image'] = this.helperImage;
    data['helper_cat_sync'] = this.helperCatSync;
    data['helper_image_sync'] = this.helperImageSync;
    return data;
  }
}
