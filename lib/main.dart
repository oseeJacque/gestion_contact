import 'package:flutter/material.dart';
import 'package:gestion_contact1/constants/colors.dart';
import 'package:gestion_contact1/screems/home_page.dart';
import 'package:gestion_contact1/screems/login_screem.dart';
import 'package:gestion_contact1/screems/personne_profil.dart';
import 'package:gestion_contact1/screems/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const RegisterScreem(),
      routes:  {
        'register': (context) => RegisterScreem(),
      'login': (context) => MyLogin(),
        'home':(context)=>const MyHomePage(),
        
      },
    );
  }
}

