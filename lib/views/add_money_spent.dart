import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/models/saving_plan.dart';

import '../view_models/saving_plan_view_model.dart';

class AddMoneySpent extends StatefulWidget {
   AddMoneySpent({super.key, required this.plan});

  SavingPlan plan;

  @override
  State<AddMoneySpent> createState() => _AddMoneySpentState();
}

class _AddMoneySpentState extends State<AddMoneySpent> {

  TextEditingController _moneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
              child:  TextFormField(
                controller: _moneyController,
                decoration: InputDecoration(
                  labelText: 'Money Spent',

                ),

                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the money spent';
                  }
                  final double amount = double.tryParse(value)!;

                  if (amount <= 0) {
                    return 'Money spent must be greater than 0';
                  }
                  return null;
                },

              ),
          ),

          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                widget.plan.moneySpent += double.parse(_moneyController.text.trim());

                SavingPlanViewModel().update(widget.plan.id!, widget.plan.toJson());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Money spent added successfully')),
                  );


                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
