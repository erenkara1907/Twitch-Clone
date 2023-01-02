// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:twitch_app/resource/firestore_method.dart';
import 'package:twitch_app/responsive/responsive.dart';
import 'package:twitch_app/utils/color.dart';
import 'package:twitch_app/utils/util.dart';
import 'package:twitch_app/view/broadcast_view.dart';
import 'package:twitch_app/widget/app_button.dart';
import 'package:twitch_app/widget/app_textfield.dart';

class GoLiveView extends StatefulWidget {
  const GoLiveView({Key? key}) : super(key: key);
  @override
// ignore: library_private_types_in_public_api
  _GoLiveViewState createState() => _GoLiveViewState();
}

class _GoLiveViewState extends State<GoLiveView> {
  final TextEditingController _titleController = TextEditingController();
  Uint8List? image;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  goLiveStream() async {
    String channelId = await FirestoreMethod().startLiveStream(
      context,
      _titleController.text,
      image,
    );

    if (channelId.isNotEmpty) {
      showSnackBar(context, 'Livestream has started successfully!');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              BroadCastView(isBroadcast: true, channelId: channelId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Responsive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Uint8List? pickedImage = await pickImage();
                        if (pickedImage != null) {
                          setState(() {
                            image = pickedImage;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22.0,
                          vertical: 20.0,
                        ),
                        child: image != null
                            ? SizedBox(
                                height: 300.0,
                                child: Image.memory(image!),
                              )
                            : DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10.0),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                color: buttonColor,
                                child: Container(
                                  width: double.infinity,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    color: buttonColor.withOpacity(.05),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        color: buttonColor,
                                        size: 40.0,
                                      ),
                                      const SizedBox(height: 15.0),
                                      Text(
                                        'Select your thumbnail '.trim(),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.grey.shade400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Title',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AppTextField(controller: _titleController),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: AppButton(onPressed: goLiveStream, text: 'Go Live!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
