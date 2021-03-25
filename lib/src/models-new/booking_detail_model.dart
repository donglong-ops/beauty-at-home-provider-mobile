import 'dart:convert';


class BookingDetailModel {
  // int serviceId;
  String serviceName;
  String servicePrice;
  String quantity;
  //FeedbackModel feedback;

  BookingDetailModel({
    this.serviceName,
    this.servicePrice,
    this.quantity,
   // this.feedback
  });
  Map<String, dynamic> toMap() {
    return {
      'serviceName': serviceName,
      'quantity': quantity,
      'servicePrice': servicePrice,
      //'feedBack': feedback.toMap(),
    };
  }

  factory BookingDetailModel.fromMap(Map<String, dynamic> map) {
    return BookingDetailModel(
      serviceName: map['serviceName'],
      servicePrice: map['servicePrice'].toString(),
      quantity: map['quantity'].toString(),
      //feedback: FeedbackModel.fromMap(map['feedBack']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingDetailModel.fromJson(String source) =>
      BookingDetailModel.fromMap(json.decode(source));
}