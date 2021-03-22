import 'dart:convert';

class ServiceTypeModel {
  String id;
  String name;
  String description;

  ServiceTypeModel({
    this.id,
    this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory ServiceTypeModel.fromMap(Map<String, dynamic> map) {
    return ServiceTypeModel(
      id: map['id'].toString(),
      description: map['description'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceTypeModel.fromJson(String source) =>
      ServiceTypeModel.fromMap(json.decode(source));
}
