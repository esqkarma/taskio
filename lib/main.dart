
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Provider/TaskProvider.dart';
import 'package:taskio/Provider/TimeProvider.dart';
import 'package:taskio/Provider/animationProvider.dart';
import 'package:taskio/Provider/pageSwitchProvider.dart';
import 'package:taskio/Provider/soundProvider.dart';

import 'Features/Screens/Home.dart';


void main() {
  runApp(
       MultiProvider(providers: [
         ChangeNotifierProvider(create: (ctx)=>TaskProvider()),
         ChangeNotifierProvider(create: (ctx)=>TimeProvider()),
         ChangeNotifierProvider(create: (ctx)=>PageSwitchProvider()),
         ChangeNotifierProvider(create: (ctx)=>SoundProvider()),
         ChangeNotifierProvider(create: (ctx)=>ConfettiProvider())
       ],
       child: MyApp()));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
