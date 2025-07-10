

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  //create account
  GlobalKey<FormState>? formKey;
  var _autoValidateMode = AutovalidateMode.disabled;
  final  firstNameController = TextEditingController();
  final  lastNameController = TextEditingController();
  final  addressController = TextEditingController();
  final  emailController = TextEditingController();
  final  mobileController = TextEditingController();
  final  nidController = TextEditingController();
  final  passwordController = TextEditingController();
  final  ageController = TextEditingController();
  String? photo='..';
  final introdate=GetStorage();
  bool? isactive=true;
  final dio=Dio();
  postData(fname,lname,address,email,mobile,nid,password,age,)async{
    try{
      var response=await dio.post('https://booking-project-carp.vercel.app/api/newaccount'
          ,data: {"firstName":fname.toString(),'lastName':lname.toString(),"address":address.toString(),"email":email.toString(),"mobile":mobile.toString(),"Nid":nid.toString(),"password":password.toString(),"age":age,"photo":'hhh',"isactive":isactive});
print(fname);
      if(response.statusCode==200){
        customToast('success', context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<dynamic>(builder: (context) => const LoginScreen()),
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
  firstNameController.dispose();
  lastNameController.dispose();
  addressController.dispose();
  emailController.dispose();
  mobileController.dispose();
  nidController.dispose();
  passwordController.dispose();
  ageController.dispose();



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
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
           controller: firstNameController,
            decoration: InputDecoration(

              hintText: "First name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                 child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
           controller: lastNameController,
            decoration: InputDecoration(
              hintText: "Last name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                 child: Icon(Icons.person_2),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding ),
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

          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
           controller: ageController,
            decoration: InputDecoration(
              hintText: "Your age",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.date_range),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: mobileController,
            decoration: InputDecoration(
              hintText: "Phone number",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.phone),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: nidController,
            decoration: InputDecoration(
              hintText: "National ID",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person_2),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
           controller: addressController,
            decoration: InputDecoration(
              hintText: "Address",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.place),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            obscureText: true,
          controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.password),
              ),
            ),
          ),




          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed:  handleSubmit,
            child: Text("Sign Up".toUpperCase(),
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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
      postData(firstNameController.text,lastNameController.text,addressController.text,emailController.text,mobileController.text,nidController.text,passwordController.text,ageController.text);
     //  introdate.write('fname', firstNameController.text);
     //  introdate.write('lname', lastNameController.text);
     //  introdate.write('email', emailController.text);
     //  introdate.write('age', ageController.text);
     //  introdate.write('ph', mobileController.text);
     //  introdate.write('Nid', nidController.text);
     //  introdate.write('Add', addressController.text);
     //  introdate.write('Pass', passwordController.text);
     //  customToast('تم تسجيل حساب بنجاح', context);
     //  Navigator.pushAndRemoveUntil(
     //      context,
     //      MaterialPageRoute<dynamic>(builder: (context) => const LoginScreen()),
     //          (route) => false
     //  );

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

// import 'package:flutter/material.dart';
//
// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }
//
// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();
//   late String _firstName;
//   late String _lastName;
//   late String _email;
//   late String _password;
//   late String _id;
//   late String _age;
//   late String _mobile;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign up'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'First Name'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your first name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _firstName = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Last Name'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your last name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _lastName = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _email = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _password = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'ID'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _id = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Age'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your age';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _age = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Mobile'),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your mobile number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _mobile = value!;
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Do something with the form data
//                   }
//                 },
//                 child: Text('Sign up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }