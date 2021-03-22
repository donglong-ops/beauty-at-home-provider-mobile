import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/service_model_new.dart';

class ServiceProvider extends ChangeNotifier {
  List<ServiceModelNew> _service;
  List<ServiceModelNew> get services => _service;

  void initAllService(String url) async {
    final fromMap = (source) => ServiceModelNew.fromMap(source);
    _service = await SimpleAPI.getAllNew<ServiceModelNew>(fromMap , url);
    notifyListeners();
  }
}
