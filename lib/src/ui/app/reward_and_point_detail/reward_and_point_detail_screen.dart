import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/reward_and_point_detail/bloc/reward_and_point_detail_bloc.dart';
class RewardAndPointDetailScreen extends StatefulWidget {
  const RewardAndPointDetailScreen({super.key});
  @override
  State<RewardAndPointDetailScreen> createState() => _RewardAndPointDetailScreenState();
}
class _RewardAndPointDetailScreenState extends AUIManagement<
    RewardAndPointDetailBloc,
    RewardAndPointDetailState,
    RewardAndPointDetailScreen> {
  Transaction? transaction;
  @override
  void onStart() {
    stateManagement.pushEvent(RewardAndPointDetailInitialEvent());
    super.onStart();
  }
  @override
  Widget buildState(BuildContext context, RewardAndPointDetailState state) {
    switch (state) {
      case RewardAndPointDetailLoaded():
        transaction = state.dataTransaction;
        break;
      case RewardAndPointDetailError():
        showToastError(context, message: state.error);
        break;
      default:
    }
    return SScaffold(
      title: 'Information Detail',
      onBackAction: () {
        Navigator.pop(context);
      },
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/srigunting-bird.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  transaction?.trxCode ?? 'UNDIAN HADIAH - PERIODE OKTOBER',
                  style: darkText.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.textBaseSecondary,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      transaction?.trxDate ?? '7 Oct 2024',
                      style: darkText.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBaseSecondary),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppColors.textBaseSecondary,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '11:00AM',
                      style: darkText.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBaseSecondary),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  color: AppColors.borderBasePrimary,
                  thickness: 1,
                  height: 20,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text('rest of the text'),
              ],
            ),
          ),
          SButton(
            textStyle: lightText.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            label: 'Lihat Hasil Undian',
            buttonStyle: primaryStyleButton,
            onPressed: () {
              Navigator.pushNamed(context, Routing.LOGIN);
            },
            suffixIcon: const Icon(
              Icons.arrow_forward_rounded,
              size: 14,
              color: AppColors.textBrandOn,
            ),
          ),
        ],
      ),
    );
  }
  @override
  RewardAndPointDetailState get initialData => RewardAndPointDetailInitial();
}