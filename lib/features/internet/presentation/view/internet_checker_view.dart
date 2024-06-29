import 'package:finalproject/core/common/internet_checker/internet_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InternetChecker extends ConsumerStatefulWidget {
  const InternetChecker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InternetCheckerState();
}

class _InternetCheckerState extends ConsumerState<InternetChecker> {
  @override
  Widget build(BuildContext context) {
    final connectivityStatus = ref.watch(connectivityStatusProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Internet Checker"),
        backgroundColor: Colors.amber,
        elevation: 10.0,
        shadowColor: Colors.black,
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            if (connectivityStatus == ConnectivityStatus.isConnected) {
              return const Text('Connected');
            } else {
              return const Text('Disconnected');
            }
          },

          // mainAxisAlignment: MainAxisAlignment.center,
          // children: [Text("Internet checker")],
        ),
      ),
    );
  }
}
