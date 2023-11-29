class Category {
  String? title;
  String? image;
  Category({
    required this.title,
    required this.image,
  });
}

List<Category> categories = [
  Category(title: "GROCERY", image: "assets/ecom_images/grocery.png"),
  Category(title: "ELECTRONICS", image: "assets/ecom_images/electronics.png"),
  Category(title: "COSMETICS", image: "assets/ecom_images/cosmatics.png"),
  Category(title: "PHARMACY", image: "assets/ecom_images/pharmacy.png"),
  Category(title: "GARMENT", image: "assets/ecom_images/garments.png"),
];
