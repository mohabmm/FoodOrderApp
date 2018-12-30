import 'dart:async';

import 'package:firestoreapp/blocs/bloc_provider.dart';
import 'package:firestoreapp/sqlite/Database .dart';
import 'package:firestoreapp/sqlite/FoodModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc implements BlocBase {
  CartBloc() {
    getFoods();
  }

  int counter;

  Stream<List<Food>> get foods => _foodSubject.stream;
  final _foodSubject = BehaviorSubject<List<Food>>();

  final _priceSubject = BehaviorSubject<int>();
  Stream<int> get outPrice => _priceSubject.stream;

  @override
  dispose() {
    _priceSubject.close();
    _foodSubject.close();
  }

// this function is used to save the data to shared preference
  // to allow us add on last total when we change screens
  totalPrice(int price, Food client) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    Future<int> _counter;
    Future<Null> _incrementCounter() async {
      final SharedPreferences prefs = await _prefs;
      counter = (prefs.getInt('total') ?? 0) + price;
      _counter = prefs.setInt("total", counter).then((bool success) {
        client.total = counter;
        DBProvider.db.newFood(client);
        getFoods();
        return counter;
      });
    }

    _counter = _prefs.then((SharedPreferences prefs) {
      _incrementCounter();
      return (prefs.getInt('total') ?? 0);
    });
  }

  getFoods() async {
    _foodSubject.sink.add(await DBProvider.db.getAllFoods());
  }

  delete(int id) {
    DBProvider.db.deleteFood(id);
    getFoods();
  }

  deleteAll() {
    DBProvider.db.deleteAll();
    getFoods();
  }

  add(Food client) async {
    totalPrice(client.price, client);
  }

  clearPref() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
