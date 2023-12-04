import 'dart:io';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_croup/view/crop_image.dart';

bool filpx = false;
final controller = CropController();

class ImageShow extends StatefulWidget {
  final File cropArgs;
  const ImageShow({super.key, required this.cropArgs});

  @override
  State<ImageShow> createState() => _ImageShowState();
}

class _ImageShowState extends State<ImageShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80.h),
          child: Transform.flip(
            flipX: filpx,
            child: CropImage(
              controller: controller,
              alwaysMove: true,
              gridColor: Colors.deepOrange.shade900,
              gridCornerSize: 35,
              gridCornerColor: Colors.deepOrange,
              gridInnerColor: Colors.deepOrange,
              gridThickWidth: 6,
              //   alwaysShowThirdLines: false,
              image: Image.file(
                widget.cropArgs,
                height: 400.h,
                width: 360.w,
                fit: BoxFit.fill,
              ),
            ),
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.history, size: 30.r),
              onPressed: () {
                controller.rotation = CropRotation.up;
                controller.crop = const Rect.fromLTRB(0.0, 0.0, 1, 1);
                setState(() {
                  filpx = false;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.rotate_left, size: 30.r),
              onPressed: rotateImage,
            ),
            IconButton(
              icon: Icon(Icons.move_up_outlined, size: 30.r),
              onPressed: () {
                setState(() {
                  filpx = !filpx;
                });
              },
            ),
            MaterialButton(
              height: 35.h,
              minWidth: 120.w,
              color: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              onPressed: () async {
                cropImageDone();
              },
              child: const Text(
                'Crop ',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ),
      ]),
    );
  }


  Future<void> rotateImage() async => controller.rotateLeft();
  Future<void> cropImageDone() async {
    final image = await controller.croppedImage();
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CroupImage(imagevalue: image),
        ));
  }
}
