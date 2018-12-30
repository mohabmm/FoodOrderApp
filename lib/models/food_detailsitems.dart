import 'package:firestoreapp/blocs/bloc_provider.dart';
import 'package:firestoreapp/blocs/cart_bloc.dart';
import 'package:firestoreapp/ui/food_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodDetailsItems extends StatefulWidget {
  final String name;
  final String image;
  final String describtion;
  final String price;
  String id;
  FoodDetailsItems(
      this.name, this.image, this.describtion, this.price, this.id);

  @override
  _State createState() => new _State(name, image, describtion, price, id);
}

class _State extends State<FoodDetailsItems> {
  String name;
  String image;
  String describtion;
  String price;
  String id;
  final color = const Color(0xFF00251a);

  _State(this.name, this.image, this.describtion, this.price, this.id);

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
        bloc: CartBloc(),
        child: FoodDetails(name, image, describtion, price, id),
      ),
    );
  }
}
