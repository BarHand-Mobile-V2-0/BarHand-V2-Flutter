import 'package:ur_provider/features/providers/domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    image: json["image"],
    price: json["price"],
    description: json["description"],
    numberOfSales: json["numberOfSales"],
    available: json["available"],
    supplierId: json["supplierId"],
    rating: json["rating"],

  );
}
