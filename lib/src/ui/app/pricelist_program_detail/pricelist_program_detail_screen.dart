import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/shimmer/shimmer_list.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/ui/app/pricelist_program_detail/bloc/pricelist_program_detail_bloc.dart';

class PricelistProgramDetailScreen extends StatefulWidget {
  final String media;
  final String title;

  const PricelistProgramDetailScreen({
    super.key,
    required this.media,
    required this.title,
  });

  @override
  State<PricelistProgramDetailScreen> createState() =>
      _PricelistProgramDetailScreenState();
}

class _PricelistProgramDetailScreenState extends AUIManagement<
    PricelistProgramDetailBloc,
    PricelistProgramDetailState,
    PricelistProgramDetailScreen> with SingleTickerProviderStateMixin {
  final TransformationController _controller = TransformationController();
  TapDownDetails? _doubleTapDetails;

  late final AnimationController _animController;
  Animation<Matrix4>? _zoomAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..addListener(() {
        if (_zoomAnimation != null) {
          _controller.value = _zoomAnimation!.value;
        }
      });
  }

  @override
  void onStart() {
    stateManagement
        .pushEvent(PricelistProgramDetailInitialEvent(media: widget.media));
    super.onStart();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animController.dispose();
    stateManagement.dispose();
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    final Matrix4 end;
    if (_controller.value != Matrix4.identity()) {
      end = Matrix4.identity();
    } else {
      final position = _doubleTapDetails?.localPosition ?? Offset.zero;
      end = Matrix4.identity()
        ..translateByDouble(-position.dx * 1.5, -position.dy * 1.5, 0, 1)
        ..scaleByDouble(2.5, 2.5, 2.5, 1);
    }
    _zoomAnimation = Matrix4Tween(
      begin: _controller.value,
      end: end,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));
    _animController.forward(from: 0);
  }

  void _resetZoom() {
    _zoomAnimation = Matrix4Tween(
      begin: _controller.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));
    _animController.forward(from: 0);
  }

  @override
  Widget buildState(BuildContext context, PricelistProgramDetailState state) {
    if (state is PricelistProgramDetailInitialError) {
      showToastError(context, message: state.error);
    }

    return SScaffold(
      title: widget.title,
      onBackAction: () => Navigator.pop(context),
      body: Column(
        children: [
          const _ZoomHint(text: 'Ketuk gambar untuk melihat layar penuh'),
          const SizedBox(height: 14),
          Expanded(
            child: switch (state) {
              PricelistProgramDetailInitialLoaded() =>
                _buildImages(context, state.imageUrls),
              PricelistProgramDetailInitialError() => _buildErrorState(),
              _ => _buildLoadingState(),
            },
          ),
          const SizedBox(height: 16),
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

  Widget _buildImages(BuildContext context, List<String> imageUrls) {
    if (imageUrls.isEmpty) {
      return _buildEmptyState();
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.bgBasePrimary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderBasePrimary),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: GestureDetector(
            onTap: () => _openFullImageViewer(context, imageUrls),
            onDoubleTapDown: _handleDoubleTapDown,
            onDoubleTap: _handleDoubleTap,
            child: InteractiveViewer(
              transformationController: _controller,
              minScale: 1.0,
              maxScale: 5.0,
              panEnabled: true,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < imageUrls.length; i++) ...[
                        Image.network(
                          imageUrls[i],
                          width: double.infinity,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const _ImageLoadingPlaceholder();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Padding(
                              padding: EdgeInsets.all(24),
                              child: _InlineMessage(
                                icon: Icons.broken_image_outlined,
                                message: 'Gambar tidak dapat ditampilkan.',
                              ),
                            );
                          },
                        ),
                        if (i != imageUrls.length - 1)
                          const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final zoomed = _controller.value != Matrix4.identity();
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: zoomed ? 1 : 0,
                child: IgnorePointer(
                  ignoring: !zoomed,
                  child: Material(
                    color: Colors.black.withValues(alpha: 0.55),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: _resetZoom,
                      customBorder: const CircleBorder(),
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.zoom_out_map_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgBasePrimary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderBasePrimary),
      ),
      clipBehavior: Clip.antiAlias,
      child: const _ImageLoadingPlaceholder(expanded: true),
    );
  }

  void _openFullImageViewer(BuildContext context, List<String> imageUrls) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _FullImageViewer(imageUrls: imageUrls),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const _StateContainer(
      child: _InlineMessage(
        icon: Icons.image_not_supported_outlined,
        message: 'Detail belum tersedia.',
      ),
    );
  }

  Widget _buildErrorState() {
    return const _StateContainer(
      child: _InlineMessage(
        icon: Icons.error_outline_rounded,
        message: 'Detail belum dapat dimuat.',
      ),
    );
  }

  @override
  PricelistProgramDetailState get initialData =>
      PricelistProgramDetailInitial();
}

class _ZoomHint extends StatelessWidget {
  final String text;

  const _ZoomHint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.bgDisabledPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.touch_app_outlined,
            size: 18,
            color: AppColors.iconBrandPrimary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: darkText.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.iconBrandSecondary,
                height: 1.35,
              ),
            ),
          ),
        ],
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

class _ImageLoadingPlaceholder extends StatelessWidget {
  final bool expanded;

  const _ImageLoadingPlaceholder({this.expanded = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: expanded ? double.infinity : 420,
      child: const Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: SShimmerList(
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Center(
            child: SizedBox(
              width: 34,
              height: 34,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.bgBrandPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FullImageViewer extends StatefulWidget {
  final List<String> imageUrls;

  const _FullImageViewer({required this.imageUrls});

  @override
  State<_FullImageViewer> createState() => _FullImageViewerState();
}

class _FullImageViewerState extends State<_FullImageViewer> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBasePrimary,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.imageUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _FullImagePage(imageUrl: widget.imageUrls[index]);
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.black.withValues(alpha: 0.56),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        customBorder: const CircleBorder(),
                        child: const SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(
                            Icons.close_rounded,
                            color: AppColors.textBrandOn,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    if (widget.imageUrls.length > 1)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.56),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${_currentIndex + 1}/${widget.imageUrls.length}',
                          style: lightText.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FullImagePage extends StatelessWidget {
  final String imageUrl;

  const _FullImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return ColoredBox(
      color: AppColors.bgBasePrimary,
      child: InteractiveViewer(
        minScale: 1,
        maxScale: 5,
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            alignment: Alignment.center,
            filterQuality: FilterQuality.high,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.bgBrandPrimary,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const _FullImageError();
            },
          ),
        ),
      ),
    );
  }
}

class _FullImageError extends StatelessWidget {
  const _FullImageError();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.broken_image_outlined,
            size: 36,
            color: AppColors.iconBaseSecondary,
          ),
          const SizedBox(height: 10),
          Text(
            'Gambar tidak dapat ditampilkan.',
            textAlign: TextAlign.center,
            style: lightText.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textBaseSecondary,
            ),
          ),
        ],
      ),
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
