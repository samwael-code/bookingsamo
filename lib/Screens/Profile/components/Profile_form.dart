import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../Welcome/welcome_screen.dart';
import 'model.dart';
import 'package:get_storage/get_storage.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/change pass.dart';
import '../../../constants.dart';
import '../../Change pass/change pass.dart';
import '../../Change pass/components/Change_Pass_Screen.dart';
import '../../Login/login_screen.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  //get account
  final introdate=GetStorage();

  late Future <user>?events2;

  var isloaded= false;

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
  bool? isactive=true;
  final dio=Dio();
  postData(fname,lname,address,email,mobile,nid,age)async{
    try{
      var response=await dio.patch('https://booking-project-carp.vercel.app/api/updateaccount/'+mobile
          ,data: {"firstName":fname.toString(),'lastName':lname.toString(),"address":address.toString(),"email":email.toString(),"Nid":nid.toString(),"age":age,"photo":'hhh',"isactive":isactive});
      if(response.statusCode!=400){
        customToast('update success', context);



        setState(() {
          events2=fetchCatFact(introdate.read('umobile').toString());
        });




      }else{
        customToast('error', context);
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
      backgroundColor: Colors.red,
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
    //introdate.write('user', '01201356363');
    super.initState();

    events2=fetchCatFact(introdate.read('umobile').toString());

    formKey = GlobalKey<FormState>();




  }
  Future<user> fetchCatFact(ph) async {
    final response = await dio.get('https://booking-project-carp.vercel.app/api/getaccount/'+ph);

    if (response.statusCode == 200) {
      return user.fromJson(response.data);
    } else {
      throw Exception("Failed to load cat fact!");
    }
  }
  @override
  Widget build(BuildContext context){

  return FutureBuilder<user>(
  future: events2,
  builder: (context,  snapshot){
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(Color(0xFF6F35A5)), // same purple
        ),
      );
    }

    // 2️⃣  Handle error states (optional but recommended)
    if (snapshot.hasError) {
      return const Center(child: Text('Error loading profile'));
    } if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(Color(0xFF6F35A5)), // same purple
        ),
      );
    }

    // 2️⃣  Handle error states (optional but recommended)
    if (snapshot.hasError) {
      return const Center(child: Text('Error loading profile'));
    }

    return Form(
      autovalidateMode: _autoValidateMode,
      key: formKey,
      child: Column(
        children: [
        CircleAvatar(
        radius: 70,
        backgroundImage: AssetImage('assets/profile_pictuer.jpg'),
      ),
          const SizedBox(height: defaultPadding ),

          TextFormField(
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: firstNameController,
            onTap: (){
              setState(() {
                firstNameController.text=snapshot.data!.firstName!;
                lastNameController.text=snapshot.data!.lastName!;
                emailController.text=snapshot.data!.email!;
                ageController.text=snapshot.data!.age!.toString();
                addressController.text=snapshot.data!.address!;
                nidController.text=snapshot.data!.nid!;
                mobileController.text=snapshot.data!.mobile!;
              });
            },
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
            onTap: (){
              setState(() {
                firstNameController.text=snapshot.data!.firstName!;
                lastNameController.text=snapshot.data!.lastName!;
                emailController.text=snapshot.data!.email!;
                ageController.text=snapshot.data!.age!.toString();
                addressController.text=snapshot.data!.address!;
                nidController.text=snapshot.data!.nid!;
                mobileController.text=snapshot.data!.mobile!;
              });
            },
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
            onTap: (){
              setState(() {
                firstNameController.text=snapshot.data!.firstName!;
                lastNameController.text=snapshot.data!.lastName!;
                emailController.text=snapshot.data!.email!;
                ageController.text=snapshot.data!.age!.toString();
                addressController.text=snapshot.data!.address!;
                nidController.text=snapshot.data!.nid!;
                mobileController.text=snapshot.data!.mobile!;
              });
            },
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
            onTap: (){
              setState(() {
                firstNameController.text=snapshot.data!.firstName!;
                lastNameController.text=snapshot.data!.lastName!;
                emailController.text=snapshot.data!.email!;
                ageController.text=snapshot.data!.age!.toString();
                addressController.text=snapshot.data!.address!;
                nidController.text=snapshot.data!.nid!;
                mobileController.text=snapshot.data!.mobile!;
              });
            },
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
            onTap: (){
              setState(() {
                firstNameController.text=snapshot.data!.firstName!;
                lastNameController.text=snapshot.data!.lastName!;
                emailController.text=snapshot.data!.email!;
                ageController.text=snapshot.data!.age!.toString();
                addressController.text=snapshot.data!.address!;
                nidController.text=snapshot.data!.nid!;
                mobileController.text=snapshot.data!.mobile!;
              });
            },
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
            onTap: (){
              setState(() {
                firstNameController.text=snapshot.data!.firstName!;
                lastNameController.text=snapshot.data!.lastName!;
                emailController.text=snapshot.data!.email!;
                ageController.text=snapshot.data!.age!.toString();
                addressController.text=snapshot.data!.address!;
                nidController.text=snapshot.data!.nid!;
                mobileController.text=snapshot.data!.mobile!;
              });
            },
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
            onTap: (){
              setState(() {
                firstNameController.text=snapshot.data!.firstName!;
                lastNameController.text=snapshot.data!.lastName!;
                emailController.text=snapshot.data!.email!;
                ageController.text=snapshot.data!.age!.toString();
                addressController.text=snapshot.data!.address!;
                nidController.text=snapshot.data!.nid!;
                mobileController.text=snapshot.data!.mobile!;
              });
            },
            decoration: InputDecoration(
              hintText: "Address",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.place),
              ),
            ),
          ),


          // const SizedBox(height: defaultPadding ),
          // TextFormField(
          //   keyboardType: TextInputType.text,
          //   textInputAction: TextInputAction.next,
          //   cursorColor: kPrimaryColor,
          //   onSaved: (password) {},
          //   decoration: InputDecoration(
          //     hintText: "Password",
          //     prefixIcon: Padding(
          //       padding: const EdgeInsets.all(defaultPadding),
          //       child: Icon(Icons.password),
          //     ),
          //   ),
          // ),



          const SizedBox(height: defaultPadding ),
          ElevatedButton(
            onPressed:(){
             handleSubmit();
            },
            child: Text("Update Profile",              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ChangePassword(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChangePasswordScreenn();
                  },
                ),
              );
            },
          ),
          FloatingActionButton(onPressed:  (){
            setState(() async{
              await introdate.remove('displayed');

              // await introdate.write('displayed', false);
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return WelcomeScreen();
                  },
                ),
                    (_) => false,
              );

            });

          },child: Icon(Icons.logout),backgroundColor: Color(0xffb5cae1),),
        ],
      ),
    );


  },


  );

}
  void handleSubmit()async {
    setState(await() {
      if(firstNameController.text.isEmpty){
        firstNameController.text=introdate.read('fname');

      }
      if(lastNameController.text.isEmpty){
        lastNameController.text=introdate.read('lname');

      }
      if(addressController.text.isEmpty){
        addressController.text=introdate.read('Add');

      }
      if(emailController.text.isEmpty){
        emailController.text=introdate.read('email');

      }
      if(mobileController.text.isEmpty){
        mobileController.text=introdate.read('ph');

      }
      if(nidController.text.isEmpty){
        nidController.text=introdate.read('Nid');

      }
      if(ageController.text.isEmpty){
       ageController.text=introdate.read('age');

      }
    });
    final formState = formKey!.currentState;

    if (formState == null) {





      return;
    }
    if (formState!.validate()) {
      _autoValidateMode = AutovalidateMode.always;
      //print(nid.text);

      introdate.write('fname', firstNameController.text);
      introdate.write('lname', lastNameController.text);
      introdate.write('email', emailController.text);
      introdate.write('age', ageController.text);
      introdate.write('ph', mobileController.text);
      introdate.write('Nid', nidController.text);
      introdate.write('Add', addressController.text);
      customToast('تم تحديث البيانات بنجاح', context);
      postData(firstNameController.text,lastNameController.text,addressController.text,emailController.text,mobileController.text,nidController.text,ageController.text);
      setState(() {
        events2=fetchCatFact(introdate.read('umobile').toString());
      });



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