import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../settings/core/core_presenter/core_presenter.dart';

class SlvHeaderWidget extends StatelessWidget {
  final FirebaseResultadoSecaoModel secao;
  final Color color;
  final Function onTap;

  const SlvHeaderWidget(
      {required Key key,
      required this.secao,
      required this.color,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return makeHeader(title: secao.nome, color: color);
  }

  SliverPersistentHeader makeHeader(
      {required String title, required Color color}) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 180.0,
        maxHeight: 250.0,
        child: GestureDetector(
          child: Container(
              color: color ?? Colors.white,
              child: Center(
                child: secao.img.toString().length > 0
                    ? ClipRRect(
                        // borderRadius: BorderRadius.circular(15.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: secao.img,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(
                        secao.nome.toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ),
              )),
          onTap: onTap() ?? null,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
