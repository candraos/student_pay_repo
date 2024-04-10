class SavingPlan {
  int? id;
  double plan;
  double moneySpent = 0;
  String name = "";

  SavingPlan({this.id, required this.plan, required this.name, this.moneySpent = 0});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan': plan,
      'moneySpent': moneySpent,
      'name' : name
    };
  }

  factory SavingPlan.fromJson(Map<String, dynamic> json) {
    return SavingPlan(
      id: json['id'],
      plan: json['plan'],
      moneySpent: json['moneySpent'],
      name: json['name'],
    );
  }
}