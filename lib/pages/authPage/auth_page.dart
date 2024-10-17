import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              text: "Login",
              onPressed: () {
                if (_loginFormKey.currentState!.validate()) {
                  if (_loginEmailController.text.isNotEmpty &&
                      _loginPasswordController.text.isNotEmpty) {
                    login();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fix the errors.")),
                  );
                }
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

  Widget _buildSignUpTab() {
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
                text: "Sign Up",
                onPressed: () {
                  if (_signUpFormKey.currentState!.validate()) {
                    signUp();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fix the errors.")),
                    );
                  }
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

  void login() async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
        _loginEmailController.text.trim(),
        _loginPasswordController.text.trim(),
      );
    } catch (e) {
      String errorMessage;
      switch (e.toString()) {
        case 'wrong-password':
          errorMessage = 'The password is incorrect.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text(errorMessage),
        ),
      );
    }
  }

  void signUp() async {
    final authService = AuthService();
    if (_signupPasswordController.text ==
        _signupConfirmPasswordController.text) {
      try {
        await authService.signUpWithEmailAndPassword(
          _signupEmailController.text,
          _signupPasswordController.text,
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password don't match!")),
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
