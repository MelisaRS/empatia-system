import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    super.key,
    required this.date,
    required this.time,
    required this.service,
    required this.therapist,
    required this.status,
    required this.onTap,
  });

  final String date;
  final String time;
  final String service;
  final String therapist;
  final String status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isCancelled = status == 'Cancelada';

    final Color statusColor = isCancelled ? Colors.red : Colors.green;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(date)),
                        Text(time),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(service),

                    const SizedBox(height: 8),

                    Text(therapist),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Icon(
                          isCancelled ? Icons.cancel : Icons.check_circle,
                          color: statusColor,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(status, style: TextStyle(color: statusColor)),
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
