import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

class EventInfoCard extends StatelessWidget {
  const EventInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          InfoRow(
            icon: Icons.calendar_month_rounded,
            title: '14 December, 2021',
            subtitle: 'Tuesday, 4:00PM - 9:00PM',
          ),
          SizedBox(height: 16),
          InfoRow(
            icon: Icons.location_on,
            title: 'Gala Convention Center',
            subtitle: '36 Guild Street London, UK',
            subtitleColor: Colors.blue,
          ),
          SizedBox(height: 16),
          InfoRow(
            icon: Icons.people,
            title: '200 Capacity',
            subtitle: '3 seats left',
            subtitleColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? subtitleColor;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 24.sp, color: Colors.grey.shade700),
        14.widthBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              2.heightBox,
              Text(
                subtitle,
                style: TextStyle(
                  color: subtitleColor ?? Colors.grey.shade600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
