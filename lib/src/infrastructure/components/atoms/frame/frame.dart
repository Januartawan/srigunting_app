import 'package:flutter/widgets.dart';
import 'package:srigunting_app/src/routing/router.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  @override
  Widget build(BuildContext context) {
    return const Navigator(
      onGenerateRoute: RoutingApp.generateRoute,
      initialRoute: Routing.INITIAL_LOADING,
    );
  }
}
