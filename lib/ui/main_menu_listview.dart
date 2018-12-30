import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoreapp/models/fooditems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  MainMenuListView(this.documents);
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: documents.length,
        itemExtent: 220.0,
        itemBuilder: (BuildContext context, int index) {
          String name = documents[index].data['Name'].toString();
          String image = documents[index].data['Image'].toString();
          String id = documents[index].documentID;

          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => FoodItems(
                              documents[index].documentID, name, id)));
                },
                child: new Image.network(
                  image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Text(
                  name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w100),
                ),
              ),
            ],
          );
        });
  }
}
