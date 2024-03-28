import 'package:flutter/cupertino.dart';
import 'package:flutter_budget_planning/models/IncomeExpense.dart';
import 'package:flutter_budget_planning/models/database_helper.dart';

class IncomeExpenseViewModel with ChangeNotifier {
  final DatabaseHelper _helper = DatabaseHelper();
  List<IncomeExpense> incomes = [];
  List<IncomeExpense> expenses = [];
  Map<String,double> expensesDataMap = {};
  double totalExpenses =0;
  double totalIncome =0;
  double budget =0;


Future<int> delete(int id) async{

  int result =  await _helper.delete("IncomeExpense", id);
  expensesDataMap.removeWhere((key, value) => true);
  await getExpensesDataMap();
  return result;
}

  insert(IncomeExpense incomeExpense)async{
    await _helper.insertValue("IncomeExpense", incomeExpense.toJson());
     incomeExpense.isIncome ? await getIncomes() : await getExpenses();
     await getExpensesDataMap();
    notifyListeners();

  }

  getIncomes() async{
    List<Map<String, dynamic>> maps = await _helper.getIncomes();
    incomes = List.generate(maps.length, (i) {
      return IncomeExpense(
        id: maps[i]['id'],
        name: maps[i]['name'],
        value: maps[i]['value'],
        isIncome: maps[i]['isIncome'] == 1 ? true : false,
      );
    });
    notifyListeners();
  }

  getExpenses() async{
    List<Map<String, dynamic>> maps = await _helper.getExpenses();
    expenses = List.generate(maps.length, (i) {
      return IncomeExpense(
        id: maps[i]['id'],
        name: maps[i]['name'],
        value: maps[i]['value'],
        isIncome: maps[i]['isIncome'] == 1 ? true : false,
      );
    });
    notifyListeners();
  }

  getExpensesDataMap() async{
  await getIncomes();
    await getExpenses();
    expenses.forEach((element) {
      expensesDataMap.addAll({
        element.name : element.value
      });
    });
    // await getIncomes();
    getBudget();
  }

  getTotalExpenses(){
    totalExpenses = 0;
    expenses.forEach((element) {
      totalExpenses += element.value;
    });
    return totalExpenses;
  }

  getTotalIncome(){
    totalIncome = 0;
    incomes.forEach((element) {
      totalIncome += element.value;
    });
  }

  getBudget(){
  getTotalExpenses();
  getTotalIncome();
  budget = totalIncome-totalExpenses;
  notifyListeners();
  }
}