// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return UserProfileModel(
    gallery: json['gallery'] == null
        ? null
        : GalleryModel.fromMap(json['gallery']),
    uid: json['uid'] as int,
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    role: json['role'] as String,
    phone: json['phone'] as String,
    accessToken: json['accessToken'] as String,
    firebaseRefreshToken: json['firebaseRefreshToken'] as String,
    idToken: json['idToken'] as String,
  );
}

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'role': instance.role,
      'phone': instance.phone,
      'accessToken': instance.accessToken,
      'firebaseRefreshToken': instance.firebaseRefreshToken,
      'idToken': instance.idToken,
      'gallery': instance.gallery,
    };
