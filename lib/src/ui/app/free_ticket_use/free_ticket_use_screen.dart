import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/icon_button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/date/input_date.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/text_field/text_field.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/repository/request/free_ticket_request.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/free_ticket_use/bloc/free_ticket_use_bloc.dart';

class FreeTicketUseScreen extends StatefulWidget {
  const FreeTicketUseScreen({super.key});

  @override
  State<FreeTicketUseScreen> createState() => _FreeTicketUseScreenState();
}

class _FreeTicketUseScreenState extends AUIManagement<FreeTicketUseBloc,
    FreeTicketUseState, FreeTicketUseScreen> {
  final _adult = TextEditingController(text: '0');
  final _children = TextEditingController(text: '0');
  final _bookingDate = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildState(BuildContext context, FreeTicketUseState state) {
    switch (state) {
      case FreeTicketUseSubmitSuccess():
        showToastSuccess(context, message: "Booking Success");
        pushNamed(Routing.FREE_TICKET_DETAIL,
            arguments: {"free_visit": state.freeVisit});
        //routing to free ticket
        break;
      case FreeTicketUseSubmitError():
        showToastError(context, message: state.error);
        break;

      case FreeTicketUseInitial():
      // TODO: Handle this case.
      case FreeTicketUseSubmitLoading():
      // TODO: Handle this case.
    }

    return SScaffold(
      title: 'Tiket Gratis',
      onBackAction: () {
        Navigator.pop(context);
      },
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: STextField(
                    readOnly: true,
                    controller: _adult,
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    label: 'Dewasa',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SIconButton(
                  disabled: _adult.text == '0',
                  icon: Icons.remove,
                  onPressed: () {
                    setState(() {
                      _adult.text = (int.parse(_adult.text) - 1).toString();
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                SIconButton(
                  disabled: _adult.text == '2',
                  icon: Icons.add,
                  onPressed: () {
                    setState(() {
                      _adult.text = (int.parse(_adult.text) + 1).toString();
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: STextField(
                    readOnly: true,
                    controller: _children,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.numberWithOptions(),
                    label: 'Anak',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SIconButton(
                  disabled: _children.text == '0',
                  icon: Icons.remove,
                  onPressed: () {
                    setState(() {
                      _children.text =
                          (int.parse(_children.text) - 1).toString();
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                SIconButton(
                  disabled: _children.text == '2',
                  icon: Icons.add,
                  onPressed: () {
                    setState(() {
                      _children.text =
                          (int.parse(_children.text) + 1).toString();
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SDateInputField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Masukan tanggal kedatangan';
                }
                return null;
              },
              controller: _bookingDate,
              label: 'Tanggal Booking',
            ),
            const SizedBox(
              height: 32,
            ),
            // const Text(
            //   'Syarat dan Ketentuan:',
            //   style: TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            // _listBullet("•",
            //     'Tiket gratis ini hanya berlaku untuk satu kali kunjungan per tahun.'),
            // _listBullet("•", 'Tiket gratis berlaku untuk 2 dewasa dan 2 anak'),
            // _listBullet("•",
            //     'Tiket tidak dapat dipindahtangankan dan hanya berlaku untuk member terdaftar.'),
            Spacer(),
            SButton(
              loading: state is FreeTicketUseSubmitLoading,
              textStyle: lightText.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              label: 'Gunakan Sekarang',
              buttonStyle: primaryStyleButton,
              onPressed: () {
                if (_children.text == '0' && _adult.text == '0') {
                  showToastError(context,
                      message: "Masukan sedidaknya 1 anak atau dewasa");
                  return;
                } else {
                  if (_formKey.currentState?.validate() ?? false) {
                    stateManagement.pushEvent(FreeTicketUseSubmitEvent(
                        request: FreeTicketRequest(
                      adult: _adult.text,
                      child: _children.text,
                      date: _bookingDate.text,
                    )));
                  }
                }
              },
              suffixIcon: const Icon(
                Icons.arrow_forward_rounded,
                size: 14,
                color: AppColors.textBrandOn,
              ),
            ),
          ],
        ),
      ),
    );
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
  FreeTicketUseInitial get initialData => FreeTicketUseInitial();
}
