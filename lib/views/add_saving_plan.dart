import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/models/saving_plan.dart';
import 'package:flutter_budget_planning/view_models/saving_plan_view_model.dart';

class AddSavingPlan extends StatefulWidget {
   AddSavingPlan({super.key, this.id, this.planJson});
  int? id;
  Map<String,dynamic>? planJson;

  @override
  State<AddSavingPlan> createState() => _AddSavingPlanState();
}

class _AddSavingPlanState extends State<AddSavingPlan> {
  final _planController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _planController.text = widget.planJson != null? widget.planJson!["plan"].toString() : "";

    return Scaffold(
      body: Form(
        key: _formKey,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _planController,
              decoration: InputDecoration(
                labelText: 'Saving Plan Amount',

              ),

              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the saving plan amount';
                }
                final double amount = double.tryParse(value)!;

                if (amount <= 0) {
                  return 'Saving plan must be greater than 0';
                }
                return null;
              },

            ),



            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {

                  if(widget.id == null || widget.planJson == null){
                    SavingPlanViewModel().addPlan(SavingPlan(plan: double.parse(_planController.text.trim())));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Saving Plan Added Successfully')),
                    );
                  }
                  else{
                    SavingPlan newPlan = SavingPlan(id: widget.id!,plan: double.parse(_planController.text.trim()));
                    SavingPlanViewModel().update(widget.id!, newPlan.toJson());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Saving Plan Updated Successfully')),
                    );
                  }

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
