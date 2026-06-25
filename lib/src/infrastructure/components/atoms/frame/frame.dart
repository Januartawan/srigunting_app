import 'package:flutter/widgets.dart';
import 'package:srigunting_app/src/routing/router.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';

class Frame extends StatefulWidget {
  const Frame({Key? key}) : super(key: key);

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Stack(
    //     children: [
    //       Column(
    //         children: [
    //           Expanded(
    //             child: Navigator(
    //               onGenerateRoute: RoutingApp.generateRoute,
    //               initialRoute: isLoggedIn ? Routing.APP : Routing.INITIAL_PAGE,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    return Navigator(
      onGenerateRoute: RoutingApp.generateRoute,
      initialRoute: Routing.INITIAL_LOADING,
    );
  }
}
