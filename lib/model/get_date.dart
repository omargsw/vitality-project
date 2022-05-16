import 'dart:convert';

List<GetDate> getDateFromJson(String str) =>
    List<GetDate>.from(json.decode(str).map((x) => GetDate.fromJson(x)));

String getDateToJson(List<GetDate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDate {
  GetDate({
    required this.id,
    required this.centerId,
    required this.dateTime,
  });

  final int id;
  final int centerId;
  final String dateTime;

  factory GetDate.fromJson(Map<String, dynamic> json) => GetDate(
        id: json["id"],
        centerId: json["center_id"],
        dateTime: json["date_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "center_id": centerId,
        "date_time": dateTime,
      };
}
