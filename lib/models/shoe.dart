import 'package:hive_flutter/hive_flutter.dart';
part 'shoe.g.dart';

@HiveType(typeId: 0)
class Shoe {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final String? color;

  @HiveField(6, defaultValue: false)
  final bool? isCart;

  @HiveField(7)
  final int? number;

  Shoe(
      {required this.id,
      required this.image,
      required this.name,
      this.description,
      required this.price,
      this.color,
      this.isCart = false,
      this.number});

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      color: json['color'],
    );
  }
}
