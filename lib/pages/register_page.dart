import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/components/my_button.dart';
import 'package:login_signup/components/my_textfield.dart';
import 'package:login_signup/components/square_tile.dart';
import 'package:login_signup/pages/login_page.dart';
import 'package:login_signup/services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing Controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

//signUp method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try to creating the user
    try {
      //checked if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else
        //show the error messaage
        showErrorMessage("password doeson't match");

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
                    SizedBox(
                      width: 350, // Set the desired width
                      height: 190, // Set the desired height
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

                //create an account
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 15),
                //username
                MyTextField(
                  controller: emailController,
                  hintText: ' Email',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                //password
                MyTextField(
                  controller: passwordController,
                  hintText: ' Password',
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                //Confirm password
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: ' Confirm password',
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                const SizedBox(height: 15),

                //signin button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                const SizedBox(height: 50),

                //or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           'Or continue with',
                //           style: TextStyle(color: Colors.grey[700]),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 25),
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
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
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
