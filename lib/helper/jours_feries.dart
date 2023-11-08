class JoursFeries{
  static bool isHoliday(DateTime day){
    return ((day.day == 1) && (day.month==1))
        ||((day.day == 28) && (day.month==3))
        ||((day.day == 9) && (day.month==4))
        ||((day.day == 1) && (day.month==5))
        ||((day.day == 9) && (day.month==7))
        ||((day.day == 10) && (day.month==7))
        ||((day.day == 11) && (day.month==7))
        ||((day.day == 25) && (day.month==7))
        ||((day.day == 29) && (day.month==7))
        ||((day.day == 30) && (day.month==7))
        ||((day.day == 13) && (day.month==8))
        ||((day.day == 7) && (day.month==10))
        ||((day.day == 8) && (day.month==10))
        ||((day.day == 15) && (day.month==10))
        ||((day.day == 17) && (day.month==12))
        ||(day.weekday==7)||(day.weekday==6);
  }

}