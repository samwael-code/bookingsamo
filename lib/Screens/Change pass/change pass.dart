import 'package:cancer2/Screens/Profile/Update_Profile_Screen.dart';
import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import 'components/Change_Pass_Screen.dart';
import 'components/Change_pass_Form.dart';

class ChangePasswordScreenn extends StatelessWidget {
  const ChangePasswordScreenn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileUpdateProfileScreenScreen(),
            desktop: Row(
            children: [
              const Expanded(
                child: UpdateProfileScreen(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: ChangePasswordForm(),
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

class MobileUpdateProfileScreenScreen extends StatelessWidget {
  const MobileUpdateProfileScreenScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const ChangePasswordScreen(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: ChangePasswordForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
