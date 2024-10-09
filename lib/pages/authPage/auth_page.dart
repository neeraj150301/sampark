import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/svgs.dart';
import '../../widget/my_button.dart';
import '../../widget/my_text_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _signupPasswordController =
      TextEditingController();
  final TextEditingController _signupConfirmPasswordController =
      TextEditingController();
  bool showLogin = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _signupConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height / 3,
                child: SvgPicture.asset(
                  AssetsSvgs.appIcon,
                  height: 60,
                  color: Theme.of(context).colorScheme.primary,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.tertiary)),
                height: 450,
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: "Login"),
                        Tab(text: "Sign Up"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildLoginTab(),
                          _buildSignUpTab(),
                        ],
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

  Widget _buildLoginTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(
            hintText: "Enter Email",
            obscureText: false,
            controller: _loginEmailController,
          ),
          const SizedBox(height: 10),
          MyTextField(
            hintText: "Enter Password",
            obscureText: true,
            controller: _loginPasswordController,
          ),
          const SizedBox(height: 18),
          MyButton(
            text: "Login",
            // style: TextStyle(
            //         fontSize: 15,

            //           decoration: TextDecoration.underline,
            //           decorationStyle: TextDecorationStyle.dashed,
            //           fontWeight: FontWeight.bold,
            //           color: Theme.of(context).colorScheme.primary),
            onPressed: () => login(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New to CHATTY? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: () => toogleLoginSignUp(),
                child: Text(
                  "Sign Up Now",
                  style: TextStyle(
                    fontSize: 15,

                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSignUpTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(
            hintText: "Enter Email",
            obscureText: false,
            controller: _signupEmailController,
          ),
          const SizedBox(height: 10),
          MyTextField(
            hintText: "Enter Password",
            obscureText: true,
            controller: _signupPasswordController,
          ),
          const SizedBox(height: 10),
          MyTextField(
            hintText: "Confirm Password",
            obscureText: true,
            controller: _signupConfirmPasswordController,
          ),
          const SizedBox(height: 18),
          MyButton(
            text: "Sign Up",
            onPressed: () => signUp(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: () => toogleLoginSignUp(),
                child: Text(
                  "Login Now",
                  style: TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void login() {}

  void signUp() {}
  void toogleLoginSignUp() {
    showLogin = !showLogin;
    if (showLogin) {
      setState(() {
        _tabController.index = 0;
      });
    } else {
      setState(() {
        _tabController.index = 1;
      });
    }
  }
}
