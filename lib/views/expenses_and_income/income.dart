import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/IncomeExpenseViewModel.dart';
import 'add_expense_income.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {

  @override
  Widget build(BuildContext context) {
    final incomeExpenseProvider = Provider.of<IncomeExpenseViewModel>(context);
    return Scaffold(
      body:  FutureBuilder<dynamic>(
                future: incomeExpenseProvider.getIncomes(),
                builder: (context,snapshot) {

                  return Consumer<IncomeExpenseViewModel>(
                    builder: (context,incomeExpense,child) {
                      return ListView.builder(
                          itemCount: incomeExpense.incomes.length,
                          itemBuilder: (BuildContext context, int index) {
                            final income = incomeExpense.incomes[index];
                            return ListTile(
                              title: Text(income.name),
                              subtitle: Text('${income.value}'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  await incomeExpense.delete(income.id!);
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

      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExpenseIncome(isIncome: true)));
      },child: Icon(Icons.add,color: Colors.white,)),
    );

  }
}
