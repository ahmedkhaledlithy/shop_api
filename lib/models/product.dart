
class Product {
  int? _id;
  String? _title;
  double? _price;
  String? _description;
  String? _category;
  String? _image;

  int? get id => _id;
  String? get title => _title;
  double? get price => _price;
  String? get description => _description;
  String? get category => _category;
  String? get image => _image;


  Product({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
  }) {
    _id = id;
    _title = title;
    _price = price;
    _description = description;
    _category = category;
    _image = image;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'] !=null ? json['price'] is double ? json['price'] : json['price'] is String ?
    double.parse(json['price']):json['price'].toDouble() : '';
    _description = json['description'];
    _category = json['category'];
    _image = json['image'];
  }

}
