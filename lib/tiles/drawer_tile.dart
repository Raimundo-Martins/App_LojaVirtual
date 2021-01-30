import 'package:flutter/material.dart';

class DrawerTale extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController _pageController;
  final int page;

  DrawerTale(this.icon, this.text, this._pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          _pageController.jumpToPage(page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: _pageController.page.round() == page
                    ? Colors.green
                    : Colors.black,
              ),
              SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    color: _pageController.page.round() == page
                        ? Colors.green
                        : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
