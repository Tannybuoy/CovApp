// @dart=2.9

import 'package:covapp/camera_image.dart';
import 'package:covapp/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:covapp/authentication_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),

        ),
        StreamProvider(
            create: (context)=>context.read<AuthenticationService>().authStateChanges,
            initialData: null,
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AuthenticationWrapper(),
        ),
      ),
    );
  }
}


class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if(firebaseUser!=null){
      return UploadingImageToFirebaseStorage();
    }
    return SignInPage();
  }
}
