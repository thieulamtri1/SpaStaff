import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'body.dart';
import 'button.dart';

class DateRangePickerWidget extends StatefulWidget {

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange dateRange;

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange.end);
    }
  }

  @override
  Widget build(BuildContext context) => HeaderWidget(
        title: 'Date Range',
        child: Row(
          children: [
            Expanded(
              child: ButtonWidget(
                text: getFrom(),
                onClicked: () => pickDateRange(context),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: ButtonWidget(
                text: getUntil(),
                onClicked: () => pickDateRange(context),
              ),
            ),
          ],
        ),
      );

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().add(Duration(days: 1)),
      end: DateTime.now().add(Duration(days: 3)),
    );

    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              surface: Colors.orange,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.black45,
          ),
          child: child,
        );
      },
      initialDateRange: dateRange ?? initialDateRange,
    );

    DateTime dateTimeStart = newDateRange.start;
    DateTime dateTimeEnd = newDateRange.end;

    while (dateTimeStart != dateTimeEnd.add(Duration(days: 1))) {
      print(dateTimeStart);
      Body.dateOff = dateTimeStart.toString().substring(0,10);
      dateTimeStart = dateTimeStart.add(Duration(days: 1));
    }


    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }
}
