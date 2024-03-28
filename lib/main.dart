import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/view_models/IncomeExpenseViewModel.dart';
import 'package:flutter_budget_planning/view_models/TaskManagementViewModel.dart';
import 'package:flutter_budget_planning/view_models/saving_plan_view_model.dart';
import 'package:flutter_budget_planning/views/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => IncomeExpenseViewModel()),
      ChangeNotifierProvider(create: (context) => TaskManagementViewModel()),
      ChangeNotifierProvider(create: (context) => SavingPlanViewModel()),
    ],
      child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       // primaryColor: Color(0xFFD700),
       //  backgroundColor: Color(0xFFD700),
        primarySwatch: Colors.amber,


      ),
      home: MainScreen(),
    );
  }
}
