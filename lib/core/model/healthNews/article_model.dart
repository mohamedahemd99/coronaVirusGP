import 'package:json_annotation/json_annotation.dart';

import 'source_model.dart';

part 'article_model.g.dart';

@JsonSerializable()
class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});
  factory Articles.fromJson(Map<String, dynamic> json) => _$ArticlesFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}
