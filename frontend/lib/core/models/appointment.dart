class Appointment {
  final int appointmentId;
  final int patientId;
  final int staffId;
  final int serviceId;
  final DateTime appointmentDate;
  final String startTime;
  final String endTime;
  final String? reason;
  final String status;
  final int? recurringScheduleId;

  Appointment({
    required this.appointmentId,
    required this.patientId,
    required this.staffId,
    required this.serviceId,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    this.reason,
    required this.status,
    this.recurringScheduleId,
  });
}
