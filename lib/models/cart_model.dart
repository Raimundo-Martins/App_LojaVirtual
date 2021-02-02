import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/widgets/cart_price.dart';
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

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct product in listProducts) {
      if (product.productData != null) {
        price += product.quantity * product.productData.price;
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice() {
    return 9.99;
  }

  void updatePrece() {
    notifyListeners();
  }

  void finishOrder() async {
    if (listProducts.length == 0) return;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double discountPrice = getDiscount();
    double shipPrice = getShipPrice();

    DocumentReference documentReference =
        await Firestore.instance.collection('orders').add({
      'idCliente': user.firebaseUser.uid,
      'products':
          listProducts.map((cartProduct) => cartProduct.toMap()).toList(),
      'shipPrice': shipPrice,
      'productsPrice': productsPrice,
      'discountPrice': discountPrice,
      'totalPrice': productsPrice + shipPrice - discountPrice,
      'status': 1
    });

    await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('orders')
        .document(documentReference.documentID)
        .setData({'orderId': documentReference.documentID});

    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();
  }
}
