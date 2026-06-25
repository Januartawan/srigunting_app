import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/text_field/text_field.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/repository/request/register_request.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/register/bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState
    extends AUIManagement<RegisterBloc, RegisterState, RegisterScreen> {
  var gapTextField = 10.0;
  int currentStep = 0;
  final _idNumberC = TextEditingController();
  final _nameC = TextEditingController();
  final _phoneC = TextEditingController();
  final _passwordC = TextEditingController();
  final _passwordRepeatC = TextEditingController();
  final _usernameC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _idNumberFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _passwordRepeatFocus = FocusNode();
  final _usernameFocus = FocusNode();

  bool _hasShownSuccessToast = false;

  // Step data
  final List<Map<String, dynamic>> _steps = [
    {
      'title': 'Daftar (1/4)',
      'description': 'Masukan Nomor KTP',
      'fields': [
        {
          'controller': '_idNumberC',
          'label': 'Nomor KTP',
          'inputFormatters': [FilteringTextInputFormatter.digitsOnly],
          'keyboardType': TextInputType.numberWithOptions(),
          'validator': (String? value) {
            if (value == null || value.isEmpty) {
              return 'Tolong lengkapi form';
            }
            return null;
          },
        },
      ],
    },
    {
      'title': 'Daftar (2/4)',
      'description': 'Masukan Nama Lengkap Anda (sesuai KTP)',
      'fields': [
        {
          'controller': '_nameC',
          'label': 'Nama Lengkap',
          'validator': (String? value) {
            if (value == null || value.isEmpty) {
              return 'Tolong lengkapi form';
            }
            return null;
          },
        },
        {
          'controller': '_usernameC',
          'label': 'Username',
          'validator': (String? value) {
            if (value == null || value.isEmpty) {
              return 'Tolong lengkapi form';
            }
            return null;
          },
        },
      ],
    },
    {
      'title': 'Daftar (3/4)',
      'description': 'Masukan Nomor WhatsApp Anda (pastikan nomor aktif)',
      'fields': [
        {
          'controller': '_phoneC',
          'label': 'Nomor WhatsApp',
          'inputFormatters': [FilteringTextInputFormatter.digitsOnly],
          'keyboardType': TextInputType.numberWithOptions(),
          'validator': (String? value) {
            if (value == null || value.isEmpty) {
              return 'Tolong lengkapi form';
            }
            if (!value.startsWith('62') && !value.startsWith('0')) {
              return 'Nomor WhatsApp harus diawali dengan 62 atau 0';
            }
            return null;
          },
        },
      ],
    },
    {
      'title': 'Daftar (4/4)',
      'description': 'Buat Password yang Aman dan Pastikan Anda Mengingatnya',
      'fields': [
        {
          'controller': '_passwordC',
          'label': 'Kata Sandi',
          'obscureText': true,
          'validator': (String? value) {
            if (value == null || value.isEmpty) {
              return 'Tolong lengkapi form';
            }
            return null;
          },
        },
        {
          'controller': '_passwordRepeatC',
          'label': 'Konfirmasi Kata Sandi',
          'obscureText': true,
          'validator': (String? value) {
            if (value == null || value.isEmpty) {
              return 'Tolong lengkapi form';
            }
            return null;
          },
        },
      ],
    },
  ];

  TextEditingController _getController(String name) {
    switch (name) {
      case '_idNumberC':
        return _idNumberC;
      case '_nameC':
        return _nameC;
      case '_phoneC':
        return _phoneC;
      case '_passwordC':
        return _passwordC;
      case '_passwordRepeatC':
        return _passwordRepeatC;
      case '_usernameC':
        return _usernameC;
      default:
        throw Exception('Unknown controller: $name');
    }
  }

  FocusNode _getFocusNode(String controllerName) {
    switch (controllerName) {
      case '_idNumberC':
        return _idNumberFocus;
      case '_nameC':
        return _nameFocus;
      case '_phoneC':
        return _phoneFocus;
      case '_passwordC':
        return _passwordFocus;
      case '_passwordRepeatC':
        return _passwordRepeatFocus;
      case '_usernameC':
        return _usernameFocus;
      default:
        throw Exception('Unknown controller: $controllerName');
    }
  }

  void _unfocusAllFields() {
    _idNumberFocus.unfocus();
    _nameFocus.unfocus();
    _phoneFocus.unfocus();
    _passwordFocus.unfocus();
    _passwordRepeatFocus.unfocus();
    _usernameFocus.unfocus();
  }

  void _focusFirstFieldOfStep(int step) {
    final stepData = _steps[step];
    final fields = stepData['fields'] as List;
    if (fields.isNotEmpty) {
      final firstField = fields.first;
      final controllerName = firstField['controller'] as String;
      final focusNode = _getFocusNode(controllerName);
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _idNumberFocus.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _passwordRepeatFocus.dispose();
    _usernameFocus.dispose();
    super.dispose();
  }

  @override
  Widget buildState(BuildContext context, RegisterState state) {
    final step = _steps[currentStep];
    final title = step['title'] as String;
    final description = step['description'] as String;
    final fields = step['fields'] as List;

    switch (state) {
      case RegisterExecuteError():
        showToastError(context, message: state.error);
        _hasShownSuccessToast = false;
        break;
      case RegisterExecuteSuccess():
        if (!_hasShownSuccessToast) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showToastSuccess(context, message: 'Register Successfully');
            showDialog(
              context: context,
              builder: (context) => Dialog(
                insetPadding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SImageSvgAsset(
                        fileName: 'icon_check.svg',
                        height: 56,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Pendaftaran Berhasil',
                        style: darkText.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Temukan jumlah transaksi susuk, jumlah point dan program menarik lainnya',
                        style: darkText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBaseSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      SButton(
                        suffixIcon: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 14,
                          color: AppColors.textBrandOn,
                        ),
                        label: 'Masuk',
                        textStyle: lightText.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        buttonStyle: primaryStyleButton,
                        onPressed: () {
                          Navigator.of(context).pop();
                          pushReplacementNamed(Routing.LOGIN);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
          _hasShownSuccessToast = true;
        }
        break;
      case RegisterInitial():
      case RegisterExecuteLoading():
        _hasShownSuccessToast = false;
        break;
    }

    return SScaffold(
      headerBody: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _handleBackAction,
                  child: const Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: AppColors.textBrandOn,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: lightText.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 26),
                child: Text(
                  description,
                  textAlign: TextAlign.start,
                  style: lightText.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.textBrandOnSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      onBackAction: _handleBackAction,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            ...fields.map<Widget>((field) {
              return Column(
                children: [
                  STextField(
                    // Unique key per field so Flutter does not reuse a
                    // FormFieldState across steps (which would otherwise leak
                    // a previous field's validation error onto another field).
                    key: ValueKey(field['controller'] as String),
                    validator: field['validator'],
                    controller: _getController(field['controller']),
                    label: field['label'],
                    obscureText: field['obscureText'] ?? false,
                    inputFormatters: field['inputFormatters'],
                    keyboardType: field['keyboardType'],
                    focusNode: _getFocusNode(field['controller']),
                  ),
                  if (fields.last != field) SizedBox(height: gapTextField),
                ],
              );
            }).toList(),
            const Spacer(),
            (currentStep == _steps.length - 1)
                ? SButton(
                    loading: state is RegisterExecuteLoading,
                    textStyle: lightText.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w400),
                    suffixIcon: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColors.textBrandOn,
                    ),
                    label: "Register",
                    buttonStyle: primaryStyleButton,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        stateManagement.pushEvent(
                          RegisterExecute(
                            payload: RegisterRequest(
                              nik: num.parse(_idNumberC.text),
                              name: _nameC.text,
                              phoneNumber: _phoneC.text,
                              username: _usernameC.text,
                              password: _passwordC.text,
                              cPassword: _passwordRepeatC.text,
                            ),
                          ),
                        );
                      }
                      // No toast on failure: inline field errors already
                      // explain what is wrong (empty or invalid format).
                    },
                  )
                : SButton(
                    textStyle: lightText.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w400),
                    suffixIcon: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColors.textBrandOn,
                    ),
                    label: "Selanjutnya",
                    buttonStyle: primaryStyleButton,
                    onPressed: () {
                      // Validasi form agar error message muncul di field
                      if (_formKey.currentState?.validate() ?? false) {
                        // Unfocus all fields to reset keyboard type
                        _unfocusAllFields();
                        currentStep++;
                        reBuild();
                        // Refocus the first field of the new step
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _focusFirstFieldOfStep(currentStep);
                        });
                      }
                      // No toast on failure: inline field errors already
                      // explain what is wrong (empty or invalid format).
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void _handleBackAction() {
    if (currentStep == 0) {
      Navigator.pop(context);
    } else {
      // Unfocus all fields to reset keyboard type
      _unfocusAllFields();
      currentStep--;
      reBuild();
      // Refocus the first field of the new step
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusFirstFieldOfStep(currentStep);
      });
    }
  }

  @override
  RegisterState get initialData => RegisterInitial();
}
