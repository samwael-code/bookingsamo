import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/forget pass.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../Signup/signup_screen.dart';
import '../../forget pass/components/Forget_pass_screen.dart';
import '../../forget pass/forget my pass.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState>? formKey;
  final introdate=GetStorage();
  var _autoValidateMode = AutovalidateMode.disabled;
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();
  final dio=Dio();
  postData(email,password)async{
    try{
      var response=await dio.post('https://booking-project-carp.vercel.app/api/login'
          ,data: {"email":email.toString(),"password":password.toString()});

      if(response.statusCode==200){
        customToast('success', context);
       await introdate.write('displayed', true);
       await introdate.write('umobile', response.data.toString());
       // await introdate.write('uid', response.data._id.toString());
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<dynamic>(builder: (context) =>  BottomNavBar()),
                (route) => false
        );


      }else{
        customToast('Error', context);
      }





    }catch(e){
      customToast('error', context);
      print(e);

    }
  }
  void customToast(String message,BuildContext context){
    showToast(message,textStyle: TextStyle(fontSize: 14,wordSpacing: .1,color: Colors.black),
      textPadding: EdgeInsets.all(16),
      toastHorizontalMargin: 25
      ,borderRadius: BorderRadius.circular(15),
      backgroundColor: Colors.green,
      alignment: Alignment.bottomLeft,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      duration: Duration(seconds: 5),
      context: context,


    );



  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    emailController.dispose();

    passwordController.dispose();




    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed:  handleSubmit,
              child: Text(
                "Login".toUpperCase(),
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
          const SizedBox(height: defaultPadding),
          Forget_pass(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ForgetPassScreenn();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  void handleSubmit() {
    final formState = formKey!.currentState;
    if (formState == null) {
      print('hello');



      return;
    }
    if (formState!.validate()) {
      _autoValidateMode = AutovalidateMode.always;
      //print(nid.text);
      postData(emailController.text,passwordController.text);
     //  try{
     //    print(introdate.read('email'));
     //    if(introdate.read('email')==emailController.text&&introdate.read('Pass')==passwordController.text){
     //      customToast('تم تسجيل الدخول بنجاح', context);
     //       introdate.write('displayed', true);
     //      Navigator.pushAndRemoveUntil(
     //          context,
     //          MaterialPageRoute<dynamic>(builder: (context) =>  BottomNavBar()),
     //              (route) => false
     //      );
     //    }else{
     //      customToast('فشلت عملية تسجيل الدخول', context);
     //    }
     //
     //  }catch(err){
     //    customToast('فشلت عملية تسجيل الدخول', context);
     //  }

      // name.clear();
      //
      // age.clear();
      // collage.clear();
      // grade.clear();
      // ph.clear();
      // nid.clear();





    }
    // if(formState.validate()){

    //
    // }

  }
}
