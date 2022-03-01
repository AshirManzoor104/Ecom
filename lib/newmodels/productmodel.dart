import 'package:e_com/core/store.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogModel {
  static List<Products> items = [];

  Products getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);
  // Get item by position
  Products getByPosition(int pos) => items[pos];
}

class ProductsData {
  int currentPage;
  List<Products> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Links> links;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  ProductsData(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ProductsData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Products>[];
      json['data'].forEach((v) {
        data.add(new Products.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Products {
  int id;
  var nameAr;
  String nameEn;
  var descAr;
  num finalPrice;
  int number;
  String descEn;
  var image;
  String sku;
  String isForOnlyQuwait;
  String costPrice;
  var regularPrice;
  num salePrice;
  var discount;
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
  String createdAt;
  String updatedAt;
  String helperCat;
  String helperImage;
  String helperCatSync;
  String helperImageSync;
  List<Categories> categories;
  List<Images> images;

  Products(
      {this.id,
      this.number,
      this.finalPrice,
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
      this.createdAt,
      this.updatedAt,
      this.helperCat,
      this.helperImage,
      this.helperCatSync,
      this.helperImageSync,
      this.categories,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = 1;
    finalPrice = double.parse(json['sale_price']);
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descAr = json['desc_ar'];
    descEn = json['desc_en'];
    image = json['helper_image'];
    sku = json['sku'];
    isForOnlyQuwait = json['isForOnlyQuwait'];
    costPrice = json['cost_price'];
    regularPrice = json['regular_price'];
    salePrice = double.parse(json['sale_price']);
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    helperCat = json['helper_cat'];
    helperImage = json['helper_image'];
    helperCatSync = json['helper_cat_sync'];
    helperImageSync = json['helper_image_sync'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['helper_cat'] = this.helperCat;
    data['helper_image'] = this.helperImage;
    data['helper_cat_sync'] = this.helperCatSync;
    data['helper_image_sync'] = this.helperImageSync;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int id;
  String nameAr;
  String nameEn;
  String image;
  String sort;
  String status;
  String parentId;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Categories(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.image,
      this.sort,
      this.status,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    image = json['image'];
    sort = json['sort'];
    status = json['status'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['image'] = this.image;
    data['sort'] = this.sort;
    data['status'] = this.status;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  String productId;
  String categoryId;

  Pivot({this.productId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Images {
  String modelId;
  int id;
  String url;

  Images({this.modelId, this.id, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}

class Links {
  String url;
  String label;
  bool active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class SearchMutation extends VxMutation<MyStore> {
  final String query;

  SearchMutation(this.query);
  @override
  perform() {
    if (query.length >= 1) {
      store.items = CatalogModel.items
          .where((element) => (element.nameEn.toLowerCase()).contains(query))
          .toList();
    } else {
      store.items = CatalogModel.items;
    }
  }
}

class CateoryMutation extends VxMutation<MyStore> {
  final String id;
  final String cat;

  CateoryMutation(this.id, this.cat);

  @override
  perform() {
    if (cat == 'yes') {
      store.items = CatalogModel.items
          .where((element) =>
              element.categories[0].pivot.categoryId == id.toString())
          .toList();
    } else {
      store.items = CatalogModel.items;
    }
  }
}
