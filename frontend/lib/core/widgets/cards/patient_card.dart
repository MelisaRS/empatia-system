import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.patientName,
    required this.age,
    required this.guardianName,
    required this.phone,
    required this.onTap,
  });

  final String patientName;
  final String age;
  final String guardianName;
  final String phone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(patientName)),
                        Text(age),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(child: Text(guardianName)),
                        const Icon(Icons.phone, size: 16),
                        const SizedBox(width: 4),
                        Text(phone),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
