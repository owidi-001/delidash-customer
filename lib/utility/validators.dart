String? validEmail(String email) {
  String? message;

  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  // Null or empty email is invalid
  if (email.isEmpty) {
    message = "Your email is required";
  } else if (!regExp.hasMatch(email)) {
    message = "Please provide a valid email address!";
  }
  return message;
}

// Email validator
// (value) {
//    if (value!.isEmpty) {
//      return "Email field required!";
//    }
//    if (!RegExp(
//            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//        .hasMatch(value)) {
//      return "Enter a valid email address";
//    }
//    return null;
// }

String? validPhone(String phone) {
  String? message;

  const pattern = r"^0(7(?:(?:[129][0-9])|(?:0[0-8])|(4[0-1]))[0-9]{6})$";
  final regExp = RegExp(pattern);

  // Null or empty phone is invalid
  if (phone.isEmpty) {
    message = "Your phone number is required";
  } else if (!regExp.hasMatch(phone)) {
    message = "Please provide a valid phone number!";
  }
  return message;
}

String? validPassword(String password) {
  String? message;

  const pattern = r"^.{8,}$";
  final regExp = RegExp(pattern);

  // Null or empty password is invalid
  if (password.isEmpty) {
    message = "Password field required!";
  } else if (!regExp.hasMatch(password)) {
    message = "Enter a strong password (> 8 characters)";
  }
  return message;
}

String? passwordMatch(String password1, String password2) {
  String? message;

  if (!password1.endsWith(password2)) {
    message = "Password Mismatch!";
  }

  return message;
}
