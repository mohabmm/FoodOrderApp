import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoreapp/models/food_detailsitems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodItemsListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  FoodItemsListView(this.documents);

  final colorGrey = const Color(0xFF7f333639);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        type: MaterialType.transparency,
        child: Container(
          color: colorGrey,
          child: new ListView.builder(
              itemCount: documents.length,
              itemExtent: 220.0,
              itemBuilder: (context, index) {
                String name = documents[index].data['Name'].toString();
                String image = documents[index].data['Image'].toString();
                String describtion =
                    documents[index].data['Description'].toString();
                String price = documents[index].data['Price'].toString();
                String id = documents[index].documentID;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodDetailsItems(
                                name, image, describtion, price, id)));
                  },
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        height: 160.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: new Text(
                          name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
