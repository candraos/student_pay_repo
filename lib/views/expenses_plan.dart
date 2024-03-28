import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/views/expenses_and_income/expenses.dart';

import 'expenses_and_income/income.dart';

class ExpensesPlan extends StatefulWidget {
  const ExpensesPlan({super.key});

  @override
  State<ExpensesPlan> createState() => _ExpensesPlanState();
}

class _ExpensesPlanState extends State<ExpensesPlan> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(

          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TabBar(

                  tabs: [
                Text("Incomes",style: TextStyle(fontSize: 23),),
                Text("Expenses",style: TextStyle(fontSize: 23),)
              ]),
            ),
            Expanded(
              child: TabBarView(
              children: [
                Income(),
                Expenses()
              ],
              )
            )
          ]
            ,
        ),
      ),
    );
  }
}
