import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'OCR.dart';
import 'Screens/BookingScreen/components/login_form.dart';
import 'Screens/BookingScreen/login_screen.dart';
import 'Screens/DoctorScreen/components/login_form.dart';
import 'Screens/DoctorScreen/login_screen.dart';
import 'Screens/Profile/Update_Profile_Screen.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'Screens/home/home_screen.dart';
import 'constants.dart';
import 'intro.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final introdate2 = GetStorage();

  @override
  void initState() {
    super.initState();
    introdate2.writeIfNull('displayed', false);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DBooking',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: introdate2.read('displayed') ? BottomNavBar() : IntroScreenDefault(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() => [
      HomeScreen(),
      TScreen(),
      TBScreen(),
      //VisionOCRPage(),
      const UpdateProfileScreen(),
    ];

    List<PersistentBottomNavBarItem> _navBarsItems() => [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Color(0xff546da8),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.health_and_safety_outlined),
        title: 'Doctors',
        activeColorPrimary: Color(0xff546da8),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.local_hospital),
        title: 'Bookings',
        activeColorPrimary: Color(0xff546da8),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: 'Profile',
        activeColorPrimary: Color(0xff546da8),
        inactiveColorPrimary: Colors.grey,
      ),
    ];

    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),

      // ✅ Renamed & updated props
      confineToSafeArea: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),

      // ✅ Same as older version
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
      stateManagement: true,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }
}
