import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskapp/models/task_model.dart';
import 'screen/homescreen.dart';
import 'package:hive/hive.dart';

void main()async {
  await Hive.initFlutter();
  Hive.registerAdapter(taskmodelAdapter());
  runApp(const MyApp());

}

 class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return  MaterialApp(
       debugShowCheckedModeBanner:false ,
       theme: ThemeData.dark().copyWith(
         //scaffoldBackgroundColor: blue1
       ),
       home: homescreen(),

     );
   }
 }
 