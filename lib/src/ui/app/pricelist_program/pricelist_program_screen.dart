import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/pricelist_program.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/shimmer/shimmer_list.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/pricelist_program/bloc/pricelist_program_bloc.dart';
class PricelistProgramScreen extends StatefulWidget {
  const PricelistProgramScreen({super.key});
  @override
  State<PricelistProgramScreen> createState() => _PricelistProgramScreenState();
}
class _PricelistProgramScreenState extends AUIManagement<PricelistProgramBloc,
    PricelistProgramState, PricelistProgramScreen> {
  String _titleFor(PricelistProgram item) {
    final title = item.title;
    if (title != null && title.trim().isNotEmpty) return title.trim();
    return _titleFromMedia(item.media);
  }
  String _titleFromMedia(String? media) {
    if (media == null || media.trim().isEmpty) return '-';
    final words = media
        .replaceAllMapped(RegExp(r'(?<=[a-z0-9])(?=[A-Z])'), (_) => ' ')
        .split(RegExp(r'[\s_]+'))
        .where((w) => w.isNotEmpty)
        .map((w) => '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');
    return words.isEmpty ? '-' : words;
  }
  @override
  void onStart() {
    stateManagement.pushEvent(PricelistProgramInitialEvent());
    super.onStart();
  }
  @override
  void dispose() {
    stateManagement.dispose();
    super.dispose();
  }
  @override
  Widget buildState(BuildContext context, PricelistProgramState state) {
    if (state is PricelistProgramInitialError) {
      showToastError(context, message: state.error);
    }
    return SScaffold(
      title: 'Pricelist & Program',
      onBackAction: () => Navigator.pop(context),
      body: Column(
        children: [
          Expanded(
            child: switch (state) {
              PricelistProgramInitialLoaded() =>
                _buildGrid(context, state.programs),
              PricelistProgramInitialError() => _buildErrorState(),
              _ => _buildLoadingState(),
            },
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
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
  Widget _buildGrid(BuildContext context, List<PricelistProgram> programs) {
    if (programs.isEmpty) {
      return _buildEmptyState();
    }
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 18,
        crossAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemCount: programs.length,
      itemBuilder: (context, index) {
        final item = programs[index];
        return _PricelistCard(
          title: _titleFor(item),
          imageUrl: item.foto,
          onTap: () => _openDetail(item),
        );
      },
    );
  }
  Widget _buildLoadingState() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 18,
        crossAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const _PricelistCardSkeleton(),
    );
  }
  Widget _buildEmptyState() {
    return const _StateContainer(
      child: _InlineMessage(
        icon: Icons.image_not_supported_outlined,
        message: 'Pricelist & program belum tersedia.',
      ),
    );
  }
  Widget _buildErrorState() {
    return const _StateContainer(
      child: _InlineMessage(
        icon: Icons.error_outline_rounded,
        message: 'Pricelist & program belum dapat dimuat.',
      ),
    );
  }
  void _openDetail(PricelistProgram item) {
    final media = item.media;
    if (media == null || media.isEmpty) return;
    pushNamed(
      Routing.PRICELIST_PROGRAM_DETAIL,
      arguments: {
        'media': media,
        'title': _titleFor(item),
      },
    );
  }
  @override
  PricelistProgramState get initialData => PricelistProgramInitial();
}
class _PricelistCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final VoidCallback onTap;
  const _PricelistCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: darkText.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textBasePrimary,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(18),
              splashColor: AppColors.bgBrandPrimary.withAlpha(20),
              highlightColor: AppColors.bgBrandPrimary.withAlpha(10),
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.bgBaseSecondary,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderBasePrimary),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: (imageUrl == null || imageUrl!.isEmpty)
                          ? const _CardImageError()
                          : Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const SShimmerList(
                                  height: double.infinity,
                                  width: double.infinity,
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const _CardImageError();
                              },
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class _PricelistCardSkeleton extends StatelessWidget {
  const _PricelistCardSkeleton();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(
          child: SizedBox(
            width: 90,
            height: 14,
            child: SShimmerList(height: 14, width: 90),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.bgBaseSecondary,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderBasePrimary),
            ),
            clipBehavior: Clip.antiAlias,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: SShimmerList(
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class _CardImageError extends StatelessWidget {
  const _CardImageError();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgDisabledPrimary,
      alignment: Alignment.center,
      child: const Icon(
        Icons.broken_image_outlined,
        size: 28,
        color: AppColors.iconBaseSecondary,
      ),
    );
  }
}
class _StateContainer extends StatelessWidget {
  final Widget child;
  const _StateContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.bgBasePrimary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderBasePrimary),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: child,
    );
  }
}
class _InlineMessage extends StatelessWidget {
  final IconData icon;
  final String message;
  const _InlineMessage({
    required this.icon,
    required this.message,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 34,
          color: AppColors.iconBaseSecondary,
        ),
        const SizedBox(height: 10),
        Text(
          message,
          textAlign: TextAlign.center,
          style: darkText.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textBaseSecondary,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}