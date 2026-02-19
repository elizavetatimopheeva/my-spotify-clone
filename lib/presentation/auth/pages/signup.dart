import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/common/widgets/button/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class SighUpOrSingIn extends StatelessWidget {
  const SighUpOrSingIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          AspectRatio(
            aspectRatio: 195 / 433,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(AppImages.authBG),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 175),
                Flexible(flex: 71, child: SvgPicture.asset(AppVectors.logo)),
                // const SizedBox(height: 55),
                const Spacer(flex: 55),
                const Flexible(
                  flex: 35,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Enjoy Listening To Music",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        height: 35 / 24,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 21),
                // const SizedBox(height: 21),
                const Text(
                  "Spotify is a proprietary Swedish audio streaming and media services provider ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                // const SizedBox(height: 30),
                const Spacer(flex: 30),
                Flexible(
                  flex: 73,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: () {},
                          title: "Register",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 338),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
