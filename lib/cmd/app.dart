import 'package:flutter/widgets.dart';
import 'package:srigunting_app/src/infrastructure/services/func_log.dart';

class App extends StatelessWidget {
  App({super.key}) {
    _init();
  }

  _init() async {
    // _setLogger();
    // _initFB();
    FlutterError.onError = (FlutterErrorDetails details) {
      logError("flutter-error", details.exception);
      logError("flutter-error", details.stack);
    };
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
