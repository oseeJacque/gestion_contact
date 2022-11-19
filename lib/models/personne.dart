class Personne {
  int id;
  String firstName;
  String lastName;
  String birthday;
  String adress;
  String mail;
  String gender;
  String quote;
  String imageUrl;
  String phone;

  Personne(
      {required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.birthday,
      required this.adress,
      required this.mail,
      required this.gender,
      required this.quote,
      required this.phone,
      this.id = 0});

  Map<String, dynamic> tojson(Personne data) {
    return {
      PersonneFields.birthday: data.birthday,
      PersonneFields.adress: data.adress,
      PersonneFields.firstName: data.firstName,
      PersonneFields.gender: data.gender,
      PersonneFields.imageUrl: data.imageUrl,
      PersonneFields.lastName: data.lastName,
      PersonneFields.mail: data.mail,
      PersonneFields.quote: data.quote,
      PersonneFields.phone: data.phone
    };
  }

  Personne copy({
    int? id,
    String? firstName,
    String? lastName,
    String? birthday,
    String? adress,
    String? mail,
    String? gender,
    String? quote,
    String? imageUrl,
    String? phone,
  }) {
    return Personne(
        phone: phone ?? this.phone,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        imageUrl: imageUrl ?? this.imageUrl,
        adress: adress ?? this.adress,
        mail: mail ?? this.mail,
        gender: gender ?? this.gender,
        quote: quote ?? this.quote,
        birthday: birthday ?? this.birthday);
  }

  static Personne toMap(Map<String, dynamic> data) {
    return Personne(
        phone: data[PersonneFields.phone],
        id: data[PersonneFields.id],
        firstName: data[PersonneFields.firstName],
        lastName: data[PersonneFields.lastName],
        imageUrl: data[PersonneFields.imageUrl],
        birthday: data[PersonneFields.birthday],
        adress: data[PersonneFields.adress],
        mail: data[PersonneFields.mail],
        gender: data[PersonneFields.gender],
        quote: data[PersonneFields.quote]);
  }

  static List<Personne> pers = [
    Personne(
        phone: "97028433",
        lastName: "SOKE",
        firstName: "Osée",
        gender: "Man",
        birthday: "200-12-04",
        adress: "Cotonou",
        mail: "oseesoke@gmail.com",
        imageUrl: "assets\\images\\images.jpg",
        quote: "Mon engagement determine ma réussite"),
    Personne(
        phone: "97028433",
        lastName: "SOKE",
        firstName: "Osée",
        gender: "Man",
        birthday: "200-12-04",
        adress: "Cotonou",
        mail: "oseesoke@gmail.com",
        imageUrl: "assets\\images\\images.jpg",
        quote: "Mon engagement determine ma réussite"),
    Personne(
        phone: "97028433",
        lastName: "SOKE",
        firstName: "Osée",
        gender: "Man",
        birthday: "200-12-04",
        adress: "Cotonou",
        mail: "oseesoke@gmail.com",
        imageUrl: "assets\\images\\images.jpg",
        quote: "Mon engagement determine ma réussite"),
    Personne(
        phone: "97028433",
        lastName: "SOKE",
        firstName: "Osée",
        gender: "Man",
        birthday: "200-12-04",
        adress: "Cotonou",
        mail: "oseesoke@gmail.com",
        imageUrl: "assets\\images\\images.jpg",
        quote: "Mon engagement determine ma réussite"),
    Personne(
        phone: "97028433",
        lastName: "SOKE",
        firstName: "Osée",
        gender: "Man",
        birthday: "200-12-04",
        adress: "Cotonou",
        mail: "oseesoke@gmail.com",
        imageUrl: "assets\\images\\images.jpg",
        quote: "Mon engagement determine ma réussite"),
    Personne(
        phone: "97028433",
        lastName: "SOKE",
        firstName: "Osée",
        gender: "Man",
        birthday: "200-12-04",
        adress: "Cotonou",
        mail: "oseesoke@gmail.com",
        imageUrl: "assets\\images\\images.jpg",
        quote: "Mon engagement determine ma réussite"),
    Personne(
        phone: "97028433",
        lastName: "SOKE",
        firstName: "Osée",
        gender: "Man",
        birthday: "200-12-04",
        adress: "Cotonou",
        mail: "oseesoke@gmail.com",
        imageUrl: "assets\\images\\images.jpg",
        quote: "Mon engagement determine ma réussite"),
  ];
}

class PersonneFields {
  static const String id = "id";
  static const String firstName = "firstName";
  static const String lastName = "lasetName";
  static const String birthday = "birthday";
  static const String adress = "adress";
  static const String mail = "mail";
  static const String gender = "gender";
  static const String quote = "quote";
  static const String imageUrl = "imageUrl";
  static const String phone = "Telephone";
}
