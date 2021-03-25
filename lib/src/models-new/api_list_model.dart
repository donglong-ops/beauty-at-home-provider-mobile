import 'dart:convert';

class ApiListModel<T> {
  List<T> content;
  int total;
  ApiListModel({
    this.total,
    this.content
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'total': total,
    };
  }

  factory ApiListModel.fromMap(Map<String, dynamic> map) {
    return ApiListModel(
      total: map['total'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiListModel.fromJson(String source) =>
      ApiListModel.fromMap(json.decode(source));

}