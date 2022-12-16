String convertTime(String time) {
  var timeList = time.split(":");
  var k = int.parse(timeList[0]) > 12 ? "PM" : "Am";
  return "${timeList[0]} ${timeList[1]} $k";
}
