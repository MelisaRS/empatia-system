class Patient {
  final int patientId;
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final String? currentStatus;
  final String? gender;
  final DateTime? registeredAt;

  Patient({
    required this.patientId,
    required this.firstName,
    required this.lastName,
    this.birthDate,
    this.currentStatus,
    this.gender,
    this.registeredAt,
  });
}
