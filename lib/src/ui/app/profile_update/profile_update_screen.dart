import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/date/input_date.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/text_field/text_field.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/repository/request/register_request.dart';
import 'package:srigunting_app/src/ui/app/profile_update/bloc/profile_update_bloc.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/select_field.dart';
import 'package:srigunting_app/src/domain/atribute.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final Guide guide;

  const ProfileUpdateScreen({super.key, required this.guide});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends AUIManagement<ProfileUpdateBloc,
    ProfileUpdateState, ProfileUpdateScreen> {
  List<Atribute> dataReligion = [];
  List<Atribute> dataGender = [];
  Atribute? selectedReligion;
  Atribute? selectedGender;

  bool isReligionInitialized = false;
  bool isGenderInitialized = false;

  final nikC = TextEditingController();
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final dateOfBirthC = TextEditingController();
  final addressC = TextEditingController();
  final religionC = TextEditingController();
  final genderC = TextEditingController();

  @override
  void onStart() {
    stateManagement.pushEvent(ProfileUpdateInitialEvent());
    nikC.text = widget.guide.nik.toString();
    nameC.text = widget.guide.name ?? '';
    emailC.text = widget.guide.email ?? '';
    phoneC.text = widget.guide.phonenumber.toString();
    dateOfBirthC.text = widget.guide.birthDate?.toString() ?? '';
    addressC.text = widget.guide.address ?? '';
    religionC.text = widget.guide.religion ?? '';
    genderC.text = widget.guide.gender ?? '';
    super.onStart();
  }

  @override
  Widget buildState(BuildContext context, ProfileUpdateState state) {
    switch (state) {
      case ProfileUpdateExecuteSuccess():
        showToastSuccess(context, message: "Update Profile Success");
        Future.microtask(() {
          Navigator.pop(context, true);
        });
        break;
      case ProfileUpdateInitialLoaded():
        dataReligion = state.religions;
        dataGender = state.genders;
        // Set selectedReligion/selectedGender dari state jika ada, jika tidak dari widget.guide
        final selectedReligionId =
            state.selectedReligion ?? widget.guide.religion;
        if (!isReligionInitialized &&
            selectedReligionId != null &&
            selectedReligionId.isNotEmpty) {
          final found = dataReligion
              .where((e) =>
                  e.name == selectedReligionId || e.id == selectedReligionId)
              .toList();
          if (found.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                selectedReligion = found.first;
                religionC.text = found.first.name;
                isReligionInitialized = true;
              });
            });
          }
        }
        final selectedGenderId = state.selectedGender ?? widget.guide.gender;
        if (!isGenderInitialized &&
            selectedGenderId != null &&
            selectedGenderId.isNotEmpty) {
          final found = dataGender
              .where(
                  (e) => e.name == selectedGenderId || e.id == selectedGenderId)
              .toList();
          if (found.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                selectedGender = found.first;
                genderC.text = found.first.name;
                isGenderInitialized = true;
              });
            });
          }
        }
        break;
      case ProfileUpdateExecuteError():
        showToastError(context, message: state.error);
        break;
      default:
    }

    return SScaffold(
      title: 'Edit Data Diri',
      onBackAction: () {
        Navigator.pop(context);
      },
      body: ListView(
        padding: EdgeInsets.only(
          bottom: 24,
        ),
        children: [
          STextField(
            controller: nikC,
            label: "Nomor KTP",
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          const SizedBox(
            height: 12,
          ),
          STextField(
            controller: nameC,
            label: "Nama Lengkap",
          ),
          const SizedBox(
            height: 12,
          ),
          STextField(
            controller: phoneC,
            label: "Nomor WhatsApp",
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          const SizedBox(
            height: 12,
          ),
          SDateInputField(
            controller: dateOfBirthC,
            label: "Tanggal Lahir",
          ),
          const SizedBox(
            height: 12,
          ),
          STextField(
            controller: addressC,
            label: "Alamat",
          ),
          const SizedBox(
            height: 12,
          ),
          SSelectField<Atribute>(
            label: "Agama",
            value: selectedReligion,
            items: dataReligion
                .map((e) => DropdownMenuItem<Atribute>(
                      value: e,
                      child: Text(e.name ?? '-', style: darkText),
                    ))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedReligion = val;
                religionC.text = val?.name ?? '';
              });
              // Optionally, dispatch event to bloc if you want to keep state in sync
              // context.read<ProfileUpdateBloc>().add(ProfileUpdateReligionChangedEvent(religionId: val?.id));
            },
            hint: "Pilih Agama",
          ),
          const SizedBox(
            height: 12,
          ),
          SSelectField<Atribute>(
            label: "Jenis Kelamin",
            value: selectedGender,
            items: dataGender
                .map((e) => DropdownMenuItem<Atribute>(
                      value: e,
                      child: Text(e.name ?? '-', style: darkText),
                    ))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedGender = val;
                genderC.text = val?.name ?? '';
              });
              // Optionally, dispatch event to bloc if you want to keep state in sync
              // context.read<ProfileUpdateBloc>().add(ProfileUpdateGenderChangedEvent(genderId: val?.id));
            },
            hint: "Pilih Jenis Kelamin",
          ),
          const SizedBox(height: 24),
          SButton(
            loading: state is ProfileUpdateExecuteLoading,
            textStyle: lightText.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: const Icon(
              Icons.save_outlined,
              size: 14,
              color: AppColors.textBrandOn,
            ),
            label: "Simpan",
            buttonStyle: primaryStyleButton,
            onPressed: () {
              stateManagement.pushEvent(
                ProfileUpdateExecuteEvent(
                  payload: RegisterRequest(
                    // id: widget.guide.id,
                    nik: num.tryParse(nikC.text),
                    name: nameC.text,
                    phoneNumber: phoneC.text,
                    birthDate: dateOfBirthC.text.trim().isNotEmpty
                        ? DateTime.tryParse(dateOfBirthC.text)
                        : null,
                    address: addressC.text,
                    religion: selectedReligion?.id,
                    gender: selectedGender?.id,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement initialData
  ProfileUpdateState get initialData => ProfileUpdateInitial();
}
