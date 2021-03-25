import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/account_model2.dart';
import 'package:flutter_app/src/models-new/service_model_new.dart';

class AccountProvider extends ChangeNotifier {
  AccountModel2 _account;
  AccountModel2 get account => _account;

  void initAccount(String id) async {
    final fromMap = (source) => AccountModel2.fromMap(source);
    _account = await SimpleAPI.getById("fromMap" , id);
    notifyListeners();
  }
}
