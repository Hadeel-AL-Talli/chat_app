
import 'package:chat_app/ui/widgets/widget/CustomButton.dart';
import 'package:chat_app/ui/widgets/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/data/AuthHelper.dart';
import '../../auth/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return Form(
        key: provider.loginKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 50,horizontal: 10),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  label: 'Email',
                  controller: provider.emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                CustomTextField(
                  label: 'Password',
                  controller: provider.passwordController,
                  isHidden: true,
                ),
                CustomButton(title: 'Login', function: provider.loginUser),
                CustomButton(
                    title: 'Send Verification Code Again',
                    function: provider.verifyEmail)
              ],
            ),
          ),
        ),
      );
    });
  }
}
