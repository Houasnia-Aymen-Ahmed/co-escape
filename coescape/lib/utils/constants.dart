import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/index.dart';
import '../components/loading.dart';

TextStyle txt() {
  return GoogleFonts.poppins(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
}

OutlineInputBorder outLineBorder({Color? color}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: color ?? const Color(0xFFF1F1FA),
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );

final textInputDecoration = InputDecoration(
  hintText: 'Module Name',
  hintStyle: GoogleFonts.poppins(
    fontSize: 15,
    color: Colors.white,
  ),
  filled: false,
  border: outLineBorder(),
  enabledBorder: outLineBorder(),
  focusedBorder: outLineBorder(),
);

final orDivider = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      height: 1,
      width: 100,
      color: Colors.grey,
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        "OR",
        style: GoogleFonts.poppins(
          color: Colors.black,
        ),
      ),
    ),
    Container(
      height: 1,
      width: 100,
      color: Colors.grey,
    ),
  ],
);

void showToast(String message, {gravity = ToastGravity.CENTER}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

Widget showHeading(String headingText) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          width: 4,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF10c58c),
          ),
        ),
      ),
      Text(
        headingText,
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          color: const Color(0xFF10c58c),
        ),
      ),
    ],
  );
}

userAccountDrawerHeader({
  required String username,
  required String email,
  required String profileURL,
  bool hasLogout = false,
  void Function()? onLogout,
}) {
  return Stack(
    children: [
      UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: profileURL,
              placeholder: (context, url) => const Loading(),
              errorWidget: (context, url, error) =>
                  AppImages.defaultProfilePicture,
              fit: BoxFit.contain,
            ),
          ),
        ),
        accountName: Text(
          username,
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        margin: const EdgeInsets.all(8.0),
        accountEmail: Text(
          email,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[700]!,
              Colors.blue[100]!,
            ],
            tileMode: TileMode.decal,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 0.5,
              blurStyle: BlurStyle.normal,
              offset: Offset(0, 3),
            )
          ],
        ),
        arrowColor: Colors.black,
      ),
      if (hasLogout)
        Positioned(
          top: 16.0,
          right: 16.0,
          child: IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.blue[900]!,
            ),
            onPressed: onLogout,
          ),
        ),
    ],
  );
}

var dropDownTextStyle = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.w500,
);

String capitalizeFirst(String input) {
  if (input.length <= 1) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

String? capitalizeWords(String? input) {
  if (input == null || input.isEmpty) {
    return input;
  }

  List<String> words = input.split(' ');

  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] =
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }
  }

  return words.join(' ');
}

DropdownButtonFormField<String> dropDownBtn({
  required hint,
  required items,
  String? val,
  void Function(String?)? onChanged,
  String? Function(String?)? validator,
}) {
  return DropdownButtonFormField<String>(
    elevation: 16,
    dropdownColor: const Color(0xFF10C58C),
    borderRadius: BorderRadius.circular(16),
    value: val,
    decoration: InputDecoration(
      filled: false,
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF91919F),
      ),
      border: outLineBorder(),
      focusedBorder: outLineBorder(),
      enabledBorder: outLineBorder(),
      alignLabelWithHint: true,
    ),
    style: const TextStyle(backgroundColor: Colors.transparent),
    onChanged: onChanged,
    validator: validator,
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          capitalizeFirst(value),
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      );
    }).toList(),
  );
}

void showLoadingDialog(
  BuildContext context,
  String content,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(content),
          ],
        ),
      );
    },
  );
}

void showDialogBox(
  BuildContext context,
  String title,
  String content,
  bool isError,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: isError ? Colors.red : Colors.green,
        ),
      ),
      content: Text(
        content,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            if (isError) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    ),
  );
}

Future<bool?> infoToast(String msg, {gravity = ToastGravity.CENTER}) async {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    fontSize: 20.0,
    backgroundColor: Colors.blue[700],
    textColor: Colors.white,
  );
  return null;
}

Widget drawerFooter() => Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Houasnia-Aymen-Ahmed\n© 2023-${DateTime.now().year} All rights reserved",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );

void showSnackBar(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20.0),
      backgroundColor: color,
      dismissDirection: DismissDirection.startToEnd,
      elevation: 20.0,
      content: Text(text),
      action: SnackBarAction(
        textColor: Colors.blue[100],
        label: 'OK',
        onPressed: () {},
      ),
    ),
  );
}
