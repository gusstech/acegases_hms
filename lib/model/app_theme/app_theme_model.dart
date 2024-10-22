import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class ThemeModel {
  AppTheme _currentTheme = AppTheme.light;

  AppTheme get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme =
        _currentTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
  }

  ThemeData getTheme() {
    return _currentTheme == AppTheme.light ? lightTheme : darkTheme;
  }

  // Define the base color
  static const Color darkPurple = Color.fromARGB(255, 218, 55, 50);

  static const Color darkPurpleOld = Color.fromARGB(255, 218, 55, 50);
  // Define light theme
  static final lightTheme = ThemeData(
    extensions: const <ThemeExtension>[ExtendColors.light],
    brightness: Brightness.light,
    navigationBarTheme: NavigationBarThemeData(
        iconTheme:
            MaterialStatePropertyAll(IconThemeData(color: Colors.black))),
    primaryColor: darkPurple, // Dark purple as primary color
    scaffoldBackgroundColor: Colors.white, // White background

    textSelectionTheme: TextSelectionThemeData(
      selectionColor: const Color.fromARGB(255, 95, 147, 238),
      selectionHandleColor: const Color.fromARGB(255, 95, 147, 238),
      cursorColor: const Color.fromARGB(255, 95, 147, 238),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
      ), // Dark gray text
      bodyMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
      ), // Dark gray text
      bodySmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
      ),
      displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black), // Large bold headline
      titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: darkPurple), // App bar title
      // bodySmall: TextStyle(fontSize: 12, color: Colors.grey), // Caption text
    ),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return Color.fromARGB(255, 20, 108, 180);
      }
      if (states.contains(MaterialState.selected)) {
        return Color.fromARGB(255, 20, 108, 180);
      }
      return null;
    })),

    appBarTheme: AppBarTheme(
      backgroundColor: darkPurple, // Dark purple app bar background
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarTextStyle: const TextTheme(
        titleLarge: TextStyle(color: Colors.white), // White app bar title
      ).bodyMedium,
      titleTextStyle: const TextTheme(
        titleLarge: TextStyle(color: Colors.white), // White app bar title
      ).titleLarge,
    ),
    dividerTheme: DividerThemeData(color: Colors.black54),
    dividerColor: Colors.black87,
    iconTheme: IconThemeData(color: Colors.black),
    buttonTheme: ButtonThemeData(
      buttonColor: darkPurple, // Dark purple buttons
      textTheme: ButtonTextTheme.primary, // Use primary color for button text
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)), // Button shape
      padding: const EdgeInsets.symmetric(
          vertical: 16, horizontal: 24), // Button padding
    ),
    indicatorColor: Color.fromARGB(255, 95, 147, 238),

    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
          const Color(0xFFE91E63)), // Vibrant pink thumb
      trackColor: MaterialStateProperty.all(
          const Color(0xFFE91E63).withOpacity(0.5)), // Lighter pink track
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFE91E63), // Vibrant pink FAB background color
      elevation: 4, // Default elevation for FABs
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return Color.fromARGB(255, 20, 108, 180);
        }
        if (states.contains(MaterialState.selected)) {
          return Color.fromARGB(255, 20, 108, 180);
        }
      }),
    ),

    cardTheme: CardTheme(
      elevation: 2, // Default elevation for cards
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Default card shape
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor:
          Colors.blueGrey.shade50, // Default dialog background color
      // titleTextStyle:
      //     const TextStyle(color: darkPurple), // Default dialog title text color
      contentTextStyle: const TextStyle(
          color: Colors.black87), // Default dialog content text color
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)), // Dialog shape
    ),
    scrollbarTheme: ScrollbarThemeData(
        trackBorderColor: MaterialStatePropertyAll(Colors.white),
        thumbColor: MaterialStatePropertyAll(Colors.white),
        trackColor: MaterialStatePropertyAll(Colors.white)),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle:
                MaterialStatePropertyAll(TextStyle(color: Colors.black)))),
    inputDecorationTheme: InputDecorationTheme(
      // Define the input decoration properties for TextFormField
      border: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.black),
      ),
      suffixIconColor: Colors.black,
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(
        // Border when the TextFormField is focused
        // borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Color.fromARGB(255, 45, 94, 177)),
      ),
      // fillColor: Colors.grey.shade200, // Background color of the TextFormField
      // filled: true, // Whether the TextFormField should be filled with fillColor
      hintStyle: TextStyle(color: Colors.black), // Style for the hint text
      floatingLabelStyle:
          TextStyle(color: const Color.fromARGB(255, 6, 114, 202)),
      labelStyle: TextStyle(color: Colors.black), // Style for the label text
      errorStyle: TextStyle(color: Colors.red), // Style for error text
    ),
    // Add more theme configurations as needed...
  );

  // Define dark theme
  static final darkTheme = ThemeData(
    extensions: const <ThemeExtension>[ExtendColors.dark],
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return Color.fromARGB(255, 20, 108, 180);
      }
      if (states.contains(MaterialState.selected)) {
        return Color.fromARGB(255, 20, 108, 180);
      }
      return null;
    })),
    brightness: Brightness.dark,
    primaryColor: darkPurpleOld, // Dark purple as primary color
    scaffoldBackgroundColor: Colors.black, // Black background
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle:
                MaterialStatePropertyAll(TextStyle(color: Colors.white)))),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: const Color.fromARGB(255, 95, 147, 238),
      selectionHandleColor: const Color.fromARGB(255, 95, 147, 238),
      cursorColor: const Color.fromARGB(255, 95, 147, 238),
    ),
    indicatorColor: Color.fromARGB(255, 95, 147, 238),
    dividerColor: Colors.white70,
    dividerTheme: DividerThemeData(color: Colors.white60),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
      ), // White text
      bodyMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
      ), // Dark gray text
      bodySmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
      ),
      displayLarge: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: Colors.white), // Large bold headline
      titleLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: Colors.white), // App bar title
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkPurpleOld, // Dark purple app bar background
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarTextStyle: const TextTheme(
        titleLarge: TextStyle(color: Colors.white), // White app bar title
      ).bodyMedium,
      titleTextStyle: const TextTheme(
        titleLarge: TextStyle(color: Colors.white), // White app bar title
      ).titleLarge,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return Color.fromARGB(255, 20, 108, 180);
        }
        if (states.contains(MaterialState.selected)) {
          return Color.fromARGB(255, 20, 108, 180);
        }
      }),
    ),
    scrollbarTheme: ScrollbarThemeData(
        trackBorderColor: MaterialStatePropertyAll(Colors.white),
        thumbColor: MaterialStatePropertyAll(Colors.white),
        trackColor: MaterialStatePropertyAll(Colors.white)),
    iconTheme: IconThemeData(color: Colors.white),
    buttonTheme: ButtonThemeData(
      buttonColor: darkPurpleOld, // Dark purple buttons
      textTheme: ButtonTextTheme.primary, // Use primary color for button text
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)), // Button shape
      padding: const EdgeInsets.symmetric(
          vertical: 16, horizontal: 24), // Button padding
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
          const Color(0xFFFFC107)), // Vibrant yellow thumb
      trackColor: MaterialStateProperty.all(
          const Color(0xFFFFC107).withOpacity(0.5)), // Lighter yellow track
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFFC107), // Vibrant yellow FAB background color
      elevation: 4, // Default elevation for FABs
    ),
    cardTheme: CardTheme(
      color: Colors.white12,
      elevation: 2, // Default elevation for cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Default card shape
      ),
    ),

    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey.shade900, // Default dialog background color
      titleTextStyle: const TextStyle(
          color: Colors.white), // Default dialog title text color
      contentTextStyle: const TextStyle(
          color: Colors.white), // Default dialog content text color
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)), // Dialog shape
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.white,
      // Define the input decoration properties for TextFormField
      border: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
        // Border when the TextFormField is focused
        // borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.blue),
      ),
      // fillColor: darkPurpleOld
      //     .withOpacity(0.7), // Background color of the TextFormField
      // filled: true, // Whether the TextFormField should be filled with fillColor

      floatingLabelStyle: TextStyle(color: Colors.blue),
      hintStyle: TextStyle(color: Colors.white), // Style for the hint text
      // labelStyle: TextStyle(color: Colors.black), // Style for the label text
      errorStyle: TextStyle(color: Colors.red), // Style for error text
    ),
    // Add more theme configurations as needed...
  );
}

