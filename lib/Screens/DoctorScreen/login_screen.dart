import 'package:flutter/material.dart';


import '../../responsive.dart';
import 'background.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

import 'package:flutter/material.dart';
import '../../responsive.dart';
import 'background.dart';


class TScreen extends StatelessWidget {
  const TScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF104c91), Color(0xff556ab6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Doctors',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),

        body: Background(
          child: Responsive(
            mobile: const _MobileLayout(),
            desktop: Center(
              child: SizedBox(
                width: 450,
                child: DoctorForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DoctorForm(),
    );
  }
}

