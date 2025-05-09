import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartData extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final double price;
  
  @HiveField(3)
  final List<String> imageUrl;
  
  @HiveField(4)
  int quantity;

  CartData({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
  
  // Factory constructor to create a Product from API JSON
  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'],
      name: json['title'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['images'],
    );
  }
}