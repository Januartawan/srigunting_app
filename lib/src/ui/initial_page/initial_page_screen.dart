import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
class InitialPageScreen extends StatefulWidget {
  const InitialPageScreen({super.key});
  @override
  State<InitialPageScreen> createState() => _InitialPageState();
}
class _InitialPageState extends State<InitialPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.centerLeft,
          image: AssetImage(
            'assets/images/srigunting-bird.png',
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SImageAsset(
            fileName: 'bali_bird_park_logo.png',
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 32,
          ),
          Column(
            children: [
              Text(
                "Selamat Datang Member Srigunting",
                style: lightText.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Column(
            children: [
              SButton(
                textStyle: lightText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                label: 'Daftar',
                buttonStyle: primaryStyleButton,
                onPressed: () {
                  Navigator.pushNamed(context, Routing.REGISTER);
                },
              ),
              const SizedBox(
                height: 6,
              ),
              SButton(
                textStyle: darkText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                label: 'Masuk',
                buttonStyle: secondaryStyleButton,
                onPressed: () {
                  Navigator.pushNamed(context, Routing.LOGIN);
                },
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "Image Source: https://www.flickr.com/photos/134744615@N03/38689741430",
                style: lightText.copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}