import 'dart:developer';

import 'package:cancer2/Screens/Profile/Update_Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:get_storage/get_storage.dart';

import 'Screens/Welcome/welcome_screen.dart';

import 'main.dart';

class IntroScreenDefault extends StatefulWidget {
  const IntroScreenDefault({Key? key}) : super(key: key);

  @override
  IntroScreenDefaultState createState() => IntroScreenDefaultState();
}

class IntroScreenDefaultState extends State<IntroScreenDefault> {
  final introdate=GetStorage();

  void endintro(context){

   Navigator.pop (context);


    Navigator.of(context).push(
      MaterialPageRoute(builder: (_)=>WelcomeScreen())
    );

  }
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "Hello dear",
       pathImage: "images/H1.png",
        description: "Welcome to your mobile doctor. Here you can book an appointment with your doctor in a very easy and simple way. All you have to do is find the right doctor and choose the appropriate day and time to visit him.",
        backgroundColor: Color(0xff7f9bdf),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "AI Services",
        description:
        "Here also, using artificial intelligence, you can ask about any symptoms of a disease you are suffering from at any time. The service is available throughout the day, and medical prescriptions can also be read.",
        pathImage: "images/l3.png",
        backgroundColor: Color(0xff1c63a1),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Let's begin",
        description:"Welcome to your integrated medical application. You should feel reassured while you are with us. Let's begin.",
        pathImage: "images/l2.png",
        backgroundColor: Color(0xff053885),
      ),
    );
  }

  void onDonePress() {

    endintro(context);
  }

  void onSkip(){

    endintro(context);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
      onSkipPress: onSkip,
    );
  }
}