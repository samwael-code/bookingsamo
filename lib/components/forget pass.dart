import 'package:flutter/material.dart';
import '../constants.dart';

class Forget_pass extends StatelessWidget {
  final bool login;
  final Function? press;
  const Forget_pass({
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
        //   login ? "forget my password " : "have an account ",
        //   style: const TextStyle(color: kPrimaryColor),
        // ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "forget my password" : "forget my pass",
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