class Expense {
  int? id;
  String? title;
  String? year;
  String? month;
  String? day;
  String? time;
  String? amount;
  String? desc;
  String? category;

  Expense({
    this.id,
    this.title,
    this.year,
    this.month,
    this.day,
    this.time,
    this.amount,
    this.desc,
    this.category,
  });

  // Convert Expense to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'month': month,
      'day': day,
      'time': time,
      'amount': amount,
      'desc': desc,
      'category': category,
    };
  }

  // Convert Map to Expense
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
      time: map['time'],
      amount: map['amount'],
      desc: map['desc'],
      category: map['category'],
    );
  }
}
