// Custom render functions from see all/categories view etc

String greetingMessage() {
  var hour = DateTime.now().hour;

  if (hour <= 12) {
    return 'Good morning';
  } else if ((hour > 12) && (hour <= 16)) {
    return 'Good afternoon';
  } else if ((hour > 16) && (hour < 20)) {
    return 'Good evening';
  } else {
    return 'Hello';
  }
}

//