import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import '../models/examEvent.dart';

class ExamProvider extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  final List<ExamEvent> _events = [];
  List<ExamEvent> get events => List.unmodifiable(_events);

  void addEvent(ExamEvent event) async {
    _events.add(event);
    await setupLocationReminder(event);
    notifyListeners();
  }

  List<ExamEvent> getEventsForDay(DateTime day) {
    return _events.where((event) {
      final eventDate = event.dateTime;
      return eventDate.year == day.year &&
          eventDate.month == day.month &&
          eventDate.day == day.day;
    }).toList();
  }

  Future<void> setupLocationReminder(ExamEvent event) async {
    try {
      final LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requestedPermission = await Geolocator.requestPermission();
        if (requestedPermission == LocationPermission.denied) {
          return;
        }
      }

      final Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final distance = await Geolocator.distanceBetween(
        event.location.latitude,
        event.location.longitude,
        currentPosition.latitude,
        currentPosition.longitude,
      );

      if (distance < 1000) { // 1km radius
        await notificationsPlugin.show(
          event.hashCode,
          'Upcoming Exam',
          'You are near the location of your ${event.title} exam',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'exam_reminders',
              'Exam Reminders',
              channelDescription: 'Notifications for nearby exam locations',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error setting up location reminder: $e');
    }
  }
}