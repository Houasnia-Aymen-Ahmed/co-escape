import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class StartupForm extends StatefulWidget {
  final Function(Map<String, String>) onFormChanged;
  const StartupForm({super.key, required this.onFormChanged});

  @override
  State<StartupForm> createState() => _StartupFormState();
}

class _StartupFormState extends State<StartupForm> {
  Map<String, String> answers = {};
  bool hasInvestor = false, hasMarketing = false;

  @override
  void initState() {
    super.initState();
    answers['investor'] = 'No';
    answers['marketing'] = 'No';
  }

  Widget showRadioButtons(String key) {
    return Padding(
      padding: const EdgeInsets.only(right: 65.0, left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Radio(
                value: "Yes",
                groupValue: answers[key],
                activeColor: const Color(0xFF10c58c),
                onChanged: (value) {
                  setState(() {
                    answers[key] = value!;
                    widget.onFormChanged(answers);
                  });
                },
              ),
              const Text('Yes'),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "No",
                groupValue: answers[key],
                onChanged: (value) {
                  setState(() {
                    answers[key] = value!;
                    widget.onFormChanged(answers);
                  });
                },
              ),
              const Text('No'),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          showHeading("Do you have an investor?"),
          showRadioButtons('investor'),
          const SizedBox(height: 50),
          showHeading("Do you have a marketing plan?"),
          showRadioButtons('marketing'),
        ],
      ),
    );
  }
}
