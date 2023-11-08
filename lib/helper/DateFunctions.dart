class DateFunctions{

  static String fromDatetoFormat(DateTime dateTime){
    String year=dateTime.toString().split(" ")[0].split("-")[0];
    String month=dateTime.toString().split(" ")[0].split("-")[1];
    String day=dateTime.toString().split(" ")[0].split("-")[2];
    return day+"/"+month+"/"+year;
  }
}