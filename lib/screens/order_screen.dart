import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;

  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido realizado'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
            Text(
              'Pedido realizado com sucesso!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,), textAlign: TextAlign.center,
            ),
            Text(
              'Código do pedido: $orderId',
              style: TextStyle(fontSize: 16), textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
