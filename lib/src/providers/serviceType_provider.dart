import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/service_model_new.dart';
import 'package:flutter_app/src/models-new/service_type_model.dart';

class ServiceTypeProvider extends ChangeNotifier {
  List<ServiceTypeModel> _serviceType;
  List<ServiceTypeModel> get serviceTypes => _serviceType;

  void initAllServiceType(String url) async {
    final fromMap = (source) => ServiceTypeModel.fromMap(source);
    _serviceType = await SimpleAPI.getAllNew<ServiceTypeModel>(fromMap , url);
    notifyListeners();
  }
}
