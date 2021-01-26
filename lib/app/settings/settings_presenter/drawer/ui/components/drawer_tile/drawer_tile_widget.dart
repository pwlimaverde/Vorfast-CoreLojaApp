import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerTileWidget extends StatelessWidget {
  final IconData icon;
  final String tile;
  final int indice;
  final int page;
  final String nav;

  DrawerTileWidget({this.icon, this.tile, this.indice, this.page, this.nav});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _nav();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                indice == page
                    ? Theme.of(context).accentColor.withOpacity(0.1)
                    : Colors.transparent,
                Colors.transparent,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32,
                color: indice == page
                    ? Theme.of(context).accentColor
                    : Theme.of(context).accentColor.withOpacity(0.50),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                tile,
                style: TextStyle(
                  fontSize: 16.0,
                  color: indice == page
                      ? Theme.of(context).accentColor
                      : Theme.of(context).accentColor.withOpacity(0.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _nav() {
    return page == indice ? null : nav != null ? Get.offAllNamed(nav) : null;
  }
}
