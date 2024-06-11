import 'package:flutter/material.dart';
import 'dart:math';


class SavingsCalculator extends StatefulWidget {
  @override
  _SavingsCalculatorState createState() => _SavingsCalculatorState();
}

class _SavingsCalculatorState extends State<SavingsCalculator> {
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _downPaymentController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  double? _monthlyPayment;
  final _formKey = GlobalKey<FormState>();

  void calculateMonthlyPayment() {
    final double totalAmount = double.parse(_totalAmountController.text);
    final double downPayment = double.parse(_downPaymentController.text);
    final double interestRate = double.parse(_interestRateController.text) / 100;
    final int duration = int.parse(_durationController.text);
    final double loanAmount = totalAmount - downPayment;
    final double monthlyInterestRate = interestRate / 12;

    if(downPayment > totalAmount){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("the down payment cannot be bigger than the total amount")));
    return;
    }

    final double monthlyPayment = loanAmount * monthlyInterestRate /
        (1 - (1 /pow(1 + monthlyInterestRate,duration) ));

    setState(() {
      _monthlyPayment = monthlyPayment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _totalAmountController,
                decoration: InputDecoration(labelText: 'Total Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the total amount';
                  }
                  double number = 0;
                  try{
                    number = double.tryParse(value) ?? 0;
                  }catch(e){
                    return 'Please enter a valid number';
                  }finally{

                    if (number <= 0) {
                      return 'Invalid total amount';
                    }
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _downPaymentController,
                decoration: InputDecoration(labelText: 'Down Payment'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the down payment';
                  }
                  double number = 0;
                  try{
                    number = double.tryParse(value) ?? 0;
                  }catch(e){
                    return 'Please enter a valid number';
                  }finally{

                    if (number <= 0) {
                      return 'Invalid down payment';
                    }
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _interestRateController,
                decoration: InputDecoration(labelText: 'Interest Rate (%)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter interest rate';
                  }
                  double number = 0;
                  try{
                    number = double.tryParse(value) ?? 0;
                  }catch(e){
                    return 'Please enter a valid number';
                  }finally{

                    if (number <= 0 || number > 100) {
                      return 'Invalid interest rate';
                    }
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Duration (months)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the duration';
                  }
                  double number = 0;
                  try{
                    number = double.tryParse(value) ?? 0;
                  }catch(e){
                    return 'Please enter a valid number';
                  }finally{

                    if (number == 0) {
                      return 'Duration cannot be zero';
                    }
                  }

                  return null;
                },
              ),
              ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()){
                    calculateMonthlyPayment();
                  }
                },
                child: Text('Calculate'),
              ),
              if (_monthlyPayment != null)
                Text('Monthly Payment: \$${_monthlyPayment!.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}