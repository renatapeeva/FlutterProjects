import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/examEvent.dart';
import '../providers/ExamProvider.dart';
import 'locationPickerScreen.dart';


class AddExamScreen extends StatefulWidget {
  final DateTime? selectedDate;

  const AddExamScreen({super.key, this.selectedDate});

  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  LatLng? _selectedLocation;
  String _selectedAddress = '';

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  Future<void> _pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationPickerScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _selectedLocation = result['location'] as LatLng;
        _selectedAddress = result['address'] as String;
      });
    }
  }

  bool _validateForm() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an exam title')),
      );
      return false;
    }
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date')),
      );
      return false;
    }
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time')),
      );
      return false;
    }
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location')),
      );
      return false;
    }
    return true;
  }

  void _saveExam() {
    if (!_validateForm()) return;

    final DateTime examDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final exam = ExamEvent(
      title: _titleController.text,
      dateTime: examDateTime,
      location: _selectedLocation!,
      locationName: _selectedAddress,
    );

    Provider.of<ExamProvider>(context, listen: false).addEvent(exam);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exam saved successfully!')),
    );

    // Navigate back
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exam'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Exam Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : 'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                  ),
                  onTap: _pickDate,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text(
                    _selectedTime == null
                        ? 'Select Time'
                        : 'Time: ${_selectedTime!.format(context)}',
                  ),
                  onTap: _pickTime,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(
                    _selectedLocation == null
                        ? 'Select Location'
                        : 'Location: $_selectedAddress',
                  ),
                  onTap: _pickLocation,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveExam,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save Exam',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}