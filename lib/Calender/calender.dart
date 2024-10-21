import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Calender/addNote.dart';
import 'package:project/components/custom_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(CalenderApp());

class CalenderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: CalenderScreen(),
    );
  }
}

class CalenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "돌봄 다이어리",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CalendarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, String> _notes = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime(2000),
          lastDay: DateTime(2100),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) async {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });

            // 새로운 메모 추가 화면으로 이동
            final newNote = await Get.to(
                    ()=> AddNoteScreen(selectedDay: selectedDay)
            );

            if (newNote != null) {
              setState(() {
                _notes[selectedDay] = newNote;
              });
            }
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
        ),
        if (_selectedDay != null && _notes.containsKey(_selectedDay))
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "메모: ${_notes[_selectedDay]}",
              style: TextStyle(fontSize: 16),
            ),
          ),
      ],
    );
  }
}
