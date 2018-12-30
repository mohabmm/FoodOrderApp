import 'package:firestoreapp/blocs/bloc_provider.dart';
import 'package:firestoreapp/blocs/foodItem_bloc.dart';
import 'package:firestoreapp/pages/fooditemspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodItems extends StatefulWidget {
  final String catgoryId;
  final String name;
  final String id;
  FoodItems(this.catgoryId, this.name, this.id);
  @override
  _State createState() => new _State(catgoryId, name, id);
}

class _State extends State<FoodItems> {
  String catgoryId;
  String name;
  String id;
  final color = const Color(0xFF00251a);

  _State(this.catgoryId, this.name, this.id);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primaryColor: color,
          accentColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
      home: BlocProvider(
        bloc: FoodItemBloc(catgoryId),
        child: FoodItemsPage(name, id),
      ),
    );
  }
}
