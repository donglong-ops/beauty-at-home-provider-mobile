import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/booking_model.dart';
import 'package:flutter_app/src/utils/api_constants.dart';

class BookingProvider extends ChangeNotifier {
  List<BookingModel> _booking;
  List<BookingModel> get bookings => _booking;

  void initAllBooking(String url) async {
    final fromMap = (source) => BookingModel.fromMap(source);
    _booking = await SimpleAPI.getAllNew<BookingModel>(fromMap, url);
    notifyListeners();
  }

  void initAllNewBooking(String url) async {
    final fromMap = (source) => BookingModel.fromMap(source);
    _booking = await SimpleAPI.getAllNew<BookingModel>(fromMap, url);
    notifyListeners();
  }

  void getAndAddNewBooking(String id) async {
    BookingModel _model = await SimpleAPI.getById(
      EntityEndpoint.BOOKING,
      id,
      fromMap: (json) => BookingModel.fromMap(json),
    );
    _booking.add(_model);
    notifyListeners();
  }
}
