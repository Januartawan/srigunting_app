import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';

class RedeemPointDetailScreen extends StatefulWidget {
  const RedeemPointDetailScreen({super.key});

  @override
  State<RedeemPointDetailScreen> createState() =>
      _RedeemPointDetailScreenState();
}

class _RedeemPointDetailScreenState extends State<RedeemPointDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final image = args?['image'] as String?;
    final name = args?['name'] as String?;
    final point = args?['point']?.toString() ?? '0';
    final stock = args?['stock']?.toString() ?? '0';
    return SScaffold(
      title: 'Item Detail',
      onBackAction: () {
        Navigator.pop(context);
      },
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Expanded(
                  child: image != null && image.isNotEmpty
                      ? ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Image.network(
                            image,
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.grey,
                          ),
                          child:
                              Icon(Icons.image, size: 100, color: Colors.white),
                        ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  name ?? '-',
                  style: darkText.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$point Points'),
                    Text('$stock Stock'),
                  ],
                ),
                const Divider(
                  color: AppColors.borderBasePrimary,
                  thickness: 1,
                  height: 20,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text('rest of the text'),
              ],
            ),
          ),
          // SButton(
          //   textStyle: lightText.copyWith(
          //     fontSize: 14,
          //     fontWeight: FontWeight.w400,
          //   ),
          //   label: 'Request Redeem',
          //   buttonStyle: primaryStyleButton,
          //   onPressed: () {
          //     Navigator.pushNamed(context, Routing.LOGIN);
          //   },
          // ),
        ],
      ),
    );
  }
}
