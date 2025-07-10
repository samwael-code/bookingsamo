import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/forget pass.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class ForgetPassForm extends StatefulWidget {
  const ForgetPassForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgetPassForm> createState() => _ForgetPassFormState();
}

class _ForgetPassFormState extends State<ForgetPassForm> {
  void customToast(String message,BuildContext context){
    showToast(message,textStyle: TextStyle(fontSize: 14,wordSpacing: .1,color: Colors.black),
      textPadding: EdgeInsets.all(16),
      toastHorizontalMargin: 25
      ,borderRadius: BorderRadius.circular(15),
      backgroundColor: Color(0xff2FC4B2),
      alignment: Alignment.bottomLeft,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      duration: Duration(seconds: 5),
      context: context,


    );



  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
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
              onPressed: () {
                customToast('تم ارسال كلمة مرور جديدة الى بريدك', context);

              },
              child: Text(
                "Reset Now",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),

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
