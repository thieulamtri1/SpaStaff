import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/booking_for_first_step/components/time_slot.dart';
import 'package:spa_and_beauty_staff/Model/AvailableTime.dart';


class WrapToggleIconButtons extends StatefulWidget {
  final List<TimeSlot> iconList;
  final List<bool> isSelected;
  final List<bool> isDisabled;
  final AvailableTime availableTime;
  final Function onPressed;

  WrapToggleIconButtons({
    @required this.isSelected,
    @required this.onPressed,
    this.iconList,
    this.isDisabled,
    @required  this.availableTime,
  });

  @override
  _WrapToggleIconButtonsState createState() => _WrapToggleIconButtonsState();
}

class _WrapToggleIconButtonsState extends State<WrapToggleIconButtons> {
  int index;

  @override
  Widget build(BuildContext context) {
    assert(widget.iconList.length == widget.isSelected.length);
    index = -1;
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: widget.iconList.map((TimeSlot icon) {
        index++;
        return TimeSlot(
          active: widget.isSelected[index],
          onTap: widget.onPressed,
          index: index,
          isDisable: widget.isDisabled[index],
          time: widget.availableTime.data[index],
        );
      }).toList(),
    );
  }
}
