import 'package:flutter/material.dart';


import '../../responsive.dart';
import 'background.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

import 'package:flutter/material.dart';

import '../../responsive.dart';
import 'background.dart';

class TBScreen extends StatelessWidget {
  TBScreen({Key? key}) : super(key: key);

  /// Allows the AppBar button to call `getData()` in BookingFormState
  final GlobalKey<BookingFormState> _bookingKey = GlobalKey<BookingFormState>();

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
            'Booking Times',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              tooltip: 'Refresh',
              onPressed: () => _bookingKey.currentState?.getData(),
            ),
          ],
        ),

        body: Background(
          child: Responsive(
            // ─── Mobile ───
            mobile: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BookingForm(key: _bookingKey),
            ),
            // ─── Desktop ───
            desktop: Center(
              child: SizedBox(
                width: 450,
                child: BookingForm(key: _bookingKey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
