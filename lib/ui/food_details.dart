import 'package:firestoreapp/blocs/bloc_provider.dart';
import 'package:firestoreapp/blocs/cart_bloc.dart';
import 'package:firestoreapp/models/cartitems.dart';
import 'package:firestoreapp/sqlite/FoodModel.dart';
import 'package:flutter/material.dart';

class FoodDetails extends StatelessWidget {
  final String name;
  final String image;
  final String describtion;
  final String price;
  final String id;

  FoodDetails(this.name, this.image, this.describtion, this.price, this.id);

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

    int ids = int.parse(id);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  collapseMode: CollapseMode.parallax,
                  background: Image.network(
                    image,
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: double.infinity,
                  child: new Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            name,
                            style: TextStyle(color: Colors.red),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: new Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10.0,
                                ),
                                new Text(
                                  "\$",
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  width: 14.0,
                                ),
                                new Text(
                                  price,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: new Container(
                              width: 104.0,
                              height: 30.0,
                              color: Colors.green,
                              child: new Row(
                                children: <Widget>[
                                  new IconButton(
                                      icon: new Icon(Icons.minimize),
                                      onPressed: () {}),
                                  new Text("0"),
                                  new IconButton(
                                      icon: new Icon(Icons.add),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartItems()));
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 70.0,
                  width: double.infinity,
                  child: new Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: new Text(
                        describtion,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Food food = new Food(
              id: ids, foodName: name, price: int.parse(price), total: 0);
          cartBloc.add(food);
        },
        child: new Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }
}
