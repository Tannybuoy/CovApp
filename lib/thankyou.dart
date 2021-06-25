import 'package:covapp/signin.dart';
import 'package:flutter/material.dart';
import 'package:covapp/authentication_service.dart';
import 'package:provider/provider.dart';

class ThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 130, 0, 30),
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
            SizedBox(height: 40),
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
            SizedBox(height:30),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
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
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
