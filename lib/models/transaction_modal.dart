class TransactionData {
  final int amount;
  final DateTime date;
  final String note;
  final String type;

  TransactionData(this.amount, this.date, this.note, this.type);

  int get day {
    return date.day;
  }

  int get month {
    return date.month;
  }
}
