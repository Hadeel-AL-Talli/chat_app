import 'package:chat_app/ui/widgets/widget/CustomButton.dart';
import 'package:chat_app/ui/widgets/widget/CustomDropDownButton.dart';
import 'package:chat_app/ui/widgets/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/providers/auth_provider.dart';
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return Form(
        key: provider.registerKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                label: 'Email',
                controller: provider.emailController,
                textInputType: TextInputType.emailAddress,
              ),
              CustomTextField(
                label: 'Password',
                isHidden: true,
                controller: provider.passwordController,
              ),
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
              CustomButton(
                  title: 'Register', function: provider.registerNewUser)
            ],
          ),
        ),
      );
    });
  }
}
