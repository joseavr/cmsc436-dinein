import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme();

  /// Light theme for the app
  static ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: lightScheme,

    iconTheme: const IconThemeData(color: Color.fromARGB(255, 163, 149, 148)),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return const Color.fromARGB(125, 74, 81, 117); // disabled color
            }
            return const Color.fromARGB(255, 164, 168, 209); // normal color
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.black; // disabled text color
            }
            return Colors.white; // normal text color
          },
        ),
        side: MaterialStateProperty.all(BorderSide.none),
        shape: MaterialStateProperty.all(const StadiumBorder()),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color.fromARGB(125, 74, 81, 117); // disabled color
              }
              return const Color.fromARGB(255, 164, 168, 209); // normal color
            },
          ),
          side: MaterialStateProperty.all(BorderSide.none),
          shape: MaterialStateProperty.all(const StadiumBorder())),
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.black),
      contentPadding: const EdgeInsets.all(10),
      filled: true,
      fillColor: const Color.fromRGBO(243, 241, 241, 1),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: getTextTheme(Brightness.light).bodyMedium,
    ),

    scaffoldBackgroundColor: Colors.white,

    /// Primary color of the app
    // primaryColor: Colors.orange,
    // primaryColorDark: Colors.orange,

    /// Styles for the app bar (top of the screen)
    // appBarTheme: const AppBarTheme(
    //   elevation: 1,
    //   backgroundColor: Colors.white,
    //   iconTheme: IconThemeData(color: Colors.black),
    //   titleTextStyle: TextStyle(
    //     color: Colors.black,
    //     fontSize: 18,
    //   ),
    // ),

    /// Styles for InputDecoration widgets
    // inputDecorationTheme: InputDecorationTheme(
    //   floatingLabelStyle: const TextStyle(
    //     color: Colors.orange,
    //   ),
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(12),
    //     borderSide: const BorderSide(
    //       color: Colors.grey,
    //       width: 2,
    //     ),
    //   ),
    //   focusColor: Colors.orange,
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(12),
    //     borderSide: const BorderSide(
    //       color: Colors.orange,
    //       width: 2,
    //     ),
    //   ),
    // ),

    /// Styles for ElevatedButton widgets
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     foregroundColor: Colors.white,
    //     backgroundColor: Colors.orange,
    //   ),
    // ),

    /// Styles for TextButton widgets
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     foregroundColor: Colors.orange,
    //   ),
    // ),

    // iconTheme:

    /// Styles fo the font size, weight, and color to use when displaying text.
    textTheme: getTextTheme(Brightness.light),
  );

  static ColorScheme lightScheme = const ColorScheme.light().copyWith(
    brightness: Brightness.light,
    //
    background: Colors.white,
    // onBackground: Color(0xff000000),

    primary: Colors.black,
    onPrimary: Colors.white,
    inversePrimary: Colors.grey,
    //
    secondary: Colors.orange.shade400,
    onSecondary: Colors.white,
    //
    // tertiary: Colors.white,
    // onTertiary: Colors.black,
    //
    error: Colors.red.shade700,
    // onError: Color(0xFFf5e9ed),
    //
    // surface: Color(0xFFf4f5fc),
    // onSurface: Color(0xFF0e1016),

    outline: Colors.red,
  );

  // ----------------------------------------------------------

  /// Dark theme for the app
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: darkScheme,
    // iconTheme: const IconThemeData(color: Color.fromARGB(255, 101, 97, 118)),

    // appBarTheme: const AppBarTheme(
    //   elevation: 1,
    //   backgroundColor: Colors.white38,
    //   iconTheme: IconThemeData(color: Color.fromARGB(255, 30, 50, 49)),
    //   titleTextStyle: TextStyle(
    //     color: Colors.white,
    //     fontSize: 20,
    //   ),
    // ),

    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return const Color.fromARGB(
                      125, 74, 81, 117); // disabled color
                }
                return const Color.fromARGB(255, 170, 144, 204); // normal color
              },
            ),
            side: MaterialStateProperty.all(BorderSide.none),
            shape: MaterialStateProperty.all(const StadiumBorder()))),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return const Color.fromARGB(125, 74, 81, 117); // disabled color
            }
            return const Color.fromARGB(255, 170, 144, 204); // normal color
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.black; // disabled text color
            }
            return Colors.white; // normal text color
          },
        ),
        side: MaterialStateProperty.all(BorderSide.none),
        shape: MaterialStateProperty.all(const StadiumBorder()),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 203, 203)),
    textTheme: getTextTheme(Brightness.dark),
  );

  // CHANGE THIS TO YOUR OWN COLOR SCHEME
  static ColorScheme darkScheme = const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      //
      background: const Color.fromARGB(255, 43, 45, 44),
      // onBackground: ,
      //

      primary: const Color.fromARGB(255, 202, 161, 174),
      inversePrimary: const Color.fromARGB(59, 204, 141, 141),

      //
      secondary: const Color.fromARGB(255, 179, 163, 148),
      onSecondary: const Color.fromARGB(255, 199, 130, 131)
      //
      // tertiary: Colors.white,
      // onTertiary: Colors.black,
      //
      // error: ,
      // onError:,
      //
      // surface: ,
      // onSurface:,
      );

  // ----------------------------------------------------------

  static TextTheme getTextTheme(Brightness brightness) {
    const textTheme = TextTheme();

    final bodyFont = GoogleFonts.ibmPlexSansTextTheme(textTheme);
    final headingFont = GoogleFonts.syneMonoTextTheme(textTheme);
    Color textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;
    return bodyFont.copyWith(
      displayLarge: headingFont.displayLarge!.copyWith(color: textColor),
      displayMedium: headingFont.displayMedium!.copyWith(color: textColor),
      displaySmall: headingFont.displaySmall!.copyWith(color: textColor),

      headlineLarge: headingFont.headlineLarge!.copyWith(color: textColor),
      headlineMedium: headingFont.headlineMedium!.copyWith(color: textColor),
      headlineSmall: headingFont.headlineSmall!.copyWith(color: textColor),

      //
      bodyLarge: bodyFont.bodyLarge!.copyWith(
          color: textColor, fontWeight: FontWeight.w800, fontSize: 16),
      bodyMedium: bodyFont.bodyMedium!.copyWith(
          color: textColor, fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: bodyFont.bodySmall!.copyWith(color: textColor),
    );
  }
}
