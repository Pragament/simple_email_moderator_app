class OrgOtp {
  String id;
  String code;
  DateTime createdTimestamp;
  DateTime expirationTimestamp;
  String orgId;

  OrgOtp({
    required this.id,
    required this.code,
    required this.createdTimestamp,
    required this.expirationTimestamp,
    required this.orgId,
  });

  OrgOtp copyWith({
    String? id,
    String? code,
    DateTime? createdTimestamp,
    DateTime? expirationTimestamp,
    String? orgId,
  }) =>
      OrgOtp(
        id: id ?? this.id,
        code: code ?? this.code,
        createdTimestamp: createdTimestamp ?? this.createdTimestamp,
        expirationTimestamp: expirationTimestamp ?? this.expirationTimestamp,
        orgId: orgId ?? this.orgId,
      );

  factory OrgOtp.fromMap(Map<String, dynamic> json) => OrgOtp(
        id: json["id"],
        code: json["code"],
        createdTimestamp: DateTime.fromMillisecondsSinceEpoch(
            int.parse(json["created_timestamp"])),
        expirationTimestamp: DateTime.fromMillisecondsSinceEpoch(
            int.parse(json["expiration_timestamp"])),
        orgId: json["org_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "created_timestamp": createdTimestamp.millisecondsSinceEpoch,
        "expiration_timestamp": expirationTimestamp.millisecondsSinceEpoch,
        "org_id": orgId,
      };
}
