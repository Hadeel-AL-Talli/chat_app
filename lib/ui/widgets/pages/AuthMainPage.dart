
import 'package:chat_app/ui/widgets/pages/RigesterPage.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class AuthMainPage extends StatelessWidget {
  static final routeName = 'authMainPage';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Chat'),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'SIGNUP',
                ),
                Tab(
                  text: 'SIGNIN',
                )
              ],
            ),
          ),
          body: TabBarView(children: [RegisterPage(), LoginPage()]),
        ));
  }
}
