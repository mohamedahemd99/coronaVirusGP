import 'package:json_annotation/json_annotation.dart';

part 'vaccine_user.g.dart';

@JsonSerializable()
class VaccineUser {
  String? fullName;
  String? email;
  String? photoUrl;
  String? phone;
  String? password;
  String? lat;
  String? lang;
  int? resultAnswerQuestion;
  String? status;
  String? dataOfVaccine;
  String? uid;

  VaccineUser(
      {this.fullName,
      this.email,
      this.photoUrl,
      this.phone,
      this.password,
      this.lat,
      this.lang,
      this.resultAnswerQuestion,
      this.status,
      this.dataOfVaccine,
      this.uid});
  factory VaccineUser.fromJson(Map<String, dynamic> json) =>
      _$VaccineUserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VaccineUserToJson(this);
}
