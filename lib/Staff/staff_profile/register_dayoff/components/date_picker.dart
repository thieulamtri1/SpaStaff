import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'body.dart';
import 'button.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime date;

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      Body.dateOffList.add(date.toString().substring(0,10));
      return DateFormat('MM/dd/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
    title: 'Date',
    text: getText(),
    onClicked: () => pickDate(context),
  );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now().add(Duration(days: 1));
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }
}
