import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> listProducts = [];

  bool isLoading = false;
  String couponCode;
  int discountPercentage = 0;

  CartModel(this.user) {
    if (user.isLoggedIn()) _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void _loadCartItems() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('card')
        .getDocuments();

    listProducts = querySnapshot.documents
        .map((doc) => CartProduct.formDocument(doc))
        .toList();

    notifyListeners();
  }

  void addCartItem(CartProduct cartProduct) {
    listProducts.add(cartProduct);

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) => {cartProduct.idCard = doc.documentID});

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.idCard)
        .delete();

    listProducts.remove(cartProduct);

    notifyListeners();
  }

  void decrementProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('card')
        .document(cartProduct.idCard)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incrementProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('card')
        .document(cartProduct.idCard)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }
}
