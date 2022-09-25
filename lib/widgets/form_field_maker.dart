import 'package:flutter/material.dart';
import 'package:greens_veges/theme/app_theme.dart';

// Widget makeInput({label, obsureText =false, currentValue = "",icon}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: const TextStyle(
//             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//       ),
//       const SizedBox(
//         height: 5,
//       ),
//       TextFormField(
//         obscureText: obsureText,
//         initialValue: currentValue,
//         autocorrect: true,
//         decoration: const InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: AppTheme.primaryColor,
//             ),
//           ),
//           border: OutlineInputBorder(
//               borderSide: BorderSide(color: AppTheme.primaryColor)),
//         ),
//       ),
//       const SizedBox(
//         height: 30,
//       )
//     ],
//   );
// }

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
      prefixIcon: Icon(icon),
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ));
}

Material submitButton(String title, Function() function) {
  return Material(
    elevation: 5,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    color: AppTheme.primaryColor,
    child: MaterialButton(
      onPressed: function,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: double.infinity,
      child: Text(
        title,
        style: const TextStyle(
            color: AppTheme.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    ),
  );
}
