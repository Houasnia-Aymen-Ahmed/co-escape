import 'package:flutter/material.dart';

import '../services/storage.dart';

class ClickToUpload extends StatefulWidget {
  final Function(bool) onErrorChanged;
  const ClickToUpload({super.key, required this.onErrorChanged});

  @override
  State<ClickToUpload> createState() => _ClickToUploadState();
}

class _ClickToUploadState extends State<ClickToUpload> {
  late FirebaseStorageService storageService;
  bool isLoading = false, isError = false;

  @override
  void initState() {
    super.initState();
    storageService = FirebaseStorageService();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 356,
        maxHeight: 143,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0xFF10c58c),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          bool value = await storageService.uploadFile();
                          setState(() {
                            isLoading = false;
                            isError = value;
                            widget.onErrorChanged(value);
                          });
                        },
                        icon: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF10c58c),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.add_outlined,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        child: Text("Click to upload"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
