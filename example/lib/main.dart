import 'package:example/main_view.dart';
import 'package:flutter/material.dart';
import 'package:simple_debugger/core/app_logger.dart';
import 'package:simple_debugger/global_widgets/widgets.dart';

void main() {
  AppLogger.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DebugOverlay(
        builder: (context) => const MainView(
          title: 'hehe',
        ),
      ),
    );
  }
}