class ExtendColors extends ThemeExtension<ExtendColors> {
  final Color testColor;
  final Color activeBaseIcon;
  final Color buttonBackgroundColor;
  final Color buttonCancelColor;
  final Color cardTextIndicator;
  final Color? color2;
  final Color? color3;
  final Color lightenBgColor;

  const ExtendColors({
    required this.testColor,
    required this.activeBaseIcon,
    required this.buttonBackgroundColor,
    required this.buttonCancelColor,
    this.color2,
    this.color3,
    required this.cardTextIndicator,
    required this.lightenBgColor,
  });

  @override
  ExtendColors copyWith({
    Color? testColor,
    Color? activeBaseIcon,
    Color? buttonBackgroundColor,
    Color? buttonCancelColor,
    Color? cardTextIndicator,
    Color? color2,
    Color? color3,
    Color? lightenBgColor,
  }) {
    return ExtendColors(
      testColor: testColor ?? this.testColor,
      activeBaseIcon: activeBaseIcon ?? this.activeBaseIcon,
      buttonBackgroundColor:
          buttonBackgroundColor ?? this.buttonBackgroundColor,
      buttonCancelColor: buttonCancelColor ?? this.buttonCancelColor,
      color2: color2 ?? this.color2,
      color3: color3 ?? this.color3,
      cardTextIndicator: cardTextIndicator ?? this.cardTextIndicator,
      lightenBgColor: lightenBgColor ?? this.lightenBgColor,
    );
  }

