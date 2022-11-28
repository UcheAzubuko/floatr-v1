import 'dart:ui' as ui;
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/custom_appbar.dart';

class SnapDocumentScreen extends StatelessWidget {
  const SnapDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        useInAppArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: context.widthPx,
          child: Column(
            children: [
              Container(
                height: 190,
                width: context.widthPx,
                decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
                // child: CustomPaint(
                //   painter: MyCustomPainter(frameSFactor: .1, padding: 20),
                //   // child: const Center(
                //   //   child: Text(
                //   //     'With Painter',
                //   //     style: TextStyle(
                //   //       color: Colors.black,
                //   //       fontSize: 30,
                //   //     ),
                //   //   ),
                //   // ),
                // ),
                child: Stack(
                  children: [
                    Container(
                height: 190,
                width: context.widthPx,
                decoration: BoxDecoration(border: Border.all(color: Colors.red)),),

                    Align(alignment: Alignment(-1.02, -1.1), child: CustomPaint(child: Container(height: 50, width: 40,), size: Size(10, (10*1).toDouble()),painter: RPSCustomPainter(),)), // first corner
                    Align(alignment: Alignment(1.02, -1.1), child: Text('T')),
                    Align(alignment: Alignment(1.02, 1.1), child: CustomPaint(child: Container(height: 50, width: 40,), size: Size(10, (10*1).toDouble()),painter: RPSCustomPainter(),)),
                    Align(alignment: Alignment(-1.041, 1.092), child: CustomPaint(child: Container(height: 40, width: 40,), size: Size(5, (5*1).toDouble()),painter: RPSCustomPainter(),)),
                  ],
                ),
              ).paddingOnly(top: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyCustomPainter extends CustomPainter {
//   final double padding;
//   final double frameSFactor;

//   MyCustomPainter({
//     required this.padding,
//     required this.frameSFactor,
//   });
//   @override
//   void paint(Canvas canvas, Size size) {
//     final frameHWidth = size.width * frameSFactor;

//     Paint paint = Paint()
//       ..color = Colors.redAccent
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 4;

//     var paint1 = Paint()
//       ..color = Color(0xff63aa65)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 5;

//     // /// background
//     // canvas.drawRRect(
//     //     RRect.fromRectAndRadius(
//     //       Rect.fromLTRB(0, 0, size.width, size.height),
//     //       const Radius.circular(18),
//     //     ),
//     //     paint);

//     /// top left
//     canvas.drawLine(
//       Offset(0 + padding, padding),
//       Offset(
//         padding + frameHWidth,
//         padding,
//       ),
//       paint..color = Colors.black,
//     );

//     canvas.drawLine(
//       Offset(0 + padding, padding),
//       Offset(
//         padding,
//         padding + frameHWidth,
//       ),
//       paint..color = Colors.black,
//     );

//     /// top Right
//     canvas.drawLine(
//       Offset(size.width - padding, padding),
//       Offset(size.width - padding - frameHWidth, padding),
//       paint..color = Colors.black,
//     );
//     canvas.drawLine(
//       Offset(size.width - padding, padding),
//       Offset(size.width - padding, padding + frameHWidth),
//       paint..color = Colors.black,
//     );

//     /// Bottom Right
//     //  canvas.drawArc(Offset(200, 100) & Size(100, 100),
//     //     6, //radians
//     //     2, //radians
//     //     false,
//     //     paint1);
//     canvas.drawLine(
//       Offset(size.width - padding, size.height - padding),
//       Offset(size.width - padding - frameHWidth, size.height - padding),
//       // paint..color = Colors.black,
//       paint1
//     );
//     canvas.drawLine(
//       Offset(size.width - padding, size.height - padding),
//       Offset(size.width - padding, size.height - padding - frameHWidth),
//       paint..color = Colors.black,
//     );

//     /// Bottom Left
//     canvas.drawLine(
//       Offset(0 + padding, size.height - padding),
//       Offset(0 + padding + frameHWidth, size.height - padding),
//       paint..color = Colors.black,
//     );
//     canvas.drawLine(
//       Offset(0 + padding, size.height - padding),
//       Offset(0 + padding, size.height - padding - frameHWidth),
//       paint..color = Colors.black,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) =>
//       true; //based on your use-cases
// }




//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*1).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width,size.height*0.9090909);
    path_0.lineTo(size.width*0.5454545,size.height*0.9090909);
    path_0.cubicTo(size.width*0.2944159,size.height*0.9090909,size.width*0.09090909,size.height*0.7055818,size.width*0.09090909,size.height*0.4545455);
    path_0.lineTo(size.width*0.09090909,0);

Paint paint_0_stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.1518182;
paint_0_stroke.color=Color(0xffD75F26).withOpacity(1.0);
paint_0_stroke.strokeJoin = StrokeJoin.round;
canvas.drawPath(path_0,paint_0_stroke);

// Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
// paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
// canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}