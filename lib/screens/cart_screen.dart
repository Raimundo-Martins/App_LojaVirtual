import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Carrinho'),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int totalProduct = model.listProducts.length;
                return Text(
                  '${totalProduct ?? 0} ${totalProduct == 1 ? 'ITEM' : 'ITENS'}',
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
