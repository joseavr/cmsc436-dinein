import 'package:flutter/material.dart';
import 'package:logger/web.dart';

/// Simple preloader inside a Center widget
const preloader =
    Center(child: CircularProgressIndicator(color: Colors.orange));

/// Simple sized box to space out form elements
const formSpacer = SizedBox(width: 16, height: 16);

/// Some padding for all the forms to use
const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 16);

/// Error message to display the user when unexpected error occurs.
const unexpectedErrorMessage = 'Unexpected error occurred.';

final log = Logger();

class ApiResponse<T> {
  final T? data;
  final String? error;

  ApiResponse({this.data, this.error});
}

/// Set of extension methods to easily display a snackbar
// extension ShowSnackBar on BuildContext {
//   /// Displays a basic snackbar
//   void showSnackBar({
//     required String message,
//     Color backgroundColor = Colors.white,
//   }) {
//     ScaffoldMessenger.of(this).showSnackBar(SnackBar(
//       content: Text(message),
//       backgroundColor: backgroundColor,
//     ));
//   }

//   /// Displays a red snackbar indicating error
//   void showErrorSnackBar({required String message}) {
//     showSnackBar(message: message, backgroundColor: Colors.red);
//   }
// }
