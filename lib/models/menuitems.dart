import 'package:firestoreapp/blocs/bloc_provider.dart';
import 'package:firestoreapp/blocs/menuitem_bloc.dart';
import 'package:firestoreapp/pages/menuitemspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  final color = const Color(0xFF00251a);
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: key,
      theme: new ThemeData(
          primaryColor: Colors.grey,
          accentColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
      home: BlocProvider(
        bloc: MenuItemBloc(),
        child: MenuItemsPage(),
      ),
    );
  }
}
