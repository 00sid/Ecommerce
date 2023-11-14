import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String category;
  String id;
  String productName;
  String detail;
  int price;
  int discountPrice;
  String serialCode;
  List<dynamic> imageUrls;
  bool isOnSale;
  bool isPopular;
  bool isFavourite;

  Product({
    required this.category,
    required this.id,
    required this.productName,
    required this.detail,
    required this.price,
    required this.discountPrice,
    required this.serialCode,
    required this.imageUrls,
    required this.isOnSale,
    required this.isPopular,
    required this.isFavourite,
  });
  static Product? fromJson(DocumentSnapshot<Map<String, dynamic>> snap) {
    var json = snap.data();
    if (json == null) {
      return null;
    }
    return Product(
      category: json['category'],
      id: json['id'],
      productName: json['productName'],
      detail: json['detail'],
      price: int.parse(json['price']),
      discountPrice: int.parse(json['discountPrice']),
      serialCode: json['serialCode'],
      imageUrls: List<String>.from(json['imageUrls']),
      isOnSale: json['isOnSale'],
      isPopular: json['isPopular'],
      isFavourite: json['isFavourite'],
    );
  }

  static Future<void> addProducts(Product product) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "category": product.category,
      "productName": product.productName,
      "id": product.id,
      "detail": product.detail,
      "price": product.price.toString(),
      "discountPrice": product.discountPrice.toString(),
      "serialCode": product.serialCode,
      "imageUrls": product.imageUrls,
      "isOnSale": product.isOnSale,
      "isPopular": product.isPopular,
      "isFavourite": product.isFavourite,
    };
    await db.doc(product.id).set(data);
  }

  Future<void> updateProducts(Product updateProduct, String uid) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "category": updateProduct.category,
      "productName": updateProduct.productName,
      "id": updateProduct.id,
      "detail": updateProduct.detail,
      "price": updateProduct.price.toString(),
      "discountPrice": updateProduct.discountPrice.toString(),
      "serialCode": updateProduct.serialCode,
      "imageUrls": updateProduct.imageUrls,
      "isOnSale": updateProduct.isOnSale,
      "isPopular": updateProduct.isPopular,
      "isFavourite": updateProduct.isFavourite,
    };
    await db.doc(uid).update(data);
  }

  Future<void> deleteProduct(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    await db.doc(id).delete();
  }
}
