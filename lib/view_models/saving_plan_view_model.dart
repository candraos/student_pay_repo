import 'package:flutter/cupertino.dart';
import 'package:flutter_budget_planning/models/saving_plan.dart';

import '../models/database_helper.dart';

class SavingPlanViewModel with ChangeNotifier{
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  double remaining = 0;
  List<SavingPlan> plans = [];
  Future<void> addPlan(SavingPlan plan) async{
    await _databaseHelper.insertValue("SavingPlan", plan.toJson());
    plans.add(plan);
    notifyListeners();
  }
  Future<int> delete(int id) async{
    int result =  await _databaseHelper.delete("SavingPlan", id);
    plans.removeWhere((element) => element.id == id);
    return result;

  }
  Future update(int id, Map<String,dynamic> content) async{
    int result =  await _databaseHelper.updateById("SavingPlan", id, content);
    SavingPlan newPlan = SavingPlan.fromJson(content);
    List<SavingPlan> newPlans = [newPlan];
    plans = newPlans;
    // await loadPlans();
    getRemaining();
    notifyListeners();
    return result;
  }
  Future loadPlans() async{
    final List<Map<String, dynamic>> maps = await _databaseHelper.getPlans();
    plans = List.generate(maps.length, (i) {
      return SavingPlan(
          id: maps[i]['id'],
          plan: maps[i]['plan'],
        moneySpent: maps[i]['moneySpent'],
          name: maps[i]['name']
      );
    });
    getRemaining();
notifyListeners();
  }

  getRemaining(){

    if(plans.isNotEmpty){
      remaining = plans[0].plan - plans[0].moneySpent;

    }else remaining = 0;
  }


}