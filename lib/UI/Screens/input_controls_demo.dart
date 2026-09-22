import 'package:flutter/material.dart';

// Exercise 2 - Input Widgets: Slider, Switch, RadioListTile, DatePicker
enum Gender { male, female, other }

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _sliderValue = 50;
  bool _switchValue = false;
  Gender _selectedGender = Gender.male;
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    // Chỉ cập nhật khi người dùng thực sự chọn 1 ngày (không bấm Cancel)
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Controls Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Slider - chọn giá trị số
            Text('Slider value: ${_sliderValue.round()}'),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _sliderValue.round().toString(),
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Switch - bật/tắt
            SwitchListTile(
              title: const Text('Bật thông báo'),
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
            const SizedBox(height: 8),
            // RadioListTile group - chọn 1 trong nhiều lựa chọn
            const Text('Giới tính:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<Gender>(
              title: const Text('Nam'),
              value: Gender.male,
              groupValue: _selectedGender,
              onChanged: (value) => setState(() => _selectedGender = value!),
            ),
            RadioListTile<Gender>(
              title: const Text('Nữ'),
              value: Gender.female,
              groupValue: _selectedGender,
              onChanged: (value) => setState(() => _selectedGender = value!),
            ),
            RadioListTile<Gender>(
              title: const Text('Khác'),
              value: Gender.other,
              groupValue: _selectedGender,
              onChanged: (value) => setState(() => _selectedGender = value!),
            ),
            const SizedBox(height: 16),
            // Button mở DatePicker
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: const Text('Chọn ngày'),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedDate == null
                  ? 'Chưa chọn ngày'
                  : 'Ngày đã chọn: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
          ],
        ),
      ),
    );
  }
}
