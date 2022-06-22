import 'package:json_annotation/json_annotation.dart';

part 'source_model.g.dart';

@JsonSerializable()
class Source {
  String? id;
  String? name;

  Source({this.id, this.name});
  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
