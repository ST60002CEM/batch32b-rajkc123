import 'dart:async';
import 'dart:convert';
import 'dart:ui'; // Import this for the blur effect

// Assume these are imported correctly from your project
import 'package:finalproject/app/constants/shared_pref_constants.dart';
import 'package:finalproject/app/storage/shared_preferences.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime expirationDate;

  const CountdownTimer({super.key, required this.expirationDate});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.expirationDate.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = widget.expirationDate.difference(DateTime.now());
        if (remainingTime.isNegative) {
          timer.cancel();
          remainingTime = Duration.zero;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '$days days $hours hrs $minutes min $seconds sec';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(remainingTime),
      style: const TextStyle(fontSize: 16, color: Colors.red),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<Map<String, dynamic>> cardList = [];

  @override
  void initState() {
    super.initState();
    _loadCardList();
  }

  Future<void> _loadCardList() async {
    List<String> cards = await getCardList();
    setState(() {
      cardList = cards.map((card) {
        try {
          return jsonDecode(card) as Map<String, dynamic>;
        } catch (e) {
          return {"card": card, "expirationDate": "N/A"};
        }
      }).toList();
    });
  }

  Future<List<String>> getCardList() async {
    return SharedPref.sharedPref.getStringList(Constants.pricingCardValue) ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    final String userName =
        SharedPref.sharedPref.getString(Constants.userName) ?? '';
    final bool isUserLoggedIn =
        SharedPref.sharedPref.getBool(Constants.isUserLoggedIn) ?? false;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          isUserLoggedIn
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  Color.fromARGB(255, 216, 140, 53),
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Member since 2024',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Subscription Plan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 216, 140, 53),
                          ),
                        ),
                        const SizedBox(height: 10),
                        cardList.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cardList.length,
                                itemBuilder: (context, index) {
                                  String cardName = cardList[index]["card"];
                                  String expirationDateStr =
                                      cardList[index]["expirationDate"];
                                  DateTime expirationDate;
                                  bool isValidDate = true;

                                  try {
                                    expirationDate =
                                        DateTime.parse(expirationDateStr);
                                  } catch (e) {
                                    expirationDate = DateTime.now();
                                    isValidDate = false;
                                  }

                                  return Card(
                                    elevation: 4.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.all(16.0),
                                      title: Text(
                                        cardName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      subtitle: isValidDate
                                          ? Row(
                                              children: [
                                                const Text(
                                                  'Expires on: ',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                CountdownTimer(
                                                    expirationDate:
                                                        expirationDate),
                                              ],
                                            )
                                          : const Text(
                                              'Invalid expiration date',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.red,
                                              ),
                                            ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.deepPurple.shade200,
                                        size: 16,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  'No Subscriptions...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                )
              : const ProfileViewWithNotLoggedIn(),
        ],
      ),
    );
  }
}

class ProfileViewWithNotLoggedIn extends StatelessWidget {
  const ProfileViewWithNotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'Please login to view your profile and subscriptions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
