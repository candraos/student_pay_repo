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

  void calculateMonthlyPayment() {
    final double totalAmount = double.parse(_totalAmountController.text);
    final double downPayment = double.parse(_downPaymentController.text);
    final double interestRate = double.parse(_interestRateController.text) / 100;
    final int duration = int.parse(_durationController.text);
    final double loanAmount = totalAmount - downPayment;
    final double monthlyInterestRate = interestRate / 12;
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
        child: Column(
          children: <Widget>[
            TextField(
              controller: _totalAmountController,
              decoration: InputDecoration(labelText: 'Total Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _downPaymentController,
              decoration: InputDecoration(labelText: 'Down Payment'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _interestRateController,
              decoration: InputDecoration(labelText: 'Interest Rate (%)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Duration (months)'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: calculateMonthlyPayment,
              child: Text('Calculate'),
            ),
            if (_monthlyPayment != null)
              Text('Monthly Payment: \$${_monthlyPayment!.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}