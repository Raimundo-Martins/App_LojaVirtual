import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutsData {
  String category;
  String id;
  String title;
  String description;
  double price;
  List images;
  List sizes;

  ProdutsData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'];
    description = snapshot.data['description'];
    price = snapshot.data['price'] + 0.0;
    images = snapshot.data['images'];
    sizes = snapshot.data['sizes'];
  }
}
