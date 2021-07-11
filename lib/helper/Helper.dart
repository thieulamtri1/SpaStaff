


import 'package:intl/intl.dart';


class  MyHelper{
  static String getUserDateFromString(String date){
    DateFormat formatter = new DateFormat("yyyy-MM-dd");
    DateTime bookedDate = formatter.parse(date);
    return bookedDate.day.toString()+"/"+bookedDate.month.toString()+"/"+bookedDate.year.toString();
  }
  static String getUserDate(DateTime date){
    return date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
  }
  static String getMachineDate(DateTime date){
    String day;
    String month;
    if(date.day < 10){
      day = "0"+date.day.toString();
    }else{
      day = date.day.toString();
    }
    if(date.month < 10){
      month = "0"+date.month.toString();
    } else{
      month = date.month.toString();
    }
    return date.year.toString()+ "-" + month +"-"+ day;
  }


  // static bool checkIsPendingInDate(Appointment appointment){
  //   bool isPendingExist = false;
  //   for (int i = 0; i < appointment.listScheduleGoSpaItems.length; i++){
  //     if(appointment.listScheduleGoSpaItems[i].booking.status=="pending"){
  //       isPendingExist = true;
  //     }
  //   }
  //   return isPendingExist;
  // }
  // static bool checkIsAssignedInDate(Appointment appointment){
  //   bool isAssignedExist = false;
  //   for (int i = 0; i < appointment.listScheduleGoSpaItems.length; i++){
  //     if(appointment.listScheduleGoSpaItems[i].booking.status=="assigned"){
  //       isAssignedExist = true;
  //     }
  //   }
  //   return isAssignedExist;
  // }

  static String dayOfWeekToText(int dayOfWeek){
    return dayOfWeek == 1
        ? "MON"
        : dayOfWeek == 2
        ? "TUE"
        : dayOfWeek == 3
        ? "WED"
        : dayOfWeek == 4
        ? "THU"
        : dayOfWeek == 5
        ? "FRI"
        : dayOfWeek == 6
        ? "SAT"
        : "SUN";
  }
}