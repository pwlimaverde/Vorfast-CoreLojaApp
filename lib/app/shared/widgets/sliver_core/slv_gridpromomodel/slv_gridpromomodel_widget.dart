import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
//Importes Internos
// import '../../../../modules/home/model/promo_model.dart';

class SlvGridPromoModelWidget extends StatelessWidget {
  final List listModel;

  const SlvGridPromoModelWidget({required Key key, required this.listModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 0.1,
      crossAxisSpacing: 0.1,
      staggeredTiles: listModel
          .map((model) => StaggeredTile.count(model.x, model.y))
          .toList(),
      children: listModel
          .map((model) => Container(
                // padding: EdgeInsets.only(left: 4.0, right: 4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 1.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: model.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
