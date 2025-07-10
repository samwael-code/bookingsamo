import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import 'components/ForgetPassForm.dart';
import 'components/Forget_pass_screen.dart';

class ForgetPassScreenn extends StatelessWidget {
  const ForgetPassScreenn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: ForgetPassScreen(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: ForgetPassForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         const ForgetPassScreen(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: ForgetPassForm (),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
