import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/model/onboard.dart';
import 'package:ai_assistant/screen/home_screen.dart';
import 'package:ai_assistant/widget/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();
    final list = [
      Onboard(
          title: 'Ask me Anything',
          subtitle:
              'I can be your Best Friend & You can ask me anythign & I will help you !',
          lottie: 'ai_ask_me'),
      Onboard(
        title: 'Imagination to Reality',
        lottie: 'ai_play',
        subtitle:
            'Just Imagine anything & let me know, I will create something wonderful for you!',
      ),
    ];

    return Scaffold(
        body: PageView.builder(
            controller: c,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final isLast = index == list.length - 1;
              return Column(
                children: [
                  Lottie.asset('assets/lottie/${list[index].lottie}.json',
                      height: mq.height * .6,
                      width: isLast ? mq.width * .7 : null),
                  Text(
                    list[index].title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5),
                  ),
                  SizedBox(
                    height: mq.height * .015,
                  ),
                  SizedBox(
                    width: mq.width * .7,
                    child: Text(
                      list[index].subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13.5,
                          letterSpacing: 0.5,
                          color: Theme.of(context).lightTextColor),
                    ),
                  ),

                  const Spacer(),

                  // dots
                  Wrap(
                      spacing: 10,
                      children: List.generate(
                          list.length,
                          (i) => Container(
                              width: i == index ? 15 : 10,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: i == index ? Colors.blue : Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)))))),
                  const Spacer(),
                  // Button
                  CustomBtn(
                      onTap: () {
                        if (isLast) {
                          Get.off(() => const HomeScreen());
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //         builder: (_) => const HomeScreen()));
                        } else {
                          c.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.ease);
                        }
                      },
                      text: isLast ? 'Finish' : 'Next'),
                  const Spacer(flex: 2),
                ],
              );
            }));
  }
}
