import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'consts.dart';
import 'models/doctor_model.dart';
import 'models/remoteserve.dart';
import 'models/schedule_model.dart';
import 'models/day_time_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';


class ItemDetal extends StatefulWidget {
  const ItemDetal({super.key});

  @override
  State<ItemDetal> createState() => _ItemDetalState();
}

class _ItemDetalState extends State<ItemDetal> {
  List<DoctorModel>? _doctor;
  ScheduleModel? doctorSchedule;
  bool _loading = true;

  int selectedIndex = 0;
  String? selectedTime;
  DateTime? selectedDate;
  String? selectedTimeString;

  final List<String> weekKeys = ['mon', 'tue', 'wen', 'thu', 'fri', 'sat', 'sun'];
  final List<String> weekLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    setState(() => _loading = true);
    _doctor = await fetchDoctors();
    doctorSchedule = _doctor?.first.schedual;
    setState(() => _loading = false);
  }

  List<Map<String, dynamic>> generateDays() {
    final today = DateTime.now();
    List<Map<String, dynamic>> days = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = today.add(Duration(days: i));
      String key = weekKeys[date.weekday - 1];
      String label = weekLabels[date.weekday - 1];

      bool isAvailable = false;
      switch (key) {
        case 'sat':
          isAvailable = doctorSchedule?.sat ?? false;
          break;
        case 'sun':
          isAvailable = doctorSchedule?.sun ?? false;
          break;
        case 'mon':
          isAvailable = doctorSchedule?.mon ?? false;
          break;
        case 'tue':
          isAvailable = doctorSchedule?.tue ?? false;
          break;
        case 'wen':
          isAvailable = doctorSchedule?.wen ?? false;
          break;
        case 'thu':
          isAvailable = doctorSchedule?.thu ?? false;
          break;
        case 'fri':
          isAvailable = doctorSchedule?.fri ?? false;
          break;
      }

      days.add({
        'label': label,
        'key': key,
        'date': date.day.toString().padLeft(2, '0'),
        'available': isAvailable,
        'fullDate': date,
      });
    }

    return days;
  }

  List<String> generateTimeSlots(String start, String end) {
    final List<String> slots = [];
    TimeOfDay startTime = TimeOfDay(
        hour: int.parse(start.split(':')[0]),
        minute: int.parse(start.split(':')[1]));
    TimeOfDay endTime = TimeOfDay(
        hour: int.parse(end.split(':')[0]),
        minute: int.parse(end.split(':')[1]));

    while (startTime.hour < endTime.hour ||
        (startTime.hour == endTime.hour && startTime.minute < endTime.minute)) {
      String formatted = startTime.format(context);
      slots.add(formatted);

      int newMinute = startTime.minute + 30;
      int newHour = startTime.hour + (newMinute ~/ 60);
      newMinute = newMinute % 60;

      startTime = TimeOfDay(hour: newHour, minute: newMinute);
    }

    return slots;
  }

  Map<String, List<String>> splitSlotsByTimeOfDay(List<String> slots) {
    final morning = <String>[];
    final afternoon = <String>[];
    final evening = <String>[];

    for (var time in slots) {
      final hour = int.parse(time.split(":")[0]);
      final isPM = time.toLowerCase().contains("pm");

      int fullHour = hour;
      if (isPM && hour != 12) fullHour += 12;
      if (!isPM && hour == 12) fullHour = 0;

      if (fullHour < 12) {
        morning.add(time);
      } else if (fullHour < 17) {
        afternoon.add(time);
      } else {
        evening.add(time);
      }
    }

    return {
      "Morning": morning,
      "Afternoon": afternoon,
      "Evening": evening,
    };
  }
  String convertTo24HourFormat(String time12h) {
    try {
      DateFormat inputFormat = DateFormat('hh:mm a');
      DateTime dateTime = inputFormat.parse(time12h);
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return 'Invalid time'; // You can handle error differently if needed
    }
  }
  Future<void> _book() async {

    final GetStorage _storage=GetStorage();
    final _dio=Dio();
    String formattedDate = "${selectedDate!.year.toString().padLeft(4, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
final body={'date': formattedDate,
'time':convertTo24HourFormat(selectedTime!),
'mobileDoc': _doctor![0].mobile,
'mobilePat': _storage.read('umobile').toString(),};
    print(body);
    try {
      final response = await _dio.post(
        'https://booking-project-carp.vercel.app/api/bookdoctor',
        data: body,
      );
      print(body);
      _showToast(response.statusCode == 201 ? 'This time is not available' :response.statusCode == 200?"Booked successful":"error" );
    } catch (e) {
      print(e);
      _showToast('Error');
    }
  }
  void _showToast(String msg) {
    showToast(
      msg,
      textStyle: const TextStyle(fontSize: 14, color: Colors.black87),
      textPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: Colors.greenAccent,
      alignment: Alignment.bottomCenter,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      duration: const Duration(seconds: 3),
      context: context,
    );
  }


  @override
  Widget build(BuildContext context) {

    if (_loading || doctorSchedule == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final daysList = generateDays();
    final selectedDay = daysList[selectedIndex];
    final selectedDayKey = selectedDay['key'];
    selectedDate = DateTime(selectedDay['fullDate'].year, selectedDay['fullDate'].month, selectedDay['fullDate'].day).toUtc();
    print('🗓️ Selected Date (UTC at 00:00): ${selectedDate!.toIso8601String()}');

    DayTimeModel? timeInfo;
    switch (selectedDayKey) {
      case 'sat':
        timeInfo = doctorSchedule?.sattime;
        break;
      case 'sun':
        timeInfo = doctorSchedule?.suntime;
        break;
      case 'mon':
        timeInfo = doctorSchedule?.montime;
        break;
      case 'tue':
        timeInfo = doctorSchedule?.tuetime;
        break;
      case 'wen':
        timeInfo = doctorSchedule?.wentime;
        break;
      case 'thu':
        timeInfo = doctorSchedule?.thutime;
        break;
      case 'fri':
        timeInfo = doctorSchedule?.fritime;
        break;
    }

    final slotWidgets = <Widget>[];

    if (timeInfo != null && timeInfo.startTime != null && timeInfo.endTime != null) {
      final slots = generateTimeSlots(timeInfo.startTime!, timeInfo.endTime!);
      final grouped = splitSlotsByTimeOfDay(slots);

      grouped.forEach((label, times) {
        if (times.isNotEmpty) {
          slotWidgets.add(
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: AppStyle.bold(title: label, size: AppSizes.size22),
            ),
          );

          slotWidgets.add(
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2.6,
                children: times
                    .map((time) => doctorTimings(time, time == selectedTime))
                    .toList(),
              ),
            ),
          );
        }
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Image.asset('assets/doctor.png', width: 120),
                    5.widthBox,
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: AppStyle.bold(
                                title: "Dr: ${_doctor![0].firstName} ${_doctor![0].lastName}",
                                color: AppColors.whiteColor,
                                size: AppSizes.size22),
                          ),
                          AppStyle.normal(
                              title: "${_doctor![0].specialist}",
                              color: AppColors.whiteColor,
                              size: AppSizes.size16),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: AppStyle.normal(
                                title: "Rating: ${_doctor![0].rate}",
                                color: AppColors.yellowColor,
                                size: AppSizes.size14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: AppStyle.bold(title: "This Week", size: AppSizes.size22),
            ),
            10.heightBox,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: daysList.length,
                itemBuilder: (context, index) {
                  final item = daysList[index];
                  return GestureDetector(
                    onTap: item['available']
                        ? () {
                      setState(() {
                        selectedIndex = index;
                        selectedTime = null;
                        selectedTimeString = null;
                        selectedDate = DateTime(item['fullDate'].year, item['fullDate'].month, item['fullDate'].day).toUtc();
                        print('🗓️ Selected Date (UTCcc at 00:00): ${selectedDate!.toIso8601String()}');

                      });
                    }
                        : null,
                    child: demoDates(
                      item['label'],
                      item['date'],
                      index == selectedIndex,
                      item['available'],
                    ),
                  );
                },
              ),
            ),
            ...slotWidgets,
            GestureDetector(
              onTap: (){
                if (selectedDate != null || selectedTime != null) {
                  _book();
                }else{
                  showToast('You should choose date and time');
                }
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: AppStyle.bold(
                  title: "Make an Appointment",
                  color: AppColors.whiteColor,
                  size: AppSizes.size18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget demoDates(String day, String date, bool isSelected, bool isEnabled) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryColor
            : isEnabled
            ? AppColors.bgDarktColor
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppStyle.bold(
            title: day,
            color: isSelected
                ? AppColors.whiteColor
                : isEnabled
                ? Colors.black
                : Colors.grey,
            size: AppSizes.size20,
          ),
          const SizedBox(height: 10),
          AppStyle.bold(
            title: date,
            color: isSelected
                ? AppColors.whiteColor
                : isEnabled
                ? Colors.black
                : Colors.grey,
            size: AppSizes.size18,
          ),
        ],
      ),
    );
  }

  Widget doctorTimings(String time, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = time;

          final parts = time.split(" ");
          final hm = parts[0].split(":");
          int hour = int.parse(hm[0]);
          int minute = int.parse(hm[1]);

          if (parts[1].toLowerCase() == "pm" && hour != 12) hour += 12;
          if (parts[1].toLowerCase() == "am" && hour == 12) hour = 0;

          selectedTimeString = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
          print('⏰ Selected Time (HH:mm): $selectedTimeString');
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.bgDarktColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time,
                color: isSelected ? Colors.white : Colors.black, size: 18),
            const SizedBox(width: 4),
            AppStyle.bold(
              title: time,
              color: isSelected ? Colors.white : Colors.black,
              size: AppSizes.size16,
            ),
          ],
        ),
      ),
    );
  }
}
