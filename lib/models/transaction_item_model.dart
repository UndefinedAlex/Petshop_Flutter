class TransactionItem {
  String id;
  String transactionId;
  String productId;
  int quantity;
  double pricePerUnit;
  double subtotal;
  int createdAt;

  TransactionItem({
    required this.id,
    required this.transactionId,
    required this.productId,
    required this.quantity,
    required this.pricePerUnit,
    required this.subtotal,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'product_id': productId,
      'quantity': quantity,
      'price_per_unit': pricePerUnit,
      'subtotal': subtotal,
      'created_at': createdAt,
    };
  }

  factory TransactionItem.fromMap(Map<String, dynamic> map) {
    return TransactionItem(
      id: map['id'],
      transactionId: map['transaction_id'],
      productId: map['product_id'],
      quantity: map['quantity'],
      pricePerUnit: map['price_per_unit'],
      subtotal: map['subtotal'],
      createdAt: map['created_at'],
    );
  }
}
