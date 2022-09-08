import 'dart:developer';

class ReservationTemplate {
  String? reservationId;
  late String customerId;
  late String customerFullName;
  String? customerImageUrl;
  late int guest;
  late String tableId;
  late DateTime reservedDate;
  int? reservationStatus;

  ReservationTemplate({
    this.reservationId,
    required this.customerId,
    required this.tableId,
    required this.customerFullName,
    required this.customerImageUrl,
    required this.guest,
    required this.reservedDate,
    this.reservationStatus,
  });

  ReservationTemplate.fromMap(Map<String, dynamic> map) {
    reservationId = map['id'];
    customerId = map['customer_id'];
    tableId = map['table_id'];
    customerFullName = map['fullName'];
    customerImageUrl = map['imageUrl'];

    guest = int.parse(map['guest']);
    reservedDate = DateTime.parse(map['reservedDate']);
    reservationStatus = int.parse(map['reservationStatus'] ?? '0');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': reservationId,
      'customerId': customerId,
      'tableId': tableId,
      'fullName': customerFullName,
      'imageUrl': customerImageUrl,
      "guest": guest,
      'reservedDate': reservedDate,
      'reservationStatus': reservationStatus ?? 0
    };
  }
}
