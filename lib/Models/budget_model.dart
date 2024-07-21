class Budget {
  int? id;
  String title;
  String year;
  String month;
  String day;
  String time;
  String amount;
  String desc;

  Budget({
    this.id,
    required this.title,
    required this.year,
    required this.month,
    required this.day,
    required this.time,
    required this.amount,
    required this.desc,
  });

  // Convert a Budget into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'month': month,
      'day': day,
      'time': time,
      'amount': amount,
      'desc': desc
    };
  }

  // Extract a Budget object from a Map.
  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      title: map['title'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
      time: map['time'],
      amount: map['amount'],
      desc: map['desc'],
    );
  }
}
