import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoreapp/blocs/bloc_provider.dart';

class FoodItemBloc implements BlocBase {
  Stream<QuerySnapshot> _foodStream;

  StreamController<QuerySnapshot> _foodItemController =
      StreamController<QuerySnapshot>();

  Stream<QuerySnapshot> get outFoodItem => _foodItemController.stream;

  FoodItemBloc(String categoryId) {
    _foodStream = Firestore.instance
        .collection('Foods')
        .where('MenuId', isEqualTo: categoryId)
        .snapshots();
    _foodItemController.addStream(_foodStream);
  }

  @override
  void dispose() {
    _foodItemController.close();
  }
}
