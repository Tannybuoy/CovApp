import 'package:covapp/authentication_service.dart';
import 'package:covapp/camera_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height:80),
          Column(
            children: [
              Text(
                "COVAPP",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Your virtual Vaccine Card",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height:20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadingImageToFirebaseStorage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontStyle: FontStyle.italic),
              ),
              child: Text("Sign In"),
            ),
          ),
        ],
      ),
    );
  }
}
