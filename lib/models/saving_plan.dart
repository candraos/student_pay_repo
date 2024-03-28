class SavingPlan {
  int? id;
  double plan;
  double moneySpent = 0;

  SavingPlan({this.id, required this.plan, this.moneySpent = 0});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan': plan,
      'moneySpent': moneySpent,
    };
  }

  factory SavingPlan.fromJson(Map<String, dynamic> json) {
    return SavingPlan(
      id: json['id'],
      plan: json['plan'],
      moneySpent: json['moneySpent'],
    );
  }
}