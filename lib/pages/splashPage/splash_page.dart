import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/svgs.dart';
import '../authPage/auth_gate.dart';
import '../welcomePage/welcome_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return isFirstTime ? const WelcomePage() : const AuthGate();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height / 2,
            child: SvgPicture.asset(
              AssetsSvgs.appIcon,
              height: 80,
              // color: Theme.of(context).colorScheme.primary,
            )),
        const Center(
          child: Text(
            "Made with 💖",
            style: TextStyle(fontSize: 16, letterSpacing: 1.5),
          ),
        )
      ]),
    );
  }
}
