import 'package:finalproject/features/auth/presentation/view/login_view.dart';
import 'package:finalproject/features/home/data/model/shake_detector.dart';
import 'package:finalproject/features/home/presentation/navigator/home_navigator.dart';
import 'package:finalproject/features/practice/presentation/view/practice_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedIndex = 0;
  late ShakeDetector _shakeDetector;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePageContent(),
    Text('Pricing Page Content'),
    PracticeTaskView(),
    Text('Settings Page Content'),
  ];

  @override
  void initState() {
    super.initState();
    _shakeDetector = ShakeDetector(onPhoneShake: _handleLogout);
    _shakeDetector.startListening();
  }

  @override
  void dispose() {
    _shakeDetector.stopListening();
    super.dispose();
  }

  void _handleLogout() {
    if (Vibration.hasVibrator() != null) {
      Vibration.vibrate();
    }
    // Perform your logout logic here.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content:
              const Text('You are going to logout due to shaking the device.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to the LoginScreen and remove all previous routes
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginView()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color.fromARGB(255, 43, 36, 46), // Set the background color here
        child: Scaffold(
          backgroundColor: Colors.transparent, // Make Scaffold transparent
          appBar: AppBar(
            title: Image.asset(
              'assets/images/logo.png',
              height: 50,
            ),
            centerTitle: false,
            backgroundColor: Color.fromARGB(255, 68, 117, 68),
            elevation: 10.0,
            shadowColor: Colors.black,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                child: const Text(
                  'Signup / Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money),
                label: 'Pricing',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Practice',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class HomePageContent extends ConsumerWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = ref.watch(homeViewNavigatorProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/logo.png', // Replace with your logo asset
                  height: 150,
                ),
                const Text(
                  'Uplingo\'s Practice Platform',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'The Best Way To Boost Your Score!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Improve your Duolingo English Test score with our unlimited practice platform. '
                  'Start for FREE and begin enhancing your score today.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    navigator.openPracticeView();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
