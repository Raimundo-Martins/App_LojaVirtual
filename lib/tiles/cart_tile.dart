import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrece();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: 100,
            child: Image.network(
              cartProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cartProduct.productData.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  Text(
                    'Tamanho: ${cartProduct.size}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'R\$ ${cartProduct.productData.price}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(Icons.remove),
                          color: Theme.of(context).primaryColor,
                          onPressed: cartProduct.quantity > 1
                              ? () {
                                  CartModel.of(context)
                                      .decrementProduct(cartProduct);
                                }
                              : null),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            CartModel.of(context).incrementProduct(cartProduct);
                          }),
                      FlatButton(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        color: Colors.red,
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                        minWidth: 5,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection('products')
                  .document(cartProduct.category)
                  .collection('items')
                  .document(cartProduct.idProduct)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct.productData =
                      ProductData.fromDocument(snapshot.data);
                  return _buildContent();
                } else {
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : _buildContent(),
    );
  }
}
