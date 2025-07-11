import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';

import 'model.dart';
import 'remoteserv.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key? key}) : super(key: key);

  @override
  BookingFormState createState() => BookingFormState();
}

class BookingFormState extends State<BookingForm> {
  final introdate = GetStorage();
  List<booking>? events;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    events = await remoteServices().getEvents(introdate.read('umobile'));
    setState(() => isLoaded = events?.isNotEmpty ?? false);
  }

  void _showToast(String msg) {
    showToast(
      msg,
      textStyle: const TextStyle(fontSize: 14, color: Colors.black),
      textPadding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(15),
      backgroundColor: Colors.green,
      alignment: Alignment.bottomLeft,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      duration: const Duration(seconds: 5),
      context: context,
    );
  }

  Widget _buildGridView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;
        final crossAxisCount = isWide ? 2 : 1;
        final childAspectRatio = isWide ? 2.2 : 1.9;

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: events?.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final b = events![index];
            final formattedDate =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(b.date!));

            return Card(
              elevation: 6,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff031e40), Color(0xff274083)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/doctor.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${b.firstName} ${b.lastName}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Time: ${b.time}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Date: $formattedDate',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: isLoaded
              ? RefreshIndicator(
            onRefresh: getData,
            child: _buildGridView(),
          )
              : const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
