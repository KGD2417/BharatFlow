import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bharatflow/pages/home_page.dart';
import 'package:bharatflow/pages/register_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Blur Overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),

          // Login Form
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Username Field
                          CupertinoTextField(
                            controller: _usernameController,
                            placeholder: 'Username',
                            placeholderStyle: const TextStyle(color: Colors.grey),
                            padding: const EdgeInsets.all(16),
                            style: const TextStyle(color: Colors.white),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(CupertinoIcons.person, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password Field
                          CupertinoTextField(
                            controller: _passwordController,
                            placeholder: 'Password',
                            placeholderStyle: const TextStyle(color: Colors.grey),
                            obscureText: _obscurePassword,
                            style: const TextStyle(color: Colors.white),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(CupertinoIcons.lock, color: Colors.grey),
                            ),
                            suffix: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  _obscurePassword
                                      ? CupertinoIcons.eye_slash
                                      : CupertinoIcons.eye,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Sign In Button (Inline Logic with Debugging)
                          CupertinoButton(
                            color: CupertinoColors.systemBlue,
                            borderRadius: BorderRadius.circular(10),
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              final username = _usernameController.text;
                              final password = _passwordController.text;

                              print("Sign In button tapped");
                              print("Username: $username, Password: $password");

                              if (username.isEmpty || password.isEmpty) {
                                print("Validation failed: Missing fields");

                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: const Text('Error'),
                                    content: const Text('Please fill in all fields'),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text('OK'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }

                              print("Validation passed. Navigating to HomePage");

                              Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const MyHomePage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Register Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoButton(
                                padding: const EdgeInsets.only(left: 4),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: CupertinoColors.systemBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const RegisterPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
