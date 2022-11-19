class Account {
  int id;
  String firstName;
  String lastName;
  String email;
  String password;

  Account(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.id});

  Map<String, dynamic> tojson() {
    return {
      AcountFields.email: email,
      AcountFields.firstName: firstName,
      AcountFields.lastName: lastName,
      AcountFields.password: password
    };
  }

  Account copy(
      {int? id,
      String? firstName,
      String? lastName,
      String? email,
      String? password}) {
    return Account(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password);
  }
}

class AcountFields {
  static const String id = "id";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String email = "email";
  static const String password = "password";
}
