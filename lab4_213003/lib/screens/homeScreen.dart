import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../models/examEvent.dart';
import '../providers/examProvider.dart';

import 'addExamScreen.dart';
import 'mapScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<ExamEvent> _getEventsForDay(DateTime day, List<ExamEvent> allEvents) {
    return allEvents.where((event) =>
    event.dateTime.year == day.year &&
        event.dateTime.month == day.month &&
        event.dateTime.day == day.day).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamProvider>(
      builder: (context, examProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Exam Schedule'),
            actions: [
              IconButton(
                icon: const Icon(Icons.map),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              TableCalendar<ExamEvent>(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                eventLoader: (day) => _getEventsForDay(day, examProvider.events),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                calendarStyle: const CalendarStyle(
                  markersMaxCount: 1,
                  markerDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _selectedDay == null
                    ? const Center(child: Text('Select a day to see exams'))
                    : ListView.builder(
                  itemCount: _getEventsForDay(
                      _selectedDay!, examProvider.events)
                      .length,
                  itemBuilder: (context, index) {
                    final event = _getEventsForDay(
                        _selectedDay!, examProvider.events)[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: ListTile(
                        title: Text(event.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Date: ${event.dateTime.toString().split('.')[0]}'),
                            Text('Location: ${event.locationName}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.map),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                  destination: event.location,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddExamScreen(selectedDate: _selectedDay),
                ),
              );
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}