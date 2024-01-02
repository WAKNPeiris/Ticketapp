import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/components/my_button.dart';
import 'package:login_signup/components/my_textfield.dart';
import 'package:login_signup/components/square_tile.dart';
import 'package:login_signup/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing Controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

//signUserIn method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

//show error message
      showErrorMessage(e.code);
    }
  }

  //error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 73, 88),
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),

      // backgroundColor: Color.fromARGB(255, 244, 247, 247),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button
                    SizedBox(
                      width: 300, // Set the desired width
                      height: 250, // Set the desired height
                      child: SquareTile(
                        // onTap: () {},
                        imagePath: 'lib/images/logo.png',
                      ),
                    ),
                  ],
                ),
                // const Icon(
                //   Icons.lock_person_rounded,
                //   size: 100,
                //   color: Color.fromARGB(255, 94, 9, 2),
                // ),

                //welcomeback

                //username
                MyTextField(
                  controller: emailController,
                  hintText: ' Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //password
                MyTextField(
                  controller: passwordController,
                  hintText: ' Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //forgot password
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'Forgot Password ? ',
                //         style: TextStyle(color: Colors.grey[600]),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 25),

                //signin button
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[300],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //   child: Text(
                      //     'Or continue with',
                      //     style: TextStyle(color: Colors.grey[700]),
                      //   ),
                      // ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 30),
                // //google + apple sign
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     //google button
                //     SquareTile(
                //       // onTap: () => AuthService().signInWithGoogle(),
                //       imagePath: 'lib/images/google.png',
                //     ),

                //     SizedBox(width: 25),

                //     //apple button
                //     SquareTile(
                //       // onTap: () {},
                //       imagePath: 'lib/images/apple.png',
                //     ),
                //   ],
                // ),
                //not remember? register now
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I have not account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