  @override
  ExtendColors lerp(ThemeExtension<ExtendColors>? other, double t) {
    if (other == null || other is! ExtendColors) {
      return this;
    }
    return ExtendColors(
      testColor: Color.lerp(testColor, other.testColor, t) ?? testColor,
      activeBaseIcon:
          Color.lerp(activeBaseIcon, other.activeBaseIcon, t) ?? activeBaseIcon,
      buttonBackgroundColor:
          Color.lerp(buttonBackgroundColor, other.buttonBackgroundColor, t) ??
              buttonBackgroundColor,
      buttonCancelColor:
          Color.lerp(buttonCancelColor, other.buttonCancelColor, t) ??
              buttonCancelColor,
      cardTextIndicator:
          Color.lerp(cardTextIndicator, other.cardTextIndicator, t) ??
              cardTextIndicator,
      color2: Color.lerp(color2, other.color2, t) ?? color2,
      color3: Color.lerp(color3, other.color3, t) ?? color3,
      lightenBgColor:
          Color.lerp(lightenBgColor, other.lightenBgColor, t) ?? lightenBgColor,
    );
  }

  static const light = ExtendColors(
    testColor: Color(0xFF28A745),
    activeBaseIcon: Color.fromARGB(255, 45, 94, 177),
    buttonBackgroundColor: Color.fromARGB(255, 45, 94, 177),
    buttonCancelColor: Color.fromARGB(255, 244, 67, 54),
    color2: Colors.black,
    cardTextIndicator: Color.fromARGB(255, 97, 97, 97),
    color3: Colors.white,
    lightenBgColor: Colors.white54,
  );

  static const dark = ExtendColors(
    testColor: Color.fromARGB(255, 13, 74, 27),
    activeBaseIcon: Color.fromARGB(255, 88, 135, 212),
    buttonBackgroundColor: Color.fromARGB(255, 88, 135, 212),
    buttonCancelColor: Color.fromARGB(255, 193, 42, 31),
    color2: Colors.white,
    cardTextIndicator: Color.fromARGB(255, 189, 189, 189),
    color3: Color.fromARGB(
      255,
      33,
      33,
      33,
    ),
    lightenBgColor: Colors.black54,
  );
}
