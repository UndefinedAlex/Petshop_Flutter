class Transaction {
  String id;
  String userId;
  int transactionDate;
  double totalAmount;
  String paymentMethod;
  int createdAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.transactionDate,
    required this.totalAmount,
    required this.paymentMethod,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'transaction_date': transactionDate,
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
      'created_at': createdAt,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      userId: map['user_id'],
      transactionDate: map['transaction_date'],
      totalAmount: map['total_amount'],
      paymentMethod: map['payment_method'],
      createdAt: map['created_at'],
    );
  }
}
