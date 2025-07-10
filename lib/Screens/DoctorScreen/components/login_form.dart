import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'model.dart';
import 'remoteserv.dart';

class DoctorForm extends StatefulWidget {
  const DoctorForm({Key? key}) : super(key: key);

  @override
  State<DoctorForm> createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  String _location = 'cairo';
  String _day = 'sat';

  final GetStorage _storage = GetStorage();
  final Dio _dio = Dio();

  List<doctors>? _events;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    setState(() => _loading = true);
    _events = await remoteServices().getEvents(_location, _day);
    setState(() => _loading = false);
  }

  Future<void> _book(String mobileDoctor) async {
    try {
      final response = await _dio.post(
        'https://booking-project-carp.vercel.app/api/bookdoctor',
        data: {
          'day': _day,
          'mobileDoc': mobileDoctor,
          'mobilePat': _storage.read('umobile').toString(),
        },
      );
      _showToast(response.statusCode == 200 ? 'Booked successfully' : 'Error');
    } catch (e) {
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
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          children: [
            _Filters(
              location: _location,
              day: _day,
              onLocationChanged: (v) {
                setState(() => _location = v ?? 'cairo');
                _getData();
              },
              onDayChanged: (v) {
                setState(() => _day = v ?? 'sat');
                _getData();
              },
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                onRefresh: _getData,
                child: _events == null || _events!.isEmpty
                    ? const _EmptyState()
                    : LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 600;
                    final crossAxisCount = isWide ? 2 : 1;
                    final childAspectRatio = isWide ? 2.2 : 1.9; // ↓ smaller number ⇒ taller cell
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: childAspectRatio,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemCount: _events!.length,
                      itemBuilder: (context, index) {
                        final doctor = _events![index];
                        return DoctorCard(
                          doctor: doctor,
                          onBook: () => _book(doctor.mobile ?? ''),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
    required this.doctor,
    required this.onBook,
  }) : super(key: key);

  final doctors doctor;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(

        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF104c91), Color(0xff556ab6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 120),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Image
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
                    // Info & Booking
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${doctor.firstName} ${doctor.lastName}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doctor.specialist ?? 'Specialist',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RatingBarIndicator(
                            rating: doctor.rate?.toDouble() ?? 0,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: onBook,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Color(0xFF117C6F),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Book Now',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    Key? key,
    required this.location,
    required this.day,
    required this.onLocationChanged,
    required this.onDayChanged,
  }) : super(key: key);

  final String location;
  final String day;
  final ValueChanged<String?> onLocationChanged;
  final ValueChanged<String?> onDayChanged;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _StyledDropdown(
              value: location,
              items: const ['cairo', 'Alexandria', 'Giza', 'Luxor'],
              onChanged: onLocationChanged,
              label: 'Location',
              textStyle: textStyle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StyledDropdown(
              value: day,
              items: const ['sat', 'sun', 'mon', 'tue', 'wen', 'thu', 'fri'],
              onChanged: onDayChanged,
              label: 'Day',
              textStyle: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class _StyledDropdown extends StatelessWidget {
  const _StyledDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
    required this.textStyle,
  }) : super(key: key);

  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String label;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            onChanged: onChanged,
            style: textStyle,
            items: items
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No doctors found for the selected day and location.'),
    );
  }
}