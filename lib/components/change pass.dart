import 'package:flutter/material.dart';
import '../constants.dart';

class ChangePassword extends StatelessWidget {
  final bool login;
  final Function? press;
  const ChangePassword({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Text(
        //   // login ? "haven't an account " : "have an account ",
        //   style: const TextStyle(color: kPrimaryColor),
        // ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "Change Password" : "Change Password",
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
