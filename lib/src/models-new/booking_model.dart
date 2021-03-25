import 'dart:convert';
import 'package:flutter_app/src/models-new/account_model2.dart';

import 'booking_detail_model.dart';

class BookingModel {
    String id;
    String status;
    AccountModel2 customerAccount;
    String note;
    String createDate;
    String updateDate;
    AccountModel2 beautyArtistAccount;
    String totalFee;
    String transportFee;
    String endAddress;

    List<BookingDetailModel> bookingDetails;

    BookingModel({
      this.id,
      this.status,
      this.customerAccount,
      this.note,
      this.createDate,
      this.updateDate,
      this.beautyArtistAccount,
      this.totalFee,
      this.transportFee,
      this.endAddress,
      this.bookingDetails,
    });
    Map<String, dynamic> toMap() {
      return {
        'id' : id,
        'status': status,
        'note': note,
        'createDate': createDate,
        'updateDate': updateDate,
        'customerAccount': customerAccount.toMap(),
        'beautyArtistAccount': beautyArtistAccount.toMap(),
        'endAddress': endAddress,
        'totalFee': totalFee,
        'transportFee': transportFee,
        'bookingDetails': bookingDetails,
      };
    }

    factory BookingModel.fromMap(Map<String, dynamic> map) {
     var list = List<BookingDetailModel>.from(map['bookingDetails']?.map((x) => BookingDetailModel.fromMap(x)));
      return BookingModel(
        id: map['id'].toString(),
        status: map['status'],
        note: map['note'],
        createDate: map['createDate'],
        updateDate: map['updateDate'],
        customerAccount: AccountModel2.fromMap(map['customerAccount']),
        beautyArtistAccount: AccountModel2.fromMap(map['beautyArtistAccount']),
        endAddress: map['endAddress'],
        totalFee: map['totalFee'].toString(),
        transportFee: map['transportFee'].toString(),
        bookingDetails: list,
      );
    }

    String toJson() => json.encode(toMap());

    factory BookingModel.fromJson(String source) =>
        BookingModel.fromMap(json.decode(source));

}