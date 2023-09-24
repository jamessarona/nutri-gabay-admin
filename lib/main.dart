import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nutri_gabay_admin/root_page.dart';
import 'package:nutri_gabay_admin/services/baseauth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: "AIzaSyAweCHAdtTnW7QjPDmPF73HqiO_mCIHaF4",
              projectId: "nutri-gabay",
              messagingSenderId: "376018937615",
              appId: "1:376018937615:web:2debaaf176272bacd6c07a",
              storageBucket: 'nutri-gabay.appspot.com',
            )
          : null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriGabay Admin',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Root(
        auth: FireBaseAuth(),
      ),
    );
  }
}
