import 'package:flutter/material.dart';

class SlvAppbarWidget extends StatelessWidget {
  final String title;
  final bool isAdmin;
  final Widget editButton;
  final Color backgroundColor;

  const SlvAppbarWidget(
      {Key key,
      this.title,
      this.isAdmin,
      this.editButton,
      this.backgroundColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: <Widget>[
        isAdmin ? editButton ?? Container() : Container(),
      ],
      pinned: false,
      floating: true,
      snap: true,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      elevation: 0.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title),
        centerTitle: true,
      ),
    );
  }
}
