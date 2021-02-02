import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot docSnapshot;

  PlaceTile(this.docSnapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Image.network(
              docSnapshot.data['image'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docSnapshot.data['title'],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  docSnapshot.data['address'],
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                child: Text('Ver no mapa'),
                textColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                onPressed: () {
                  launch(
                      'https://www.google.com/maps/search/?api=1&query=${docSnapshot.data['lat']}, ${docSnapshot.data['long']}');
                },
              ),
              FlatButton(
                child: Text('Ligar'),
                textColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                onPressed: () {
                  launch('tel:${docSnapshot.data['phone']}');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
