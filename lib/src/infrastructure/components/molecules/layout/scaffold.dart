import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

typedef void BackAction();

class SScaffold extends StatefulWidget {
  final Widget body;
  final String? title;
  final String? subtitle;
  final BackAction? onBackAction;
  final Widget? headerBody;
  final double? height;
  final Decoration? bgDecoration;
  final bool? fullHeight;
  final EdgeInsets? bodyPadding;

  const SScaffold(
      {super.key,
      required this.body,
      this.title,
      this.subtitle,
      this.onBackAction,
      this.headerBody,
      this.height,
      this.bgDecoration,
      this.fullHeight = false,
      this.bodyPadding});

  @override
  State<SScaffold> createState() => _SScaffoldState();
}

class _SScaffoldState extends State<SScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (widget.title != null ||
              widget.subtitle != null ||
              widget.onBackAction != null ||
              widget.headerBody != null)
            Container(
              height: widget.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.bgBrandTeritaryInvert,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: -110,
                    top: -90,
                    child: SImageSvgAsset(
                      fileName: 'bali_bird_park_mark.svg',
                      height: 400,
                      colorFilter: ColorFilter.mode(
                        AppColors.bgBrandPrimary.withOpacity(0.2),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SafeArea(
                    top: true,
                    bottom: false,
                    child: widget.headerBody != null
                        ? Container(
                            child: widget.headerBody,
                          )
                        : Container(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    if (widget.onBackAction != null) ...[
                                      GestureDetector(
                                        onTap: widget.onBackAction,
                                        child: const Icon(
                                          Icons.arrow_back,
                                          size: 20,
                                          color: AppColors.textBrandOn,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                    ],
                                    Text(
                                      widget.title ?? '',
                                      style: lightText.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                                if (widget.subtitle != null &&
                                    widget.subtitle!.isNotEmpty) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    widget.subtitle ?? '',
                                    style: lightText.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.textBrandOnSecondary,
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),

          // Container(
          //   width: double.infinity,
          //   padding: EdgeInsets.all(24),
          //   decoration: BoxDecoration(
          //     color: AppColors.bgBrandTeritaryInvert,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(16),
          //       bottomRight: Radius.circular(16),
          //     ),
          //   ),
          //   child: Container(
          //     child: Column(
          //       children: [
          //         Row(
          //           children: [
          //             if (widget.onBackAction != null) ...[
          //               GestureDetector(
          //                 onTap: widget.onBackAction,
          //                 child: Icon(
          //                   Icons.arrow_back,
          //                   size: 20,
          //                   color: AppColors.textBrandOn,
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: 6,
          //               ),
          //             ],
          //             Text(
          //               widget.title ?? '',
          //               style: lightText.copyWith(
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 20,
          //               ),
          //             )
          //           ],
          //         ),
          //         if (widget.subtitle != null &&
          //             widget.subtitle!.isNotEmpty) ...[
          //           SizedBox(height: 12),
          //           Text(
          //             widget.subtitle ?? '',
          //             style: lightText.copyWith(
          //               fontWeight: FontWeight.w400,
          //               fontSize: 14,
          //               color: AppColors.textBrandOnSecondary,
          //             ),
          //           )
          //         ]
          //       ],
          //     ),
          //   ),
          // ),

          // Content of the page
          Expanded(
            child: Container(
              decoration: widget.bgDecoration,
              padding: widget.bodyPadding ??
                  EdgeInsets.fromLTRB(
                    24,
                    24,
                    24,
                    widget.fullHeight == true ? 0 : 24,
                  ),
              child: widget.body,
            ),
          )
        ],
      ),
    );
  }
}
