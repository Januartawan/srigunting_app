import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/services/firebase_messaging_service.dart';
import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/domain/information.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/qr_code/qr_code.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/shimmer/shimmer_list.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/extention/idr.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/home/bloc/home_bloc.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends AUIManagement<HomeBloc, HomeState, HomeScreen> {
  Guide? guide;
  Balance? balance;
  Balance? reward;
  List<Information>? informations;
  @override
  void onStart() {
    if (kDebugMode) {
      print('HomeScreen onStart called');
    }
    _initializeAndSendDeviceToken();
    super.onStart();
  }
  Future<void> _initializeAndSendDeviceToken() async {
    if (kDebugMode) {
      print('_initializeAndSendDeviceToken started');
    }
    String? deviceToken;
    String? platform;
    try {
      if (kDebugMode) {
        print('Entering try block');
        print('Checking Firebase Messaging initialization...');
      }
      bool isInitialized = await FirebaseMessagingService().isInitialized();
      if (kDebugMode) {
        print('Firebase Messaging initialized: $isInitialized');
      }
      if (!isInitialized) {
        if (kDebugMode) {
          print('Firebase Messaging is not initialized or not supported');
        }
        stateManagement.pushEvent(HomeInitialExecute(
          deviceToken: null,
          platform: null,
        ));
        return;
      }
      if (kDebugMode) {
        print('Firebase Messaging is initialized, getting token...');
      }
      deviceToken = await FirebaseMessagingService().getToken();
      platform = FirebaseMessagingService().getPlatform();
      if (kDebugMode) {
        print('Device token: $deviceToken');
        print('Platform: $platform');
      }
      if (deviceToken != null) {
        if (kDebugMode) {
          print('Device token obtained successfully: $deviceToken');
          print('Platform: $platform');
        }
      } else {
        if (kDebugMode) {
          print('Failed to get device token - token is null');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting device token: $e');
        print('Error stack trace: ${e.toString()}');
      }
    }
    if (kDebugMode) {
      print('Sending event with device token: $deviceToken and platform: $platform');
    }
    stateManagement.pushEvent(HomeInitialExecute(
      deviceToken: deviceToken,
      platform: platform,
    ));
    if (kDebugMode) {
      print('_initializeAndSendDeviceToken completed');
    }
  }
  Widget _dialogShowQr(BuildContext context, String qrCode) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgBasePrimary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Member ID Semeton',
                style: darkText.copyWith(
                    color: AppColors.textBasePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.bgBrandTeritaryInvert,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.bgBasePrimary,
                          borderRadius: BorderRadius.circular(16)),
                      child: SQRCode(
                        data: qrCode,
                        size: 250.0,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      qrCode,
                      style: lightText.copyWith(
                          fontSize: 14, color: AppColors.textBrandOn),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Gunakan QR Code ini untuk klaim susuk',
                textAlign: TextAlign.center,
                style: darkText.copyWith(
                    color: AppColors.textBasePrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 12,
              ),
              SButton(
                label: 'Close',
                textStyle: darkText.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w400),
                buttonStyle: secondaryStyleButton,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget buildState(BuildContext context, HomeState state) {
    switch (state) {
      case HomeInitialLoaded():
        guide = state.dataGuide;
        balance = state.databalance;
        reward = state.dataPointReward;
        informations = state.paginationInformation?.data;
      case HomeInitialError():
        showToastError(context, message: state.error);
      default:
    }
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        SScaffold(
          height: 250,
          headerBody: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Om Swastiastu',
                          style: lightText.copyWith(
                            fontSize: 14,
                            color: AppColors.textBrandOn.withAlpha(179),
                          ),
                        ),
                        state is HomeInitialLoading
                            ? const SShimmerList()
                            : SizedBox(
                                width: 250,
                                child: Text(
                                  guide?.name ?? '',
                                  style: lightText.copyWith(
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                      ],
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routing.NOTIFICATION);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: AppColors.bgBasePrimary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              size: 24,
                              color: AppColors.iconBasePrimary,
                              Icons.notifications_none_rounded,
                            ),
                          ),
                        ),
                        if (state is HomeInitialLoaded &&
                            (state.hasUnreadNotification ?? false))
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          body: RefreshIndicator(
            color: AppColors.bgBrandPrimary,
            backgroundColor: AppColors.bgBasePrimary,
            onRefresh: () async {
              stateManagement.pushEvent(HomeInitialExecute());
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pushNamed(Routing.PROFILE);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.bgBrandPrimary,
                                      width: 2,
                                    ),
                                  ),
                                  child: const SImageSvgAsset(
                                    fileName: 'icon_profile.svg',
                                    width: 48,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Data Diri',
                                  style: darkText.copyWith(
                                    color: AppColors.textBaseSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pushNamed(Routing.REDEEM_POINT);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.bgBrandPrimary,
                                      width: 2,
                                    ),
                                  ),
                                  child: const SImageSvgAsset(
                                    fileName: 'icon_reward_and_point.svg',
                                    width: 48,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Reward & Point',
                                  style: darkText.copyWith(
                                    color: AppColors.textBaseSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pushNamed(Routing.INFORMATIONS);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.bgBrandPrimary,
                                      width: 2,
                                    ),
                                  ),
                                  child: const SImageSvgAsset(
                                    fileName: 'icon_information.svg',
                                    width: 48,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Informasi',
                                  style: darkText.copyWith(
                                    color: AppColors.textBaseSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pushNamed(Routing.FREE_TICKET);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.bgBrandPrimary,
                                      width: 2,
                                    ),
                                  ),
                                  child: const SImageSvgAsset(
                                    fileName: 'icon_free_ticket.svg',
                                    width: 48,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Tiket Gratis',
                                  style: darkText.copyWith(
                                    color: AppColors.textBaseSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price List & Promo',
                      style: darkText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        pushNamed(Routing.PRICELIST_PROGRAM);
                      },
                      child: Text(
                        'Lihat Semua',
                        style: darkText.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bgBrandPrimary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.bgBrandPrimary,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 140,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: informations?.length ?? 0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                pushNamed(
                                  Routing.INFORMATION,
                                  arguments: {
                                    "slug": informations?[index].slug
                                  },
                                );
                              },
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        informations?[index].photo ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 120,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: 350,
              height: 240,
              decoration: BoxDecoration(
                color: AppColors.bgBasePrimary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Susuk',
                            style: lightText.copyWith(
                                decoration: TextDecoration.none,
                                color: AppColors.textBaseSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          state is HomeInitialLoading
                              ? const SShimmerList()
                              : Text(
                                  (balance?.balance ?? 0).convertIDR(),
                                  style: lightText.copyWith(
                                    decoration: TextDecoration.none,
                                    color: AppColors.bgBrandPrimary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Point',
                            style: lightText.copyWith(
                                decoration: TextDecoration.none,
                                color: AppColors.textBaseSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          state is HomeInitialLoading
                              ? const SShimmerList()
                              : Text(
                                  reward?.totalPoint ?? '',
                                  style: lightText.copyWith(
                                      decoration: TextDecoration.none,
                                      color: AppColors.textBasePrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: _dialogShowQr(
                                context,
                                guide?.guideCode ?? '',
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            SQRCode(
                              data: guide?.guideCode ?? '',
                              size: 100.0,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            state is HomeInitialLoading
                                ? const SShimmerList(
                                    width: 100,
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                AppColors.borderBaseTeritary)),
                                    child: Text(
                                      guide?.guideCode ?? '',
                                      style: darkText.copyWith(
                                        decoration: TextDecoration.none,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SButton(
                    label: 'Riwayat Susuk',
                    buttonStyle: secondaryStyleButton,
                    textStyle: darkText.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w400),
                    suffixIcon: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColors.iconBasePrimary,
                    ),
                    onPressed: () {
                      pushNamed(Routing.COMMISION_HISTORY);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  @override
  HomeState get initialData => HomeInitial();
}