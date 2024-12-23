class Discount {
  String id;
  String discountType;
  double discountValue;
  int startDate;
  int endDate;
  String? productId;
  String? transactionId;
  int createdAt;
  int updatedAt;

  Discount({
    required this.id,
    required this.discountType,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
    this.productId,
    this.transactionId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'discount_type': discountType,
      'discount_value': discountValue,
      'start_date': startDate,
      'end_date': endDate,
      'product_id': productId,
      'transaction_id': transactionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Discount.fromMap(Map<String, dynamic> map) {
    return Discount(
      id: map['id'],
      discountType: map['discount_type'],
      discountValue: map['discount_value'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      productId: map['product_id'],
      transactionId: map['transaction_id'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
