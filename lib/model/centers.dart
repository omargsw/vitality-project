import 'dart:convert';

List<GetCenter> getCenterFromJson(String str) =>
    List<GetCenter>.from(json.decode(str).map((x) => GetCenter.fromJson(x)));

String getCenterToJson(List<GetCenter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCenter {
  GetCenter({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.image,
    required this.location,
    required this.streetName,
    required this.description,
    required this.rate,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String image;
  final String location;
  final String streetName;
  final String description;
  final int rate;

  factory GetCenter.fromJson(Map<String, dynamic> json) => GetCenter(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        image: json["image"],
        location: json["location"],
        streetName: json["street_name"],
        description: json["description"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "image": image,
        "location": location,
        "street_name": streetName,
        "description": description,
        "rate": rate,
      };
}
