import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:bharatflow/widgets/sign_in_form.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SignInForm(
                  showNavigation: false,
                  onSubmit: (username, password) {
                    print("Username: $username, Password: $password");
                    // TODO: Add your custom behavior here
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
