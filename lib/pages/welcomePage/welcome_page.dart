import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:sampark/config/svgs.dart';

import '../authPage/auth_gate.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SlideActionState> key = GlobalKey();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              height: 130,
              // color: Colors.red,
              // width: 50,
              child: SvgPicture.asset(AssetsSvgs.appIcon),
            ),
            const Text("CHATTY",
                style: TextStyle(
                    fontFamily: 'SofadiOne',
                    fontSize: 50,
                    color: Color.fromARGB(255, 188, 85, 202))),
            const SizedBox(
              height: 70,
            ),
            Wrap(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  // padding: EdgeInsets.only(top: 30),
                  height: 100,
                  // color: Colors.red,
                  width: 100,
                  child: SvgPicture.asset(
                    AssetsSvgs.boyIcon2,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 80,
                  // color: Colors.red,
                  width: 80,
                  child: SvgPicture.asset(
                    AssetsSvgs.connectIcon,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  // padding: EdgeInsets.only(top: 30),
                  height: 100,
                  // color: Colors.red,
                  width: 100,
                  child: SvgPicture.asset(
                    AssetsSvgs.girlIcon,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Column(
              children: [
                Text("You Are Now",
                    style: TextStyle(
                        fontSize: 32, color: Color.fromARGB(255, 63, 79, 87))),
                Text("Connected",
                    style: TextStyle(
                        // fontFamily: 'SofadiOne',
                        fontSize: 25,
                        color: Color.fromARGB(255, 188, 85, 202),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 18),
                  child: Text(
                      textAlign: TextAlign.center,
                      "Chat with your friends, family and share photos and videos fast with high quality.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 63, 79, 87),
                      )),
                ),
              ],
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SlideAction(
              key: key,
              onSubmit: () {
                // return null;
                _completeWelcome();
                Get.to(() => const AuthGate());
                return null;
                // Future.delayed(
                //   Duration(seconds: 1),
                //   () => _key.currentState!.reset(),
                // );
              },
              innerColor: Colors.transparent,
              outerColor: const Color.fromARGB(255, 168, 72, 147),
              text: "Slide To CHATTY",
              textStyle: TextStyle(color: Colors.grey[300], fontSize: 20),
              sliderButtonIcon: SvgPicture.asset(
                AssetsSvgs.appIcon,
                // fit: BoxFit.cover,
                height: 50,
              ),
              sliderButtonIconPadding: 16,
              sliderRotate: false,
              submittedIcon: Icon(Icons.done_all, color: Colors.pink[100]),
            ),
          ),
        ],
      ),
    )));
  }

    Future<void> _completeWelcome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }
}
