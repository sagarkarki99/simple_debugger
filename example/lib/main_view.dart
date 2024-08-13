import 'package:flutter/material.dart';
import 'package:simple_debugger/core/app_logger.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.title});

  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Run this app in debug mode, press any button below and check the debug button and your terminal',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () => AppLogger.i('Information', title: 'Main page'),
            tooltip: 'information',
            child: const Text('Information'),
          ),
          FloatingActionButton(
            onPressed: () => AppLogger.e('This is error!!', title: 'Main page'),
            tooltip: 'error',
            child: const Text('Error'),
          ),
          FloatingActionButton(
            onPressed: () =>
                AppLogger.w('Showing some warning!!', title: 'Main page'),
            tooltip: 'warning',
            child: const Text('Warning'),
          ),
          FloatingActionButton(
            onPressed: () =>
                AppLogger.f('This is a fatal message', title: ' Main Page'),
            tooltip: 'fatal',
            child: const Text('Fatal'),
          ),
          FloatingActionButton(
            onPressed: () =>
                AppLogger.s('This is a success', title: ' Main Page'),
            tooltip: 'success',
            child: const Text('Success'),
          ),
        ],
      ),
    );
  }
}
