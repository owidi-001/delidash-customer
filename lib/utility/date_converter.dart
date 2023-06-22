String convertDate(String date) {
  DateTime dateConverted = DateTime.parse(date);

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return "${months[dateConverted.month - 1]} ${dateConverted.day.toString()}/${dateConverted.year.toString()} at ${dateConverted.hour}:${dateConverted.minute}";
}
