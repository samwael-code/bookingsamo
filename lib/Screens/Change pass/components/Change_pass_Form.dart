import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/forget pass.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (password) {},
            decoration: InputDecoration(
              hintText: "Old Password",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.password),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (password) {},
            decoration: InputDecoration(
              hintText: "New Password",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.password),
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          //   child: TextFormField(
          //     textInputAction: TextInputAction.done,
          //     obscureText: true,
          //     cursorColor: kPrimaryColor,
          //     decoration: InputDecoration(
          //       hintText: "Your password",
          //       prefixIcon: Padding(
          //         padding: const EdgeInsets.all(defaultPadding),
          //         child: Icon(Icons.lock),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "Verfiy_btn",
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "change Now",              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),

              ),
            ),
          ),
          // const SizedBox(height: defaultPadding),
          // AlreadyHaveAnAccountCheck(
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return SignUpScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
          // const SizedBox(height: defaultPadding),
          // Forget_pass(
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return SignUpScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
