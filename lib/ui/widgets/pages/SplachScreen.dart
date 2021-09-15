
import 'package:chat_app/ui/widgets/pages/AuthMainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/providers/route_helper.dart';


class SplachScreen extends StatelessWidget {
  static final routeName = 'splachScreen';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      bool userExisting =
      Provider.of<AuthProvider>(context, listen: false).checkUser();
      if (userExisting) {
        RouteHelper.routeHelper.goAndReplacePage(HomePage.routeName);
      } else {
        RouteHelper.routeHelper.goAndReplacePage(AuthMainPage.routeName);
      }
    });
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 30,
        ),
      ),
    );
  }
}
