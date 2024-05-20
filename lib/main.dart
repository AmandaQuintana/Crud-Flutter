import 'package:crud_firebase/pages/add_user_page.dart';
import 'package:crud_firebase/pages/home_page.dart';
import 'package:crud_firebase/pages/update_user_page.dart';
import 'package:flutter/material.dart';

//Importaciones de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => const AddUserPage(),
        '/update': (context) => const UpdateUserPage(),
      },
      debugShowCheckedModeBanner: false,
    );

  }

}