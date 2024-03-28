import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/views/expenses_plan.dart';
import 'package:flutter_budget_planning/views/home.dart';
import 'package:flutter_budget_planning/views/savings_plan.dart';
import 'package:flutter_budget_planning/views/task_management.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
   Home(),
    ExpensesPlan(),
    TaskManagement(),
    SavingsPlan(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Student Pay",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        )),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Expenses Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Task Management',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Savings Plan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,

      ),
    );
  }
}
