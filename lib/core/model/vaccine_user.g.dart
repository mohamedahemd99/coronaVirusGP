// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaccineUser _$VaccineUserFromJson(Map<String, dynamic> json) => VaccineUser(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      lat: json['lat'] as String?,
      lang: json['lang'] as String?,
      resultAnswerQuestion: json['resultAnswerQuestion'] as int?,
      status: json['status'] as String?,
      dataOfVaccine: json['dataOfVaccine'] as String?,
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$VaccineUserToJson(VaccineUser instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'phone': instance.phone,
      'password': instance.password,
      'lat': instance.lat,
      'lang': instance.lang,
      'resultAnswerQuestion': instance.resultAnswerQuestion,
      'status': instance.status,
      'dataOfVaccine': instance.dataOfVaccine,
      'uid': instance.uid,
    };
