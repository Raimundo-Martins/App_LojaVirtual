import 'package:flutter/material.dart';

class DrawerTale extends StatelessWidget {
  final IconData icon;
  final String text;

  DrawerTale(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.black,
              ),
              SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 16, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
