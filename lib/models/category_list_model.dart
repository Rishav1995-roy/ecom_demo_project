// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
    int id;
    String name;
    String slug;
    String image;
    DateTime creationAt;
    DateTime updatedAt;

    CategoryListModel({
        required this.id,
        required this.name,
        required this.slug,
        required this.image,
        required this.creationAt,
        required this.updatedAt,
    });

    factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "creationAt": creationAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
