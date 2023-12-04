import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_croup/view/image_show.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class CroupImage extends StatefulWidget {
  Image imagevalue;
  CroupImage({super.key, required this.imagevalue});

  @override
  State<CroupImage> createState() => _CroupImageState();
}

class _CroupImageState extends State<CroupImage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Transform.flip(flipX: filpx, child: widget.imagevalue),
        SizedBox(height: 30.h),
        Center(
          child: ElevatedButton(
            onPressed: () {
              imagePickDialog(context: context);
            },
            child: const Text("ImageCroup"),
          ),
        ),
      ]),
    );
  }

  ///ImagePickDialogBox Open
  Future imagePickDialog({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.r))),
          actionsPadding: EdgeInsets.symmetric(vertical: 20.h),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 30.r),
                const Center(
                    child: Text(
                  "Choose option \n Upload Image",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
                Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.all(18.r),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: () {
                                  pickImageOptions(ImageSource.camera);
                                },
                                child: const Icon(Icons.camera_alt))),
                        SizedBox(height: 10.h),
                        const Text("Camera"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.all(18.r),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                pickImageOptions(ImageSource.gallery);
                              },
                              child: const Icon(Icons.image),
                            )),
                        SizedBox(height: 10.h),
                        const Text("Gallery"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  ///ImagePicK options Method
  Future<void> pickImageOptions(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageShow(cropArgs: File(pickedImage.path)),
        ),
      );
    }
  }
}
