class IncomeExpense{
  int? id;
  String name;
  double value;
  bool isIncome;

  IncomeExpense({this.id, required this.name, required this.value, required this.isIncome});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'isIncome': isIncome ? 1 : 0,
    };
  }

  factory IncomeExpense.fromJson(Map<String, dynamic> json) {
    return IncomeExpense(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      isIncome: json['isIncome'] == 1 ? true : false,
    );
  }
}