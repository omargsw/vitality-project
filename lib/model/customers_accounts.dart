import 'dart:convert';

List<GetCusromerAccounts> getCusromerAccountsFromJson(String str) =>
    List<GetCusromerAccounts>.from(
        json.decode(str).map((x) => GetCusromerAccounts.fromJson(x)));

String getCusromerAccountsToJson(List<GetCusromerAccounts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCusromerAccounts {
  GetCusromerAccounts({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.image,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String image;

  factory GetCusromerAccounts.fromJson(Map<String, dynamic> json) =>
      GetCusromerAccounts(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "image": image,
      };
}
