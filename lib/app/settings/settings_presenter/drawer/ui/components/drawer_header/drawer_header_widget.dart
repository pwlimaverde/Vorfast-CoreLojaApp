import '../../../../../institucional/institucional_presenter/institucional_presenter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
//Importes Internos
import '../../../../../../routes/app_pages.dart';

class DrawerHeaderWidget extends StatelessWidget {
  final int page;
  final FirebaseResultadoEmpresaModel empresa;
  final String user;
  final Function singOut;
  final bool isLogin;
  final bool isShowNome;

  DrawerHeaderWidget({
    required this.page,
    required this.empresa,
    required this.user,
    required this.singOut,
    required this.isLogin,
    required this.isShowNome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
      height: 270.0,
      child: Stack(
        children: <Widget>[
          Container(
            height: 200,
            width: 260,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: empresa.logo260x200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          isShowNome
              ? Positioned(
                  top: 150.0,
                  left: 0.0,
                  child: Text(
                    empresa.nome,
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Container(),
          isLogin
              ? Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Olá, $user",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Sair",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              FontAwesomeIcons.signOutAlt,
                              color: Theme.of(context).accentColor,
                            ),
                          ],
                        ),
                        onTap: singOut,
                      )
                    ],
                  ),
                )
              : Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Olá, ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Entre ou cadastre-se",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              FontAwesomeIcons.signInAlt,
                              color: Theme.of(context).accentColor,
                            ),
                          ],
                        ),
                        onTap: () {
                          _nav();
                        },
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  _nav() {
    return page == 0 ? null : Get.offAllNamed(Routes.LOGIN);
  }
}
