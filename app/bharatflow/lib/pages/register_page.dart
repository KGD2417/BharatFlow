import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bharatflow/pages/SignIn.dart';
import 'package:bharatflow/pages/home_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Blur
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_bg.png',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),

          // Main Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Username Field
                          CupertinoTextField(
                            controller: _usernameController,
                            placeholder: 'Username',
                            placeholderStyle: const TextStyle(color: Colors.grey),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade700),
                            ),
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(CupertinoIcons.person, color: Colors.grey),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 16),

                          // Email Field
                          CupertinoTextField(
                            controller: _emailController,
                            placeholder: 'Email',
                            placeholderStyle: const TextStyle(color: Colors.grey),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade700),
                            ),
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(CupertinoIcons.mail, color: Colors.grey),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 16),

                          // Password Field
                          CupertinoTextField(
                            controller: _passwordController,
                            placeholder: 'Password',
                            obscureText: _obscurePassword,
                            placeholderStyle: const TextStyle(color: Colors.grey),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade700),
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
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 24),

                          // Register Button
                          CupertinoButton.filled(
                            borderRadius: BorderRadius.circular(12),
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            child: const Text(
                              'Register',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const MyHomePage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Sign In Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(color: Colors.white),
                              ),
                              CupertinoButton(
                                padding: const EdgeInsets.only(left: 4),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: CupertinoColors.activeBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const SignInPage(),
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
