import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shoeshop_flutter/models/shoe.dart';

class ShoeProvider extends ChangeNotifier {
  static const String url = "https://shoe-api-9pag.onrender.com/shoes";
  List<Shoe> _shoes = [];

  List<Shoe> get shoes => _shoes;

  List<Shoe> _carts = [];

  List<Shoe> get carts => _carts;

  Future<void> getAllProductsServerandSaveLocal() async {
    var box = await Hive.openBox<Shoe>('shoeBox');
    box.clear();
    if (box.isEmpty) {
      try {
        final response = await http.get(Uri.parse(url));

        var list = json.decode(response.body) as List<dynamic>;

        List<Shoe> data = list.map((e) => Shoe.fromJson(e)).toList();

        for (int i = 0; i < data.length; i++) {
          await box.add(data[i]);
        }
      } catch (e) {
        print(e);
        _shoes = [];
      }
    }
    await getAllShoesLocal();
  }

  getAllShoesLocal() async {
    var box = await Hive.openBox<Shoe>('shoeBox');

    _shoes = box.values.toList();
    getAllShoeInCart();
    notifyListeners();
  }

  getAllShoeInCart() {
    for (var shoe in _shoes) {
      if (shoe.isCart == true) {
        _carts.add(shoe);
      }
    }
  }

  updateIsCart(int index, bool isCart, int number) {
    Shoe _shoe = Shoe(
        id: _shoes[index].id,
        image: _shoes[index].image,
        name: _shoes[index].name,
        price: _shoes[index].price,
        description: _shoes[index].description,
        color: _shoes[index].color,
        isCart: isCart,
        number: number);
    _shoes[index] = _shoe;
    updateShoeLocal(_shoe, index);
    if (isCart == true) {
      _carts.add(_shoe);
    }

    notifyListeners();
  }

  updateNumber(int index, int number, int id) {
    int indexShoe = _shoes.indexWhere((shoe) => shoe.id == id);
    Shoe _shoe = Shoe(
        id: _carts[index].id,
        image: _carts[index].image,
        name: _carts[index].name,
        price: _carts[index].price,
        description: _carts[index].description,
        color: _carts[index].color,
        isCart: _carts[index].isCart,
        number: number);
    _carts[index] = _shoe;
    updateShoeLocal(_shoe, indexShoe);
    notifyListeners();
  }

  removeShoeInCart(int index) {
    int indexShoe = _shoes.indexWhere((shoe) => shoe.id == _carts[index].id);
    _carts.removeAt(index);
    updateIsCart(indexShoe, false, 0);
  }

  Future<void> updateShoeLocal(Shoe shoe, int index) async {
    var box = await Hive.openBox<Shoe>('shoeBox');
    box.putAt(index, shoe);
    notifyListeners();
  }
}
