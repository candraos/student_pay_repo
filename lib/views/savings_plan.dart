import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/view_models/saving_plan_view_model.dart';
import 'package:flutter_budget_planning/views/add_money_spent.dart';
import 'package:provider/provider.dart';

import 'add_saving_plan.dart';

class SavingsPlan extends StatefulWidget {
  const SavingsPlan({super.key});

  @override
  State<SavingsPlan> createState() => _SavingsPlanState();
}

class _SavingsPlanState extends State<SavingsPlan> {
  int? id;
  Map<String,dynamic>? planJson;
  @override
  Widget build(BuildContext context) {
    
    final savingPlanViewModel = Provider.of<SavingPlanViewModel>(context,listen: true);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: savingPlanViewModel.loadPlans(),
                builder: (context,snapshot){


                      return Consumer<SavingPlanViewModel>(
                        builder: (context,savingPlan,child) {
                          return ListView.builder(
                            itemCount: savingPlan.plans.length,
                              itemBuilder: (context,index){
                                final plan = savingPlan.plans[index];
                                id = plan.id;
                                planJson = plan.toJson();
                                return ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMoneySpent(plan: plan)));
                                  },
                                  title: Text("${plan.name} : ${plan.plan}"),
                                  subtitle: Text("remaining: ${(plan.plan-plan.moneySpent)}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async{
                                      await savingPlan.delete(plan.id!);
                                      id = null;
                                      planJson = null;
                                      setState(() {

                                      });
                                    },
                                  ),
                                );
                              }
                          );
                        }
                      );



                }
            ),
          ),
          // Consumer<SavingPlanViewModel>(
          //   builder: (context,savingPlan,child){
          //     savingPlan.getRemaining();
          //     return Text("Remaining: ${savingPlan.remaining}",style: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold
          //     )
          //     );
          //   },
          // )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSavingPlan()));
    },
    )
    );
  }
}
