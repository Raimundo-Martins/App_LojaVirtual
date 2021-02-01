import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct {
  String id;
  String category;
  String idProduct;
  int quantity;
  String size;

  ProductData productData;

  CartProduct();

  CartProduct.formDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    category = snapshot.data['category'];
    idProduct = snapshot.data['idProduct'];
    quantity = snapshot.data['quantity'];
    size = snapshot.data['size'];
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'idProduct': idProduct,
      'quantity': quantity,
      'size': size,
      'product': productData.toResumedMap()
    };
  }
}
