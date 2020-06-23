import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:basics/basics.dart';

class ProfilePicturePicker extends StatefulWidget {
  @override
  _ProfilePicturePickerState createState() => _ProfilePicturePickerState();
}

class _ProfilePicturePickerState extends State<ProfilePicturePicker> {
  CameraController controller;

  @override
  void initState() {
    setupCamera();
    super.initState();
  }

  void setupCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    controller = CameraController(cameras[1], ResolutionPreset.max);
    await controller.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        // fit: StackFit.expand,
        children: [
          if (controller.isNotNull) ...[
            AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller)),
            CustomPaint(
                painter: CutoutPainter(), size: MediaQuery.of(context).size)
            // ClipRRect(
            //     clipper: CutoutClipper(),
            //     child: Container(color: Colors.black87))
          ] else
            YOMSpinner()
        ],
      ),
    );
  }
}

// class CutoutClipper extends CustomClipper<RRect> {
//   @override
//   RRect getClip(Size size) {
//     return RRect.fromLTRBR(50, 50, 20, 20, Radius.circular(50));
//   }

//   @override
//   bool shouldReclip(CustomClipper<RRect> oldClipper) {
//     return true;
//   }
// }

class CutoutPainter extends CustomPainter {
  final YomDesign yomDesign = YomDesign();
  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    Offset center = size.center(Offset(0, 0));
    Paint backgroundPaint = Paint()..color = Colors.black87;
    Paint linePaint = Paint()
      ..color = yomDesign.yomWhite2
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCircle(center: center, radius: 150), Radius.circular(15)),
        linePaint);
    // canvas.drawRect(Rect.largest, backgroundPaint);
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addRect(Rect.fromCenter(
              center: center, height: size.height, width: size.width)),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              Rect.fromCircle(center: center, radius: 150),
              Radius.circular(15)))
          ..close(),
      ),
      backgroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
