// import 'package:flutter/material.dart';
// import 'package:lab4_213003/models/examEvent.dart';
//
// class EventService with ChangeNotifier {
//   List<ExamEvent> _events = [
//     ExamEvent(
//       title: "Exam 1",
//       location: "Room A-101",
//       latitude: 41.9981,
//       longitude: 21.4254,
//       date: DateTime(2025, 1, 10), // Added date
//     ),
//     ExamEvent(
//       title: "Exam 2",
//       location: "Room B-202",
//       latitude: 41.9985,
//       longitude: 21.4260,
//       date: DateTime(2025, 1, 15), // Added date
//     ),
//     ExamEvent(
//       title: "Exam 3",
//       location: "Room C-303",
//       latitude: 41.9990,
//       longitude: 21.4270,
//       date: DateTime(2025, 1, 20), // Added date
//     ),
//   ];
//
//   List<ExamEvent> get events {
//     _events.sort((a, b) => a.date.compareTo(b.date)); // Sorting by date
//     return _events;
//   }
//
//   void addEvent(ExamEvent event) {
//     _events.add(event);
//     notifyListeners();
//   }
//
//   void deleteEvent(ExamEvent event) {
//     _events.remove(event);
//     notifyListeners();
//   }
// }