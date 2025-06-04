import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../data/models/event_model.dart';

class EventInfoCard extends StatelessWidget {
  const EventInfoCard({super.key, this.event});

  final Event? event;

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
        children: [
          InfoRow(
            icon: Icons.calendar_month_rounded,
            title: formatDate(event?.startDate),
            subtitle: formatDateTimeRange(event?.startDate, event?.endDate),
          ),
          16.heightBox,
          InfoRow(
            icon: Icons.location_on,
            title: event?.location ?? '',
            subtitle: 'onSide',
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
  String formatDate(DateTime? dateTime) {
    if(dateTime == null) return 'Date not defined yet';
    final DateFormat formatter = DateFormat('d MMMM, y');
    return formatter.format(dateTime);
  }

  String formatDateTimeRange(DateTime? start, DateTime? end) {
    if (start == null || end == null) {
      return 'Time not defined yet';
    }

    final dayFormat = DateFormat('EEEE');        // e.g., Tuesday
    final timeFormat = DateFormat('h:mma');      // e.g., 4:00PM

    String day = dayFormat.format(start);
    String startTime = timeFormat.format(start);
    String endTime = timeFormat.format(end);

    return '$day, $startTime - $endTime';
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
