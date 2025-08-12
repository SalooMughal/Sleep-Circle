// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// class ExceptionHandler extends StatelessWidget {
//   final Future Function() futureFunction;
//
//   const ExceptionHandler({
//     Key? key,
//     required this.futureFunction,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: futureFunction(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return child;
//         } else if (snapshot.hasError) {
//           // Check if the error is an HTTP exception
//           if (snapshot.error is HttpException) {
//             return onError(context, 'HTTP Error: ${snapshot.error}');
//           } else {
//             return onError(context, 'Error: ${snapshot.error}');
//           }
//         } else {
//           return snapshot.data ?? child;
//         }
//       },
//     );
//   }
// }
