class Staff {
  final int staffId;
  final int? userId;
  final String firstName;
  final String lastName;
  final String? phone;
  final DateTime? birthDate;
  final String? staffType;
  final String? affiliationType;
  final String? currentStatus;
  final String? gender;
  final String? staffImageUrl;
  final int? centerId;

  Staff({
    required this.staffId,
    this.userId,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.birthDate,
    this.staffType,
    this.affiliationType,
    this.currentStatus,
    this.gender,
    this.staffImageUrl,
    this.centerId,
  });
}
