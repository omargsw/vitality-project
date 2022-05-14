import 'dart:convert';

List<GetAdvertisment> getAdvertismentFromJson(String str) =>
    List<GetAdvertisment>.from(
        json.decode(str).map((x) => GetAdvertisment.fromJson(x)));

String getAdvertismentToJson(List<GetAdvertisment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAdvertisment {
  GetAdvertisment({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String description;
  final String image;
  final DateTime createdAt;

  factory GetAdvertisment.fromJson(Map<String, dynamic> json) =>
      GetAdvertisment(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "created_at": createdAt.toIso8601String(),
      };
}
