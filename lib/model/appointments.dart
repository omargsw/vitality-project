import 'dart:convert';

List<GetAppointments> getAppointmentsFromJson(String str) =>
    List<GetAppointments>.from(
        json.decode(str).map((x) => GetAppointments.fromJson(x)));

String getAppointmentsToJson(List<GetAppointments> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAppointments {
  GetAppointments({
    required this.id,
    required this.time,
    required this.status,
    required this.fees,
    required this.customerName,
    required this.customerPhone,
    required this.centerName,
    required this.centerPhone,
  });

  final int id;
  final String time;
  final String status;
  final double fees;
  final String customerName;
  final String customerPhone;
  final String centerName;
  final String centerPhone;

  factory GetAppointments.fromJson(Map<String, dynamic> json) =>
      GetAppointments(
        id: json["id"],
        time: json["time"],
        status: json["status"],
        fees: (json["fees"] == null) ? 0.0 : json["fees"].toDouble(),
        customerName: json["CustomerName"],
        customerPhone: json["CustomerPhone"],
        centerName: json["CenterName"],
        centerPhone: json["CenterPhone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "status": status,
        "fees": (fees == null) ? 0.0 : fees,
        "CustomerName": customerName,
        "CustomerPhone": customerPhone,
        "CenterName": centerName,
        "CenterPhone": centerPhone,
      };
}
