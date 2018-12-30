import 'package:firestoreapp/blocs/bloc_provider.dart';
import 'package:firestoreapp/blocs/cart_bloc.dart';
import 'package:firestoreapp/sqlite/FoodModel.dart';
import 'package:flutter/material.dart';

class CartItemsRes extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<CartItemsRes> {
  Widget build(BuildContext context) {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    int total;

    return new Scaffold(
      floatingActionButton: new RawMaterialButton(
          child: new Icon(Icons.shopping_cart),
          onPressed: () {
            // upload data to Firebase
            // clear the sharedPref Value
            // delete the SqliteData
            cartBloc.clearPref();
            cartBloc.deleteAll();
            total = 0;
          }),
      appBar: new AppBar(
        title: new Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<List<Food>>(
              stream: cartBloc.foods,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 450.0,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            Food item = snapshot.data[index];
                            total = item.total;
                            return Dismissible(
                              key: UniqueKey(),
                              background: Container(color: Colors.red),
                              onDismissed: (direction) {
                                cartBloc.delete(item.id);
                              },
                              child: ListTile(
                                title: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(item.foodName,
                                          style: TextStyle(color: Colors.red)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(item.price.toString(),
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      new Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: new Text(total.toString(),
                              style: TextStyle(
                                  fontSize: 40.0, color: Colors.greenAccent)),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
