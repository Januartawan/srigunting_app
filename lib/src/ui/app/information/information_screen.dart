import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/information.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/information/bloc/information_bloc.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends AUIManagement<InformationBloc,
    InformationState, InformationScreen> {
  List<Information> informations = [];
  Pagination<Information>? pagination;
  bool isLoadingMore = false;
  int currentPage = 1;

  @override
  void onStart() {
    stateManagement.pushEvent(InformationInitialEvent());
    super.onStart();
  }

  @override
  Widget buildState(BuildContext context, InformationState state) {
    switch (state) {
      case InformationInitialLoaded():
        informations = state.dataInformation;
        pagination = state.pagination;
        currentPage = 1;
        isLoadingMore = false;
      case InformationLoadMoreLoading():
        isLoadingMore = true;
      case InformationLoadMoreLoaded():
        informations.addAll(state.dataInformation);
        pagination = state.pagination;
        isLoadingMore = false;
      case InformationLoadMoreError():
        isLoadingMore = false;
        showToastError(context, message: state.error);
      case InformationInitialError():
        showToastError(context, message: state.error);
        break;
      default:
    }

    return SScaffold(
      title: 'Informasi',
      onBackAction: () => Navigator.pop(context),
      body: _buildMenu(context),
    );
  }

  Widget _buildMenu(BuildContext context) {
    final items = <_InfoMenuData>[
      _InfoMenuData(
        label: 'Skema Susuk',
        description: 'Pelajari skema dan ketentuan susuk',
        icon: Icons.assignment_outlined,
        onTap: () => pushNamed(Routing.SKEMA_SUSUK),
      ),
      _InfoMenuData(
        label: 'Flow Klaim Susuk & Meal',
        description: 'Alur pengajuan klaim susuk dan meal',
        icon: Icons.account_tree_outlined,
        onTap: () => pushNamed(Routing.FLOW_KLAIM),
      ),
      _InfoMenuData(
        label: 'Hubungi Kami',
        description: 'Customer service siap membantu Anda',
        icon: Icons.support_agent_outlined,
        onTap: () => pushNamed(Routing.CONTACT_US),
      ),
      _InfoMenuData(
        label: 'Kritik & Saran',
        description: 'Bantu kami menjadi lebih baik',
        icon: Icons.chat_bubble_outline,
        onTap: () => pushNamed(Routing.FEEDBACK),
      ),
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionHeader(),
          const SizedBox(height: 20),
          for (int i = 0; i < items.length; i++) ...[
            _InfoMenuTile(data: items[i]),
            if (i != items.length - 1) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }

  @override
  InformationState get initialData => InformationInitial();
}

class _SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pusat Informasi',
          style: darkText.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Temukan panduan, layanan, dan saluran komunikasi kami.',
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

class _InfoMenuData {
  final String label;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _InfoMenuData({
    required this.label,
    required this.description,
    required this.icon,
    required this.onTap,
  });
}

class _InfoMenuTile extends StatelessWidget {
  final _InfoMenuData data;

  const _InfoMenuTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: AppColors.bgBrandPrimary.withOpacity(0.08),
        highlightColor: AppColors.bgBrandPrimary.withOpacity(0.04),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.bgBasePrimary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderBasePrimary),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bgDisabledPrimary,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    data.icon,
                    size: 26,
                    color: AppColors.iconBrandPrimary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.label,
                        style: darkText.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textBasePrimary,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.description,
                        style: darkText.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBaseSecondary,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bgBaseSecondary,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: AppColors.iconBaseSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
