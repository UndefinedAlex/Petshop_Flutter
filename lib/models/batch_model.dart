class Batch {
  String id;
  int expDate;
  int quantity;
  String status;
  double costPrice;
  double retailPrice;
  String location;
  int createdAt;

  Batch({
    required this.id,
    required this.expDate,
    required this.quantity,
    required this.status,
    required this.costPrice,
    required this.retailPrice,
    required this.location,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exp_date': expDate,
      'quantity': quantity,
      'status': status,
      'cost_price': costPrice,
      'retail_price': retailPrice,
      'location': location,
      'created_at': createdAt,
    };
  }

  factory Batch.fromMap(Map<String, dynamic> map) {
    return Batch(
      id: map['id'],
      expDate: map['exp_date'],
      quantity: map['quantity'],
      status: map['status'],
      costPrice: map['cost_price'],
      retailPrice: map['retail_price'],
      location: map['location'],
      createdAt: map['created_at'],
    );
  }
}
