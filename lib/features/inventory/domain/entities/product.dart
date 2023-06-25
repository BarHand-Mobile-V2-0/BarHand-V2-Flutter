class Product {
  int id;
  String name;
  String category;
  String image;
  int price;
  String description;
  int numberOfSales;
  bool available;
  int supplierId;
  int rating;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.description,
    required this.numberOfSales,
    required this.available,
    required this.supplierId,
    required this.rating,
  });
  static Product objJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"] as int,
        name: json["name"] as String,
        category: json["category"] as String,
        image: json["image"] as String,
        price: json["price"] as int,
        description: json["description"] as String,
        numberOfSales: json["numberOfSales"] as int,
        available: json["available"] as bool,
        supplierId: json["supplierId"] as int,
        rating: json["rating"] as int
    );
  }
}