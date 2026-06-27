import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/line/line.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/qr_code/qr_code.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/brand_background.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/free_ticket_detail/bloc/free_ticket_detail_bloc.dart';
class FreeTicketDetailScreen extends StatefulWidget {
  final FreeVisit freeVisit;
  const FreeTicketDetailScreen({super.key, required this.freeVisit});
  @override
  State<FreeTicketDetailScreen> createState() => _FreeTicketDetailScreenState();
}
class _FreeTicketDetailScreenState extends AUIManagement<FreeTicketDetailBloc,
    FreeTicketDetailState, FreeTicketDetailScreen> {
  String guideCode = '';
  @override
  void onStart() {
    stateManagement.pushEvent(FreeTicketDetailInitialEvent());
    super.onStart();
  }
  @override
  Widget buildState(BuildContext context, FreeTicketDetailState state) {
    switch (state) {
      case FreeTicketDetailInitiaSuccess():
        guideCode = state.guideCode;
      case FreeTicketDetailInitialError():
        showToastError(context, message: state.error);
        break;
      default:
    }
    return SBrandBgScaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              'Detail Tiket',
              textAlign: TextAlign.center,
              style: lightText.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.bgBasePrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const SImageSvgAsset(
                        fileName: 'icon_ticket.svg',
                        height: 56,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        guideCode,
                        style: darkText.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Text(
                          'Mohon tunjukan QR code di bawah di loket Bali Bird Park',
                          style: darkText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBaseSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SQRCode(
                        data: guideCode,
                        size: 190.0,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const SDashedLine(
                        color: AppColors.borderBasePrimary,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.borderBasePrimary,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tanggal kedatangan ${widget.freeVisit.dateVisit ?? ''}',
                                style: darkText.copyWith(
                                    color: AppColors.textBaseSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${widget.freeVisit.adult ?? '0'} Dewasa, ${widget.freeVisit.child ?? '0'} Anak',
                                style: darkText.copyWith(
                                    color: AppColors.textBaseSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SButton(
            label: 'Tutup',
            buttonStyle: secondaryStyleButton,
            textStyle:
                darkText.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routing.APP);
            },
          ),
        ],
      ),
    );
  }
  @override
  FreeTicketDetailState get initialData => FreeTicketDetailInitial();
}