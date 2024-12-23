class Product {
  String id;
  String batchId;
  String userId;
  String name;
  String category;
  String barcode;
  String unit;
  int createdAt;
  int updatedAt;

  Product({
    required this.id,
    required this.batchId,
    required this.userId,
    required this.name,
    required this.category,
    required this.barcode,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'batch_id': batchId,
      'user_id': userId,
      'name': name,
      'category': category,
      'barcode': barcode,
      'unit': unit,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      batchId: map['batch_id'],
      userId: map['user_id'],
      name: map['name'],
      category: map['category'],
      barcode: map['barcode'],
      unit: map['unit'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
