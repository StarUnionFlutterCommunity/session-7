import 'dart:convert';

import 'package:collection/collection.dart';

class Photo {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromMap(Map<String, dynamic> data) => Photo(
        albumId: data['albumId'] as int?,
        id: data['id'] as int?,
        title: data['title'] as String?,
        url: data['url'] as String?,
        thumbnailUrl: data['thumbnailUrl'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'albumId': albumId,
        'id': id,
        'title': title,
        'url': url,
        'thumbnailUrl': thumbnailUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Photo].
  factory Photo.fromJson(String data) {
    return Photo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Photo] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Photo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      albumId.hashCode ^
      id.hashCode ^
      title.hashCode ^
      url.hashCode ^
      thumbnailUrl.hashCode;
}
