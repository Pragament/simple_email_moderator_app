class Moderator {
  String id;
  String orgId;
  String? emailLocalPart;
  String? password;
  DateTime? datetime;
  String? moderatorUserId;
  String? adminId;
  bool? isApproved;

  Moderator({
    required this.id,
    required this.orgId,
    this.emailLocalPart,
    this.password,
    this.datetime,
    this.moderatorUserId,
    this.adminId,
    this.isApproved,
  });

  factory Moderator.fromMap(Map<String, dynamic> json) {
    return Moderator(
      id: json['id'] as String,
      orgId: json['org_id'] as String,
      emailLocalPart: json['email_local_part'] as String?,
      password: json['password'] as String?,
      datetime:
          json["datetime"] != null
              ? DateTime.fromMillisecondsSinceEpoch(json["datetime"] as int)
              : null,
      moderatorUserId: json['moderator_user_id'] as String?,
      adminId: json['admin_id'] as String?,
      isApproved: json['is_approved'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'org_id': orgId,
      'email_local_part': emailLocalPart,
      'password': password,
      'datetime': datetime?.toIso8601String(),
      'moderator_user_id': moderatorUserId,
      'admin_id': adminId,
      'is_approved': isApproved,
    };
  }
}
