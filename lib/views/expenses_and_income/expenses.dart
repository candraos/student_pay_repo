import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/models/IncomeExpense.dart';
import 'package:flutter_budget_planning/view_models/IncomeExpenseViewModel.dart';
import 'package:flutter_budget_planning/views/expenses_and_income/income.dart';
import 'package:provider/provider.dart';

import 'add_expense_income.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {


  @override
  Widget build(BuildContext context) {
    final incomeExpenseViewModel = Provider.of<IncomeExpenseViewModel>(context);
    return Scaffold(
      body:  FutureBuilder<dynamic>(
              future: incomeExpenseViewModel.getExpenses(),
              builder: (context,snapshot) {

                return Consumer<IncomeExpenseViewModel>(
                  builder: (context,incomeExpense,child) {
                    return ListView.builder(
                        itemCount: incomeExpense.expenses.length,
                        itemBuilder: (BuildContext context, int index) {
                          final expense = incomeExpense.expenses[index];
                          return ListTile(
                            title: Text(expense.name),
                            subtitle: Text('${expense.value}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await incomeExpense.delete(expense.id!);
                                setState(() {});
                              },
                            ),
                          );
                        }
                    );
                  }
                );
              }
            ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExpenseIncome(isIncome: false)));
            },
            child: Icon(Icons.add,color: Colors.white,))
    );


          }



  }

