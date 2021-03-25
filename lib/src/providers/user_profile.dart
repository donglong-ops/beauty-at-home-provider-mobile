import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/apis/provider_api/simple_api.dart';
import 'package:flutter_app/src/models-new/gallery_model.dart';
import 'package:flutter_app/src/models-new/image_model.dart';
import 'package:flutter_app/src/models/user_profile_model.dart';
import 'package:flutter_app/src/services/google_service.dart';

class UserProfile extends ChangeNotifier {
  /* Provider states */
  UserProfileModel _profile;
  UserProfileModel get profile => _profile;
  bool _isSignIn = false;

  get isSignIn => _isSignIn;

  Future<void> login() async {
    User user = await GoogleService.instance().loginWithGoogle();
    _isSignIn = true;
    String idToken = await user.getIdToken();
    _profile = await SimpleAPI.login({
      "idToken": idToken,
      "displayName": user.displayName,
      "avatar": user.photoURL,
    });
    _profile.firebaseRefreshToken = user.refreshToken;
    _profile.idToken = idToken;
    _profile.gallery = GalleryModel(images: [
      ImageModel(imageUrl: user.photoURL),
    ]);
    if (_profile != null) {
      _isSignIn = true;
    }
    log("|||||||||||==========<<<<" + _profile.uid.toString());
    notifyListeners();
  }

  void logOut() async {
    await GoogleService.instance().loginWithGoogle();
    _isSignIn = false;
    notifyListeners();
  }
}
