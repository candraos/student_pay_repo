import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/models/IncomeExpense.dart';
import 'package:provider/provider.dart';

import '../../view_models/IncomeExpenseViewModel.dart';

class AddExpenseIncome extends StatefulWidget {
  const AddExpenseIncome({super.key, required this.isIncome});
final bool isIncome;
  @override
  State<AddExpenseIncome> createState() => _AddExpenseIncomeState();
}

class _AddExpenseIncomeState extends State<AddExpenseIncome> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> _dropdownItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String _selectedItem = 'Item 1';

  @override
  void initState() {
    super.initState();
    widget.isIncome ? _dropdownItems = ["Full-Time","Part-Time","Freelance","Other"]
    : _dropdownItems = ["Food", "Gifts","Electronics","Clothes","Gadgets","Other"];
    _selectedItem = _dropdownItems[0];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: _formKey,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

        DropdownButton<String>(
        hint: Text('Select an item'), // Optional text to display as hint
        value: _selectedItem, // Currently selected item
        onChanged: ( newValue) {
          setState(() {
            _selectedItem = newValue!; // Update selected item
          });
        },
        items: _dropdownItems.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),



            TextFormField(
              controller: _valueController,
              decoration: InputDecoration(
                labelText: '${widget.isIncome ? "Income" : "Expense"} value',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the ${widget.isIncome ? "Income" : "Expense"} value';
                }
                final double amount = double.tryParse(value)!;

                if (amount <= 0) {
                  return 'Value must be greater than 0';
                }
                return null;
              },

            ),

            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  IncomeExpense ie = IncomeExpense(name: _selectedItem, value: double.parse(_valueController.text.trim()), isIncome: widget.isIncome);
                  IncomeExpenseViewModel ievm = IncomeExpenseViewModel();
                  ievm.addListener(() {

                  });
                  String feedback = await ievm.insert(ie);
                  if(feedback == ""){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${widget.isIncome?"Income":"Expense"} Added Successfully')),
                    );
                    Navigator.of(context).pop();
                  }

                  else
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(feedback)),
                    );

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
