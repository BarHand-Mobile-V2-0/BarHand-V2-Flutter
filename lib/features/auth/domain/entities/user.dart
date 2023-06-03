class User {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String role;
  final String token;

  User(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      required this.role,
      required this.token});

  bool get isAdmin {
    return role == 'admin';
  }
}
