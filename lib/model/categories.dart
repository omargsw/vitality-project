import 'dart:convert';

List<GetCaregories> getCaregoriesFromJson(String str) =>
    List<GetCaregories>.from(
        json.decode(str).map((x) => GetCaregories.fromJson(x)));

String getCaregoriesToJson(List<GetCaregories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCaregories {
  GetCaregories({
    required this.id,
    required this.name,
    required this.image,
  });

  final int id;
  final String name;
  final String image;

  factory GetCaregories.fromJson(Map<String, dynamic> json) => GetCaregories(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
