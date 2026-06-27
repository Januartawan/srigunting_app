import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/information.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/ui/app/information_detail/bloc/information_detail_bloc.dart';
class InformationDetailScreen extends StatefulWidget {
  final String slug;
  const InformationDetailScreen({super.key, required this.slug});
  @override
  State<InformationDetailScreen> createState() => _InformationDetailScreenState();
}
class _InformationDetailScreenState extends AUIManagement<InformationDetailBloc,
    InformationDetailState, InformationDetailScreen> {
  Information? information;
  @override
  void onStart() {
    stateManagement.pushEvent(InformationDetailInitialEvent(slug: widget.slug));
    super.onStart();
  }
  @override
  Widget buildState(BuildContext context, InformationDetailState state) {
    switch (state) {
      case InformationDetailInitialLoaded():
        information = state.dataInformation;
      case InformationDetailInitialError():
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
              padding: EdgeInsets.zero,
              children: [
                (information?.photo != null && information!.photo!.isNotEmpty)
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Image.network(
                          information!.photo!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 300,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.grey,
                        ),
                        child: const Icon(Icons.image,
                            size: 100, color: Colors.white),
                      ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  information?.name ?? '',
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
                      information?.dateStart ?? '',
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
                Text(information?.description ?? ''),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  InformationDetailState get initialData => InformationDetailInitial();
}