class Supplier {
  int id;
  String supplierName;
  String name;
  String lastName;
  String email;
  String? address;
  int? ruc;
  String? category;
  String? description;
  int? phone;
  String password;
  String? image;
  int likes;

  Supplier({
    required this.id,
    required this.supplierName,
    required this.name,
    required this.lastName,
    required this.email,
    required this.address,
    required this.ruc,
    required this.category,
    required this.description,
    required this.phone,
    required this.password,
    required this.image,
    required this.likes,
  });

  static Supplier objJson(Map<String, dynamic> json) {
    return Supplier(
      id: json["id"] as int,
      supplierName: json["supplierName"] as String,
      name: json["name"] as String,
      lastName: json["lastName"] as String,
      email: json["email"] as String,
      address: json["address"] as String? ?? 'N/A',
      ruc: json["ruc"] as int? ?? 1,
      category: json["category"] as String? ?? 'N/A',
      description: json["description"] as String? ?? 'N/A',
      phone: json["phone"] as int? ?? 1,
      password: json["password"] as String,
      image: json["image"] as String? ?? 'N/A',
      likes: json["likes"] as int,
    );
  }
  //to json methode
  Map<String,dynamic> toJson(){
    return{
      "id":id,
      "supplierName": supplierName,
      "name": name,
      "lastName": lastName,
      "email": email,
      "address": address,
      "ruc": ruc,
      "category": category,
      "description": description,
      "phone": phone,
      "password": password,
      "image": image,
      "likes": likes,
    };
  }

}
