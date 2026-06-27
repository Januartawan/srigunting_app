import 'package:flutter/material.dart' hide Feedback;
import 'package:srigunting_app/src/domain/feedback.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/shimmer/shimmer_list.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/text_field/text_field.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/ui/app/feedback/bloc/feedback_bloc.dart';
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}
class _FeedbackScreenState
    extends AUIManagement<FeedbackBloc, FeedbackState, FeedbackScreen> {
  static const _categories = <_FeedbackCategory>[
    _FeedbackCategory(key: 'susuk', label: 'Susuk'),
    _FeedbackCategory(key: 'pelayanan', label: 'Pelayanan'),
    _FeedbackCategory(key: 'other', label: 'Lain-lain'),
  ];
  final Map<String, int> _ratings = {};
  final Map<String, TextEditingController> _controllers = {
    for (final c in _categories) c.key: TextEditingController(),
  };
  bool _submitting = false;
  bool _prefilled = false;
  final Set<String> _locked = {};
  @override
  void onStart() {
    stateManagement.pushEvent(FeedbackInitialEvent());
    super.onStart();
  }
  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    stateManagement.dispose();
    super.dispose();
  }
  void _prefill(Feedback feedback) {
    if (_prefilled) return;
    _prefilled = true;
    void apply(String key, String? rating, String? message) {
      final parsed = int.tryParse(rating ?? '');
      var hasData = false;
      if (parsed != null && parsed >= 1 && parsed <= 5) {
        _ratings[key] = parsed;
        hasData = true;
      }
      if (message != null && message.trim().isNotEmpty) {
        _controllers[key]!.text = message;
        hasData = true;
      }
      if (hasData) _locked.add(key);
    }
    apply('susuk', feedback.ratingSusuk, feedback.messageSusuk);
    apply('pelayanan', feedback.ratingPelayanan, feedback.messagePelayanan);
    apply('other', feedback.ratingOther, feedback.messageOther);
  }
  void _onSubmit() {
    final filled = _categories.where((c) =>
        !_locked.contains(c.key) &&
        (_ratings[c.key] != null ||
            _controllers[c.key]!.text.trim().isNotEmpty));
    if (filled.isEmpty) {
      showToastInfo(context, message: 'Mohon isi minimal satu kategori');
      return;
    }
    final feedback = Feedback(
      ratingSusuk: _ratings['susuk']?.toString(),
      messageSusuk: _textOrNull('susuk'),
      ratingPelayanan: _ratings['pelayanan']?.toString(),
      messagePelayanan: _textOrNull('pelayanan'),
      ratingOther: _ratings['other']?.toString(),
      messageOther: _textOrNull('other'),
    );
    stateManagement.pushEvent(FeedbackSubmitEvent(feedback: feedback));
  }
  String? _textOrNull(String key) {
    final text = _controllers[key]!.text.trim();
    return text.isEmpty ? null : text;
  }
  @override
  Widget buildState(BuildContext context, FeedbackState state) {
    if (state is FeedbackInitialLoaded) {
      _prefill(state.feedback);
    }
    if (state is FeedbackSubmitLoading) {
      _submitting = true;
    } else {
      _submitting = false;
    }
    if (state is FeedbackSubmitSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        showToastSuccess(this.context, message: 'Terima kasih atas masukan Anda');
        Navigator.pop(this.context);
      });
    }
    if (state is FeedbackSubmitError) {
      showToastError(context, message: state.error);
    }
    if (state is FeedbackInitialError) {
      showToastError(context, message: state.error);
    }
    final isLoading = state is FeedbackInitialLoading || state is FeedbackInitial;
    return SScaffold(
      title: 'Kritik & Saran',
      onBackAction: () => Navigator.pop(context),
      body: isLoading
          ? _buildLoadingState()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(),
                  const SizedBox(height: 20),
                  for (int i = 0; i < _categories.length; i++) ...[
                    _FeedbackCard(
                      category: _categories[i],
                      rating: _ratings[_categories[i].key],
                      controller: _controllers[_categories[i].key]!,
                      locked: _locked.contains(_categories[i].key),
                      onRatingChanged: (value) {
                        setState(
                            () => _ratings[_categories[i].key] = value);
                      },
                    ),
                    if (i != _categories.length - 1)
                      const SizedBox(height: 16),
                  ],
                  const SizedBox(height: 28),
                  SButton(
                    loading: _submitting,
                    textStyle: lightText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: const Icon(
                      Icons.send_rounded,
                      size: 14,
                      color: AppColors.textBrandOn,
                    ),
                    label: 'Kirim',
                    buttonStyle: primaryStyleButton,
                    onPressed: _submitting ? null : _onSubmit,
                  ),
                  const SizedBox(height: 12),
                  SButton(
                    textStyle: lightText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 14,
                      color: AppColors.textBrandOn,
                    ),
                    label: 'Kembali',
                    buttonStyle: primaryStyleButton,
                    onPressed:
                        _submitting ? null : () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
    );
  }
  Widget _buildLoadingState() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(),
          const SizedBox(height: 20),
          for (int i = 0; i < _categories.length; i++) ...[
            const _FeedbackCardSkeleton(),
            if (i != _categories.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
  @override
  FeedbackState get initialData => FeedbackInitial();
}
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bantu kami menjadi lebih baik',
          style: darkText.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Berikan penilaian dan masukan Anda untuk setiap kategori di bawah.',
          style: darkText.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.textBaseSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
class _FeedbackCategory {
  final String key;
  final String label;
  const _FeedbackCategory({required this.key, required this.label});
}
class _FeedbackCard extends StatelessWidget {
  final _FeedbackCategory category;
  final int? rating;
  final TextEditingController controller;
  final ValueChanged<int> onRatingChanged;
  final bool locked;
  const _FeedbackCard({
    required this.category,
    required this.rating,
    required this.controller,
    required this.onRatingChanged,
    this.locked = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.bgBasePrimary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderBasePrimary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.bgBrandPrimary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                category.label,
                style: darkText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (locked) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bgBrandPrimary.withAlpha(31),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 13,
                        color: AppColors.bgBrandPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Terkirim',
                        style: darkText.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bgBrandPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          _RatingRow(
            value: rating,
            onChanged: onRatingChanged,
            enabled: !locked,
          ),
          if (rating != null) ...[
            const SizedBox(height: 8),
            Text(
              _ratingLabel(rating!),
              style: darkText.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _ratingColor(rating!),
              ),
            ),
          ],
          const SizedBox(height: 14),
          STextField(
            controller: controller,
            label: '',
            hintText: 'Ketik disini...',
            maxLines: 3,
            enabled: !locked,
          ),
        ],
      ),
    );
  }
  String _ratingLabel(int value) {
    switch (value) {
      case 1:
        return 'Sangat Buruk';
      case 2:
        return 'Buruk';
      case 3:
        return 'Cukup';
      case 4:
        return 'Baik';
      case 5:
        return 'Sangat Baik';
      default:
        return '';
    }
  }
  Color _ratingColor(int value) {
    switch (value) {
      case 1:
        return const Color(0xFFE53935);
      case 2:
        return const Color(0xFFFB8C00);
      case 3:
        return const Color(0xFFFDD835);
      case 4:
        return const Color(0xFF7CB342);
      case 5:
        return const Color(0xFF43A047);
      default:
        return AppColors.textBaseSecondary;
    }
  }
}
class _RatingRow extends StatelessWidget {
  final int? value;
  final ValueChanged<int> onChanged;
  final bool enabled;
  const _RatingRow({
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });
  static const _options = <_RatingOption>[
    _RatingOption(
      icon: Icons.sentiment_very_dissatisfied_rounded,
      color: Color(0xFFE53935),
    ),
    _RatingOption(
      icon: Icons.sentiment_dissatisfied_rounded,
      color: Color(0xFFFB8C00),
    ),
    _RatingOption(
      icon: Icons.sentiment_neutral_rounded,
      color: Color(0xFFFDD835),
    ),
    _RatingOption(
      icon: Icons.sentiment_satisfied_rounded,
      color: Color(0xFF7CB342),
    ),
    _RatingOption(
      icon: Icons.sentiment_very_satisfied_rounded,
      color: Color(0xFF43A047),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < _options.length; i++)
          _RatingDot(
            option: _options[i],
            selected: value == i + 1,
            enabled: enabled,
            onTap: enabled ? () => onChanged(i + 1) : null,
          ),
      ],
    );
  }
}
class _RatingOption {
  final IconData icon;
  final Color color;
  const _RatingOption({required this.icon, required this.color});
}
class _RatingDot extends StatelessWidget {
  final _RatingOption option;
  final bool selected;
  final VoidCallback? onTap;
  final bool enabled;
  const _RatingDot({
    required this.option,
    required this.selected,
    required this.onTap,
    this.enabled = true,
  });
  @override
  Widget build(BuildContext context) {
    final unselectedOpacity = enabled ? 140 : 64;
    final unselectedBgOpacity = enabled ? 31 : 15;
    final Color iconColor =
        selected ? Colors.white : option.color.withAlpha(unselectedOpacity);
    final Color bgColor = selected
        ? option.color
        : option.color.withAlpha(unselectedBgOpacity);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
            border: Border.all(
              color: selected ? option.color : Colors.transparent,
              width: 2,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: option.color.withAlpha(89),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Icon(
            option.icon,
            size: 26,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
class _FeedbackCardSkeleton extends StatelessWidget {
  const _FeedbackCardSkeleton();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.bgBasePrimary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderBasePrimary),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SShimmerList(height: 18, width: 120),
          SizedBox(height: 16),
          SShimmerList(height: 44, width: double.infinity),
          SizedBox(height: 14),
          SShimmerList(height: 70, width: double.infinity),
        ],
      ),
    );
  }
}