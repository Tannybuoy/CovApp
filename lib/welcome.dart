import 'package:covapp/camera_image.dart';
import 'package:covapp/signin.dart';
import 'package:flutter/material.dart';
import 'package:covapp/main.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ),
        );
      },
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 230, 0, 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Image.asset(
                      'images/vaccinepassport.png',
                      width: 400,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 90),
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
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
