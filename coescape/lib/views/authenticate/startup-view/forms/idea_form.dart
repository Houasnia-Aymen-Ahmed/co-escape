import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class IdeaForm extends StatefulWidget {
  final Function(Map<String, String>) onFormChanged;
  const IdeaForm({super.key, required this.onFormChanged});

  @override
  State<IdeaForm> createState() => _IdeaFormState();
}

class _IdeaFormState extends State<IdeaForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          showHeading("Idea Title"),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 8.0,
            ),
            child: TextFormField(
              cursorColor: const Color(0xFF10c58c),
              decoration: textInputDecoration.copyWith(
                border: outLineBorder(color: const Color(0xFF10c58c)),
                enabledBorder: outLineBorder(color: const Color(0xFF10c58c)),
                focusedBorder: outLineBorder(color: const Color(0xFF10c58c)),
                filled: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: showHeading("Description"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 8.0,
            ),
            child: TextFormField(
              expands: false,
              minLines: 5,
              maxLines: 15,
              cursorColor: const Color(0xFF10c58c),
              decoration: textInputDecoration.copyWith(
                border: outLineBorder(color: const Color(0xFF10c58c)),
                enabledBorder: outLineBorder(color: const Color(0xFF10c58c)),
                focusedBorder: outLineBorder(color: const Color(0xFF10c58c)),
                filled: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: showHeading("Presentation"),
          ),
        ],
      ),
    );
  }
}
