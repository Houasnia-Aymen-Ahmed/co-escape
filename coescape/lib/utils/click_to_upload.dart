import 'package:flutter/material.dart';

import '../services/storage.dart';

class ClickToUpload extends StatefulWidget {
  const ClickToUpload({super.key});

  @override
  State<ClickToUpload> createState() => _ClickToUploadState();
}

class _ClickToUploadState extends State<ClickToUpload> {
  late FirebaseStorageService storageService;
  bool isLoading = false;
  bool? isError;

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  if (!isLoading && isError != null)
                    Row(children: [
                      Icon(
                        isError! ? Icons.error : Icons.check_circle,
                        color: isError! ? Colors.red : Colors.green,
                      ),
                      Text(
                        isError! ? "Error" : "Success",
                        style: TextStyle(
                          color: isError! ? Colors.red : Colors.green,
                        ),
                      )
                    ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
