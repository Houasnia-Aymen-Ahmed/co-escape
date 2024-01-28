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

OutlineInputBorder outLineBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.blue[900]!,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );

final textInputDecoration = InputDecoration(
  hintText: 'Module Name',
  hintStyle: GoogleFonts.poppins(
    fontSize: 15,
    color: Colors.black38,
  ),
  filled: true,
  border: outLineBorder(),
  enabledBorder: outLineBorder(),
  focusedBorder: outLineBorder(),
);

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
  bool isDisabled = false,
  bool? isExpanded,
  bool? filled = false,
  String? val,
  Color? textColor,
  void Function(String?)? onChanged,
  String? Function(String?)? validator,
}) {
  dynamic items = ["list of items"];

  return DropdownButtonFormField<String>(
    padding: const EdgeInsets.all(8.0),
    elevation: 16,
    isExpanded: isExpanded ?? false,
    dropdownColor: Colors.blue[100],
    borderRadius: BorderRadius.circular(15),
    value: val,
    decoration: InputDecoration(
      filled: filled,
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 15,
        color: isDisabled ? Colors.black38 : Colors.blue[900],
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
            color: textColor ?? Colors.black,
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

Future<bool?> infoTost(String msg) async {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
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
