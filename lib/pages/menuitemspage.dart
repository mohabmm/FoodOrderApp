import 'package:firestoreapp/blocs/bloc_provider.dart';
import 'package:firestoreapp/blocs/menuitem_bloc.dart';
import 'package:firestoreapp/models/cartitems.dart';
import 'package:firestoreapp/ui/main_menu_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItemsPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MenuItemsPage> {
  @override
  Widget build(BuildContext context) {
    final colorGrey = const Color(0xFF7f333639);
    final MenuItemBloc menuBloc = BlocProvider.of<MenuItemBloc>(context);

    return new Scaffold(
      drawer: new Drawer(
        child: Container(
          color: colorGrey,
          child: Container(
            color: colorGrey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 120.0, 0.0, 0.0),
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Icon(
                        Icons.restaurant_menu,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: new Text(
                          "Menu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: new Row(
                      children: <Widget>[
                        new Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: new Text(
                            "Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: new Row(
                      children: <Widget>[
                        new Icon(
                          Icons.timer,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: new Text(
                            "Orders",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: new Row(
                      children: <Widget>[
                        new Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: new Text(
                            "Sign out",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: new RawMaterialButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartItems()));
        },
        child: new Icon(
          Icons.add_shopping_cart,
          color: Colors.black,
          size: 30.0,
        ),
        shape: new CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.white,
      ),
      floatingActionButtonLocation: (FloatingActionButtonLocation.endDocked),
      backgroundColor: colorGrey,
      appBar: new AppBar(
        title: new Text("Food app"),
      ),
      body: StreamBuilder(
          stream: menuBloc.menuData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: new CircularProgressIndicator());
            } else if (snapshot.data.documents != null) {
              return MainMenuListView(snapshot.data.documents);
              print(snapshot.data.toString());
            } else {
              return new Text(snapshot.data.toString());
            }
          }),
    );
  }
}
