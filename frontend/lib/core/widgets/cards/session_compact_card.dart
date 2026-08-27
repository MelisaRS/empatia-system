import 'package:flutter/material.dart';

class SessionCompactCard extends StatelessWidget {
  const SessionCompactCard({
    super.key,
    required this.patientName,
    required this.time,
    required this.service,
    required this.status,
    required this.therapistColor,
    this.therapistImage,
    required this.onTap,
  });

  final String patientName;
  final String time;
  final String service;
  final String status;
  final Color therapistColor;
  final ImageProvider? therapistImage;
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: therapistColor, width: 2),
                ),
                child: CircleAvatar(
                  backgroundImage: therapistImage,
                  child: therapistImage == null
                      ? const Icon(Icons.person, size: 20)
                      : null,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(patientName)),
                        Text(time),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Expanded(child: Text(service)),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isCancelled ? Icons.cancel : Icons.check_circle,
                                color: statusColor,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                status,
                                style: TextStyle(color: statusColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
