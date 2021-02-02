import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('orders')
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              int status = snapshot.data['status'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código do pedido: ${snapshot.data.documentID}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(_buildProductsText(snapshot.data)),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Status do pedido:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircle('1', 'Preparação', status, 1),
                      Container(
                        height: 1,
                        width: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                      _buildCircle('2', 'Transporte', status, 2),
                      Container(
                        height: 1,
                        width: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                      _buildCircle('3', 'Entrega', status, 3)
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = 'Descrição:\n';
    for (LinkedHashMap hashMap in snapshot.data['products']) {
      text +=
          '${hashMap['quantity']} X ${hashMap['product']['title']} (R\$ ${hashMap['product']['price'].toStringAsFixed(2)})\n';
    }
    text += 'Total: R\$ ${snapshot.data['totalPrice'].toStringAsFixed(2)}';
    return text;
  }

  Widget _buildCircle(String title, String subtitle, int status, thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.grey[500];
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );
  }
}
