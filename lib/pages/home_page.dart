import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          child: TextField(
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
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
      ),
    );
  }
}
