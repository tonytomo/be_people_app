class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  /// User
  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.avatar});

  /// Convert User Obj from Json
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        email = json['email'],
        avatar = json['avatar'];

  /// Method to convert User obj to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'avatar': avatar,
    };
  }
}
