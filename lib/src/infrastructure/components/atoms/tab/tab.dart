import 'package:flutter/cupertino.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/tab/tab_bar.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
class STab extends StatefulWidget {
  final List<String> tabNames;
  final String initTab;
  final Function(String v) onChanged;
  final MainAxisAlignment mainAxisAlignment;
  const STab(
      {super.key,
      required this.tabNames,
      required this.initTab,
      required this.onChanged,
      this.mainAxisAlignment = MainAxisAlignment.start});
  @override
  State<STab> createState() => _STabState();
}
class _STabState extends State<STab> {
  String? currentActiveTab;
  @override
  void initState() {
    currentActiveTab = widget.initTab;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.bgBaseSecondary,
      ),
      child: Row(
        children: List.generate(
          widget.tabNames.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentActiveTab = widget.tabNames[index];
                });
                widget.onChanged(currentActiveTab ?? "");
              },
              child: AppTabBar(
                text: widget.tabNames[index],
                active: currentActiveTab == widget.tabNames[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}