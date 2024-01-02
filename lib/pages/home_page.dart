import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PaymentPage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _textFieldController = TextEditingController();

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void userdetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Details'),
          content: Text(user.email!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void navigateToPaymentPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Color.fromARGB(255, 40, 39, 39), actions: [
        IconButton(
          onPressed: signUserOut,
          icon: const Icon(Icons.logout_rounded),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () => userdetails(context),
          icon: const Icon(Icons.account_circle),
          color: Colors.white,
        ),
      ]),
      // body: const Center(

      //     // child: Text("LOGGED IN as : " + user.email!,
      //     //     style: TextStyle(fontSize: 20)),
      //     ),

      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'JustGo - Ticketing Amount',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Price',
                    labelStyle: TextStyle(color: Colors.black), // Label color
                    border: OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.black),
                        ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}$')),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your confirm button logic here
                      navigateToPaymentPage(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('Confirm'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
