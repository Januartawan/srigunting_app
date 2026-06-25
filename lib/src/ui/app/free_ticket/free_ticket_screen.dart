import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/constant/free_visit_status.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/free_ticket/bloc/free_ticket_bloc.dart';

class FreeTicketScreen extends StatefulWidget {
  const FreeTicketScreen({super.key});

  @override
  State<FreeTicketScreen> createState() => _FreeTicketScreenState();
}

class _FreeTicketScreenState
    extends AUIManagement<FreeTicketBloc, FreeTicketState, FreeTicketScreen> {
  FreeVisit? freeVisit;

  @override
  void onStart() {
    stateManagement.pushEvent(FreeTicketInitialEvent());
    super.onStart();
  }

  @override
  Widget buildState(BuildContext context, FreeTicketState state) {
    switch (state) {
      case FreeTicketLoaded():
        freeVisit = state.dataVisit;
        break;
      default:
    }

    return SScaffold(
        title: 'Tiket Gratis',
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
                          'assets/images/free_ticket_page_img.png',
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
                  // Text(
                  //   freeVisit?.description ?? '',
                  //   style: darkText.copyWith(
                  //       fontWeight: FontWeight.w600, fontSize: 14),
                  // ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Tiket gratis member bersama keluarga',
                          style: darkText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('4,50 Points'),
                  //     Text('10 Stock'),
                  //   ],
                  // ),
                  const Divider(
                    color: AppColors.borderBasePrimary,
                    thickness: 1,
                    height: 20,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Detail Penawaran:',
                    style: darkText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // _listBullet(
                  //     "•", 'Tiket gratis berlaku untuk 2 dewasa dan 2 anak.'),
                  // _listBullet("•",
                  //     'Penawaran ini dapat di-reset setiap tahun, tepatnya mulai 1 Januari tahun depan.'),
                  // _listBullet("•",
                  //     'Tiket hanya berlaku selama periode tahun berjalan.'),
                  _listBullet(
                      "•", 'Berlaku untuk satu kali kunjungan pertahun'),
                  _listBullet("•", 'Tiket tidak dapat dipindahtangankan'),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  // Text(
                  //   'Cara Klaim:',
                  //   style: darkText.copyWith(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // _listBullet(
                  //     "1.", 'Masuk ke akun member Anda melalui aplikasi.'),
                  // _listBullet("2.", 'Klaim tiket gratis di bagian Voucher.'),
                  // _listBullet("3.",
                  //     'Gunakan QR Code yang tersedia untuk ditunjukkan saat kunjungan ke Bali Bird Park.'),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  // Text(
                  //   'Syarat dan Ketentuan:',
                  //   style: darkText.copyWith(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // _listBullet("•",
                  //     'Tiket gratis ini hanya berlaku untuk satu kali kunjungan per tahun.'),
                  // _listBullet("•",
                  //     'Setiap member akan mendapatkan kembali tiket gratis ini setiap tahun, dimulai dari tanggal 1 Januari.'),
                  // _listBullet("•",
                  //     'Tiket tidak dapat dipindahtangankan dan hanya berlaku untuk member terdaftar.'),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  // Text(
                  //   '*Jangan lupa, tiket gratis Anda akan di-reset setiap tahun! Nikmati pengalaman seru di Bali Bird Park bersama orang-orang terdekat Anda',
                  //   style: darkText.copyWith(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
            SButton(
              textStyle: lightText.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              label: 'Gunakan Sekarang',
              buttonStyle: freeVisit?.status == FreeVisitStatus.available
                  ? primaryStyleButton
                  : disabledStyleButton,
              onPressed: freeVisit?.status == FreeVisitStatus.available
                  ? () {
                      pushNamed(Routing.FREE_TICKET_USE);
                    }
                  : null,
            ),
          ],
        ));
  }

  Row _listBullet(String prefixString, String data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(prefixString),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            data,
            style: darkText.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement initialData
  FreeTicketState get initialData => FreeTicketInitial();
}
