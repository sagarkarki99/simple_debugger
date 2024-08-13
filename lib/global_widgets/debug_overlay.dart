import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_debugger/console_logs/controller/console_log_controller.dart';
import 'package:simple_debugger/console_logs/views/console_log_view.dart';
import 'package:simple_debugger/core/logger_theme.dart';
import 'package:simple_debugger/global_widgets/main_debug_view.dart';
import 'package:simple_debugger/global_widgets/widgets.dart';
import 'package:simple_debugger/network_logs/controller/call_log_controller.dart';

import '../services/network_service.dart';
import 'controller_provider.dart';

/// DebugOverlay
class DebugOverlay extends StatefulWidget {
  /// Overlay UI
  const DebugOverlay({
    required this.builder,
    super.key,
    this.icon = const Icon(Icons.bug_report_outlined),
    this.enabled = kDebugMode,
    this.callEmitter,
    this.subscriptionEmitter,
  });

  /// Widget that is displayed at DebugOverlay action header.
  final Widget icon;

  /// Should return your application widget for which DebugOverlay is applied.
  final WidgetBuilder builder;

  /// When this field is [true] - debug overlay is running in your app.
  /// By default, this field get value from const [kDebugMode].
  final bool enabled;

  final NetworkLogEmitter? callEmitter;
  final NetworkLogEmitter? subscriptionEmitter;

  @override
  State<DebugOverlay> createState() => _DebugOverlayState();
}

class _DebugOverlayState extends State<DebugOverlay> {
  final ConsoleLogController consoleLogsController = ConsoleLogController();
  late final CallLogController _callLogController;

  @override
  void initState() {
    super.initState();

    if (widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback(
          (Duration timeStamp) => _insertOverlay(context));
    }

    _callLogController = CallLogController(callEmitter: widget.callEmitter);

    consoleLogsController.initialize();
  }

  @override
  Widget build(BuildContext context) => widget.builder.call(context);

  void _insertOverlay(BuildContext context) {
    const DebugOverlayTheme theme = DebugOverlayTheme();

    return Overlay.of(context).insert(
      OverlayEntry(
        builder: (BuildContext context) => DebugOverlayButton(
          theme: theme,
          onTap: () => _onButtonTap(context, theme),
          child: widget.icon,
        ),
      ),
    );
  }

  void _onButtonTap(BuildContext context, DebugOverlayTheme theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (BuildContext ctx) => ControllerProvider(
        consoleLogController: consoleLogsController,
        callLogController: _callLogController,
        child: FractionallySizedBox(
          heightFactor: 0.9,
          child: widget.callEmitter != null
              ? MainDebugView(theme: theme)
              : ConsoleLogsView(theme: theme),
        ),
      ),
    );
  }
}
