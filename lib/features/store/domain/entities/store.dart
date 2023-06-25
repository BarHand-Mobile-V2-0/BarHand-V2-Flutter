
import 'package:http/http.dart';

class store {
  int id;
  String name;
  String lastName;
  String storeName;
  String? address;
  int? phone;
  String email;
  String password;
  String? image;

  store({
    required this.id,
    required this.name,
    required this.lastName,
    required this.storeName,
    required this.address,
    required this.phone,
    required this.email,
    required this.password,
    required this.image,
  });

  static store objJson(Map<String, dynamic> json) {
    return store(
        id: json["id"] as int,
        name: json["name"] as String,
        lastName: json["lastName"] as String,
        storeName: json["storeName"] as String,
        address: json["address"] as String? ?? 'N/A',
        phone: json["phone"] as int? ?? 0,
        email: json["email"] as String,
        password: json["password"] as String,
        image: json["image"] as String? ?? 'N/A'
    );
  }
}
