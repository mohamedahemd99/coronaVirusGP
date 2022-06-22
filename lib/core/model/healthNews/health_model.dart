import 'package:json_annotation/json_annotation.dart';

import 'article_model.dart';

part 'health_model.g.dart';

@JsonSerializable()
class HealthModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  HealthModel({this.status, this.totalResults, this.articles});

   factory HealthModel.fromJson(Map<String, dynamic> json) => _$HealthModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HealthModelToJson(this);
}



