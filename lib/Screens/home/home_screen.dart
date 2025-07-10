import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../../OCR.dart';
import '../DoctorScreen/components/remoteserv.dart';
import '../DoctorScreen/components/model.dart';
import '../bot_screen.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _dio = Dio();
  final _storage = GetStorage();

  Future<void> _book(String mobileDoctor) async {
    try {
      final response = await _dio.post(
        'https://booking-project-carp.vercel.app/api/bookdoctor',
        data: {
          'day': 'sat',
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

  late bool _loading = true;
  final Set<String> _tab2 = {};
  final List<Widget> tablist = [];
  List<doctors>? _doctorslist;
  List<doctors>? doctorswithspecialist;
  int x = 0;

  void getdoctorswithspecial(String s) {
    doctorswithspecialist = _doctorslist?.where((e) => e.specialist == s).toList();
    setState(() {});
  }

  Future<void> _getData() async {
    setState(() => _loading = true);
    _doctorslist = await remoteServices().getEvents('cairo', 'sat');
    doctorswithspecialist = _doctorslist;
    _doctorslist?.forEach((e) {
      print(e);
      _tab2.add(e.specialist!);
    });

    _tab2.forEach((e) {
      print(x);
      tablist.add(_buildTabButton(x, e));
      x = x + 1;
    });
    print(tablist);
    getdoctorswithspecial(_tab2.elementAt(0));
    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  int _currentTab = 0;
  final _searchController = TextEditingController();
  final _tabs = [
    _buildAppointmentList('dentistry'),
    _buildAppointmentList('cardiology'),
    _buildAppointmentList('internal'),
  ];

  @override
  Widget build(BuildContext context) {
    if (_loading == true) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded( // This makes the doctors list scrollable while keeping other widgets fixed
            child: content(),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget content() {
    return doctorswithspecialist == null || doctorswithspecialist!.isEmpty
        ? const _EmptyState()
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: doctorswithspecialist!.length,
        itemBuilder: (context, index) {
          final doctor = doctorswithspecialist![index];
          return DoctorCard(
            doctor: doctor,
            onBook: () => _book(doctor.mobile ?? ''),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xff031e40),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
          ),
          child: Column(
            children: [
              Image.asset("assets/icons/logoB.png", height: 180),
              Image.asset("assets/icons/medical_team.png", width: 300, height: 100),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search Doctor...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    int index = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _tab2.map((e) {
          final widget = _buildTabButton(index, e);
          index++;
          return widget;
        }).toList(),
      ),
    );
  }

  Widget _buildTabButton(int index, String title) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _currentTab = index;
          setState(() {
            getdoctorswithspecial(title);
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _currentTab == index ? Theme.of(context).primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _currentTab == index ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildAppointmentList(String type) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('موعد $type رقم ${index + 1}'),
          subtitle: Text('تفاصيل الموعد ${index + 1}'),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BotScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF104c91),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Chat AI"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VisionOCRPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffe2e4ec),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF104c91)),
                ),
              ),
              child: const Text('OCR'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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