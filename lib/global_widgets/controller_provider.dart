import 'package:flutter/material.dart';
import 'package:simple_debugger/console_logs/controller/console_log_controller.dart';
import 'package:simple_debugger/network_logs/controller/call_log_controller.dart';

/// Inherited Widget that stores controller's instances
/// in its state.
class ControllerProvider extends InheritedWidget {
  final ConsoleLogController consoleLogController;
  final CallLogController? callLogController;

  /// Inherited Widget that provides Controller's instances to the widget tree.
  const ControllerProvider({
    super.key,
    required this.consoleLogController,
    this.callLogController,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(ControllerProvider oldWidget) {
    return true;
  }

  /// Gets the Provider instance.
  static ControllerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ControllerProvider>();
  }
}
