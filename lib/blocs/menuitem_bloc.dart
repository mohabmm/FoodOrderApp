import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoreapp/blocs/bloc_provider.dart';

class MenuItemBloc implements BlocBase {
  Stream<QuerySnapshot> _menuStream;

  StreamController<QuerySnapshot> _menuController =
      StreamController<QuerySnapshot>();

  Stream<QuerySnapshot> get menuData => _menuController.stream;

  MenuItemBloc() {
    _menuStream = Firestore.instance.collection('Category').snapshots();
    _menuController.addStream(_menuStream);
  }

  @override
  void dispose() {
    _menuController.close();
  }
}
