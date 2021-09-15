import 'package:chat_app/ui/widgets/widget/CustomButton.dart';
import 'package:chat_app/ui/widgets/widget/CustomDropDownButton.dart';
import 'package:chat_app/ui/widgets/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/auth_provider.dart';

class EditProfile extends StatelessWidget {
  static final routeName = 'editProfile';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: Form(
          key: provider.registerKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  label: 'UserName',
                  controller: provider.userNameController,
                ),
                CustomDropDownButton(),
                CustomTextField(
                  label: 'Country',
                  controller: provider.countryController,
                ),
                CustomTextField(
                  label: 'City',
                  controller: provider.cityController,
                ),
                CustomTextField(
                  label: 'Phone',
                  controller: provider.phoneController,
                ),
                CustomButton(title: 'Edit', function: provider.editProfile)
              ],
            ),
          ),
        ),
      );
    });
  }
}
