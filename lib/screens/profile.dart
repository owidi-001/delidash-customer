// import 'package:flutter/material.dart';
// import 'package:greens_veges/constants/app_theme.dart';
// import 'package:greens_veges/models/user.model.dart';
// import 'package:greens_veges/providers/user.provider.dart';
// import 'package:greens_veges/utils/routes.dart';
// import 'package:provider/provider.dart';

// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {

//     User user = Provider.of<UserProvider>(context).user;
    
//     return Scaffold(
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 36,
//           ),
//           Container(
//             margin: const EdgeInsets.all(8.0),
//             decoration: const BoxDecoration(
//                 color: AppTheme.lightColor,
//                 borderRadius: BorderRadius.all(Radius.circular(24))),
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 44,
//                   ),
//                   CircleAvatar(
//                     backgroundColor: AppTheme.whiteColor,
//                     radius: 50,
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Image.asset(
//                           // widget.user.profileImage,
//                           "assets/images/user.png"),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 32,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Text(
//                       "${user.first_name} ${user.last_name}",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                           fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 32),
//                     child: Text(
//                       user.email,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14,
//                           color: AppTheme.secondaryColor),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 36,
//                   ),
//                   FractionallySizedBox(
//                     widthFactor: 0.5,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushReplacementNamed(
//                               context, MyRoutes.profileEditRoute);
//                         },
//                         style: TextButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           textStyle: const TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w500),
//                           shape: const StadiumBorder(),
//                           backgroundColor: AppTheme.primaryColor,
//                         ),
//                         child: const Text("Edit Profile")),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
