import 'dart:convert';

List<GetFoodPlan> getFoodPlanFromJson(String str) => List<GetFoodPlan>.from(
    json.decode(str).map((x) => GetFoodPlan.fromJson(x)));

String getFoodPlanToJson(List<GetFoodPlan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFoodPlan {
  GetFoodPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.categoryId,
    required this.centersId,
    required this.rate,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String description;
  final String image;
  final int categoryId;
  final int centersId;
  final int rate;
  final DateTime createdAt;

  factory GetFoodPlan.fromJson(Map<String, dynamic> json) => GetFoodPlan(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        categoryId: json["category_id"],
        centersId: json["centers_id"],
        rate: json["rate"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "category_id": categoryId,
        "centers_id": centersId,
        "rate": rate,
        "created_at": createdAt.toIso8601String(),
      };
}
