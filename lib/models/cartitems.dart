import 'package:firestoreapp/blocs/bloc_provider.dart';
import 'package:firestoreapp/blocs/cart_bloc.dart';
import 'package:firestoreapp/ui/cart_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItems extends StatefulWidget {
  CartItems();
  @override
  _State createState() => new _State();
}

class _State extends State<CartItems> {
  final color = const Color(0xFF00251a);

  _State();

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
        child: CartItemsRes(),
      ),
    );
  }
}
