import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/classes/data_exporter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../models/database_helper.dart';
import '../view_models/IncomeExpenseViewModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    final incomeExpenseViewModel = Provider.of<IncomeExpenseViewModel>(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
                child: Text("Expenses Chart",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),)
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: incomeExpenseViewModel.getExpensesDataMap(),
                builder: (context,snapshot) {
                  return Consumer<IncomeExpenseViewModel>(
                    builder: (context,incomeExpense,child) {
                      if(incomeExpense.expensesDataMap.isEmpty) return Center(child: Text("No Expenses to show"),);
                      return PieChart(
                        dataMap: incomeExpense.expensesDataMap,
                        chartRadius: MediaQuery.of(context).size.width / 1.7,
                        legendOptions: LegendOptions(
                          legendPosition: LegendPosition.bottom
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                      );
                    }
                  );
                }
              ),
            ),

            Consumer<IncomeExpenseViewModel>
              (builder: (context,incomeExpense,child){
                return Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Text("Budget: ${incomeExpense.budget}",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                );
            }),

            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: ()async {
                    try{
                      List<dynamic> data = await DataExporter.importData();
                      final DatabaseHelper _helper = DatabaseHelper();
                      String table = '';
                      int i=1;
                      data.forEach((element) {
                        switch (i){
                          case 1: table = "IncomeExpense"; break;
                          case 2: table = "IncomeExpense"; break;
                          case 3: table = "TaskManagement"; break;
                          default: table = "SavingPlan";break;
                        }
                        i++;
                        element.forEach((element1) async{
                          element1["id"] = null;
                          await _helper.insertValue(table, element1);
                        });
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Your data was imported successfully!')),
                      );
                    }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error Importing data, make sure the file is in the right format')),
                    );
                    }




                  }, child: Text("Import")),

                  ElevatedButton(onPressed: () async{

                    String path = await DataExporter.exportData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$path')),
                    );
                  }, child: Text("Export"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
