import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:srigunting_app/src/infrastructure/state_management/management.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

abstract class AUIManagement<SM extends AStateManagement, AS extends AState,
    S extends StatefulWidget> extends State<S> {
  late SM stateManagement;

  //======================= NOTIFICATION =========================

  Future<dynamic> showToastError(BuildContext context,
      {String? message, int? maxLine}) async {
    Future.delayed(Duration.zero, () {
      return Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: message ?? "Error",
        icon: const Icon(
          Icons.error,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: AppColors.bgDangerPrimary.withOpacity(0.97),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
    });
  }

  Future<dynamic> showToastInfo(BuildContext context, {String? message}) {
    return Future.delayed(
      Duration.zero,
      () {
        return Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          message: message,
          icon: const Icon(
            Icons.done,
            size: 28.0,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: Colors.blue,
        ).show(context);
      },
    );
  }

  Future<dynamic> showToastSuccess(BuildContext context,
      {String? message}) async {
    Future.delayed(
      Duration.zero,
      () {
        return Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          message: message,
          icon: const Icon(
            Icons.done,
            size: 28.0,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
          // leftBarIndicatorColor: AppColors.bgSuccessPrimary,
          backgroundColor: AppColors.bgSuccessPrimary,
        ).show(context);
      },
    );
  }

  //======================= ROUTING =========================

  //pushNamed push navigator
  pushNamed(String routeName, {Map? arguments = const {}}) {
    Future.delayed(
      Duration.zero,
      () {
        Navigator.pushNamed(context, routeName, arguments: arguments);
      },
    );
  }

  pushNamedWithContext(BuildContext context, String routeName,
      {Map? arguments = const {}}) {
    Future.delayed(
      Duration.zero,
      () {
        Navigator.pushNamed(context, routeName, arguments: arguments);
      },
    );
  }

  pushReplacementNamed(String routeName, {Map? arguments = const {}}) {
    Future.delayed(
      Duration.zero,
      () {
        Navigator.pushReplacementNamed(context, routeName,
            arguments: arguments);
      },
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      String routeName, bool Function(Route<dynamic>) predicate,
      {Map? arguments = const {}}) async {
    Future.delayed(
      Duration.zero,
      () {
        return Navigator.pushNamedAndRemoveUntil<T>(
            context, routeName, predicate,
            arguments: arguments);
      },
    );
    return null;
  }

  //======================= DOM RENDER =========================
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AS>(
        initialData: initialData,
        stream: stateManagement.stateStream as Stream<AS>?,
        builder: (context, snapshot) =>
            buildState(context, snapshot.data ?? initialData));
  }

  Widget buildState(BuildContext context, AS state);

  AS get initialData;

  @override
  void initState() {
    stateManagement = injectStateManagement();
    WidgetsFlutterBinding.ensureInitialized();

    onStart();
    super.initState();
  }

  ///top gate dependency injection
  SM injectStateManagement() {
    return KiwiContainer().resolve<SM>();
  }

  //do something after mount dependency injection
  void onStart() {}

  ///Rebuild DOM
  void reBuild() {
    stateManagement.emit(initialData);
  }

  Future<T?> showADialog<T>(
      {required BuildContext context,
      required Widget Function(BuildContext context) builder}) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bgBasePrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                  padding: EdgeInsets.all(28.0), child: builder(context)),
            ),
          ),
        );
      },
    );
  }
}
