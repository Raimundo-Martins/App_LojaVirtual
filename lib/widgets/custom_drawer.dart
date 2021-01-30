import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        'Loja\nVirtual',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá, ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            child: Text(
                              'Entre ou cadastre-se >',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTale(Icons.home, 'Início'),
              DrawerTale(Icons.list, 'Produtos'),
              DrawerTale(Icons.location_on, 'Lojas'),
              DrawerTale(Icons.playlist_add_check, 'Meus pedidos')
            ],
          )
        ],
      ),
    );
  }
}
