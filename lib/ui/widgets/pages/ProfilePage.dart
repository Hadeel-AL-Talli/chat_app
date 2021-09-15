import 'package:chat_app/ui/widgets/widget/ItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return provider.userModel == null
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Column(
            children: [
              GestureDetector(
                onTap: () {
                  provider.updateUserImage();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: provider.userModel.imageUrl != null
                      ? Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                provider.userModel.imageUrl))),
                  )
                      : Container(
                    alignment: Alignment.center,
                    child: Text(
                      provider.userModel.userName[0].toUpperCase(),
                      style: provider.headingStyle,
                    ),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                  ),
                ),
              ),

              ItemWidget('Email', provider.userModel.email),
              ItemWidget('UserName', provider.userModel.userName),
              ItemWidget('Country', provider.userModel.country),
              ItemWidget('City', provider.userModel.city),
              // Text(
              //   provider.userModel.userName,
              //   style: TextStyle(fontSize: 30),
              // ),
              // Text(provider.userModel.email),
              // Text(provider.userModel.country),
              // Text(provider.userModel.city),
              // Text(provider.userModel.gender == Gender.male
              //     ? 'Male'
              //     : 'Female'),
            ],
          );
        },
      ),
    );
  }
}
