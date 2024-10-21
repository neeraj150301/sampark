import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../config/svgs.dart';
import '../../controller/auth_service.dart';
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

  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  final AuthService loginController =
      Get.put(AuthService()); // Initialize controller

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
                padding: const EdgeInsets.only(top: 60),
                height: MediaQuery.of(context).size.height / 3.5,
                child: SvgPicture.asset(
                  AssetsSvgs.appIcon,
                  height: 60,
                  // color: Theme.of(context).colorScheme.primary,
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Theme.of(context).colorScheme.surface.withOpacity(0.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                      width: 2, color: Theme.of(context).colorScheme.tertiary),
                ),
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      indicatorWeight: 4,
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.secondary,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      tabs: const [
                        Tab(text: "Login"),
                        Tab(text: "Sign Up"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildLoginTab(context),
                          _buildSignUpTab(context),
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

  Widget _buildLoginTab(BuildContext context) {
    print(loginController.loading.value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Form(
        key: _loginFormKey,
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
              text: loginController.loading.value
                  ? const CircularProgressIndicator()
                  : Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(1),
                        letterSpacing: 1.2,
                      ),
                    ),
              onPressed: () {
                if (_loginFormKey.currentState!.validate()) {
                  if (_loginEmailController.text.isNotEmpty &&
                      _loginPasswordController.text.isNotEmpty) {
                    login(context);
                  }
                }
                //  else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text("Please fix the errors.")),
                //   );
                // }
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New to CHATTY?  ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                GestureDetector(
                  onTap: () => toogleLoginSignUp(),
                  child: Text(
                    "Sign Up Now",
                    style: TextStyle(
                        fontSize: 15,
                        // decoration: TextDecoration.underline,
                        // decorationStyle: TextDecorationStyle.dashed,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Form(
          key: _signUpFormKey,
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
                text: loginController.loading.value
                    ? const CircularProgressIndicator()
                    : Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(1),
                          letterSpacing: 1.2,
                        ),
                      ),
                onPressed: () {
                  if (_signUpFormKey.currentState!.validate()) {
                    signUp(context);
                  }
                  //  else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text("Please fix the errors.")),
                  //   );
                  // }
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?  ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  GestureDetector(
                    onTap: () => toogleLoginSignUp(),
                    child: Text(
                      "Login Now",
                      style: TextStyle(
                          fontSize: 15,
                          // decoration: TextDecoration.underline,
                          // decorationStyle: TextDecorationStyle.dashed,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
        _loginEmailController.text.trim(),
        _loginPasswordController.text.trim(),
        context,
      );
    } catch (e) {
      // Handle any other type of exception
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void signUp(BuildContext context) async {
    final authService = AuthService();
    if (_signupPasswordController.text ==
        _signupConfirmPasswordController.text) {
      try {
        await authService.signUpWithEmailAndPassword(
          _signupEmailController.text,
          _signupPasswordController.text,
          context,
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Text("Passwords doesn't match!"),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

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
