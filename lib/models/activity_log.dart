class ActivityLog {
  String id;
  String actionType;
  String entityType;
  String entityId;
  String userId;
  String description;
  int didAt;

  ActivityLog({
    required this.id,
    required this.actionType,
    required this.entityType,
    required this.entityId,
    required this.userId,
    required this.description,
    required this.didAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'action_type': actionType,
      'entity_type': entityType,
      'entity_id': entityId,
      'user_id': userId,
      'description': description,
      'did_at': didAt,
    };
  }

  factory ActivityLog.fromMap(Map<String, dynamic> map) {
    return ActivityLog(
      id: map['id'],
      actionType: map['action_type'],
      entityType: map['entity_type'],
      entityId: map['entity_id'],
      userId: map['user_id'],
      description: map['description'],
      didAt: map['did_at'],
    );
  }
}
