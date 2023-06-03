import 'package:ur_provider/features/providers/domain/domain.dart';

class SupplierMapper {
  static jsonToEntity(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        supplierName: json["supplierName"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        address: json["address"],
        ruc: json["ruc"],
        category: json["category"],
        description: json["description"],
        phone: json["phone"],
        password: json["password"],
        image: json["image"],
        likes: json["likes"],
      );
}
