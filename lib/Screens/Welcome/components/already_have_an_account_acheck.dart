import 'package:flutter/material.dart';
import '../../../constants.dart';

class AlreadyHaveAnAccountChec extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountChec({
    Key? key,
    this.login = false,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? "Forget Password" : "technical support",
            style: const TextStyle(color: kPrimaryColor),
          ),
          GestureDetector(
            onTap: press as void Function()?,
            child: Text(
              login ? "press her" : "press here ",
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
