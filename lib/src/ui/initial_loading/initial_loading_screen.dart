import 'package:flutter/cupertino.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/initial_loading/bloc/initial_loading_bloc.dart';
class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({super.key});
  @override
  State<InitialLoadingScreen> createState() => _InitialLoadingScreenState();
}
class _InitialLoadingScreenState extends AUIManagement<InitialLoadingBloc,
    InitialLoadingState, InitialLoadingScreen> {
  @override
  void onStart() {
    stateManagement.pushEvent(InitialLoadingExecuteEvent());
    super.onStart();
  }
  @override
  Widget buildState(BuildContext context, InitialLoadingState state) {
    switch (state) {
      case InitialHasToken():
        pushNamedAndRemoveUntil(Routing.APP, (route) => false);
      case InitialLogin():
        pushReplacementNamed(Routing.INITIAL_PAGE);
        break;
      default:
    }
    return Container(
      color: AppColors.bgBasePrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/srigunting.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const CupertinoActivityIndicator(
            color: AppColors.textBasePrimary,
          )
        ],
      ),
    );
  }
  @override
  InitialLoadingState get initialData => InitialLoadingInitial();
}