import 'package:firestoreapp/blocs/bloc_provider.dart';
import 'package:firestoreapp/blocs/foodItem_bloc.dart';
import 'package:firestoreapp/models/menuitems.dart';
import 'package:firestoreapp/ui/food_Items_listview.dart';
import 'package:flutter/material.dart';

class FoodItemsPage extends StatefulWidget {
  final String name;
  final String id;
  FoodItemsPage(this.name, this.id);

  @override
  _State createState() => new _State(name, id);
}

class _State extends State<FoodItemsPage> {
  String name;
  String id;
  _State(this.name, this.id);
  @override
  Widget build(BuildContext context) {
    final FoodItemBloc foodItemBloc = BlocProvider.of<FoodItemBloc>(context);

    return Scaffold(
      appBar: new AppBar(
        title: new Text(name),
        leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MenuItems()));
            }),
      ),
      body: Material(
        type: MaterialType.transparency,
        child: new Container(
          child: StreamBuilder(
              stream: foodItemBloc.outFoodItem,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: new CircularProgressIndicator());
                } else if (snapshot.data.documents != null) {
                  return FoodItemsListView(snapshot.data.documents);
                } else {
                  return new Text(snapshot.data.toString());
                }
              }),
        ),
      ),
    );
  }
}
