import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'datastor.dart';

// Future< void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
//   return runApp(MyApp());
// }
void main(){
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: const DataStor(),
    );
  }
}


