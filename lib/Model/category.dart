class Categoriesmodel {
  int categoryId;
  String name;
  String arName;
  String image;
  String status;
  String createdAt;
  String updatedAt;

  Categoriesmodel(
      {this.categoryId,
      this.name,
      this.arName,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  Categoriesmodel.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    name = json['name_en'];
    arName = json['name_ar'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.categoryId;
    data['name_en'] = this.name;
    data['name_ar'] = this.arName;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
