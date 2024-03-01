// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:shoeshop_flutter/models/shoe.dart';

// class CartProvider extends ChangeNotifier {
//   List<Shoe> _carts = [];

//   List<Shoe> get carts => _carts;

//   getAllShoeInCart() async {
//     var box = await Hive.openBox<Shoe>('cartBox');
//     _carts = box.values.toList();
//     notifyListeners();
//   }

//   Future<void> addShoeInCart(Shoe shoe) async {
//     var box = await Hive.openBox<Shoe>('cartBox');
//     box.add(shoe);
//     notifyListeners();
//   }

//   Future<void> removeShoeInCart(int index) async {
//     var box = await Hive.openBox<Shoe>('cartBox');
//     box.deleteAt(index);
//     notifyListeners();
//   }

//   Future<void> updateShoeInCart(Shoe shoe, int index) async {
//     var box = await Hive.openBox<Shoe>('cartBox');
//     box.putAt(index, shoe);
//     notifyListeners();
//   }
// }
