import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutterassignment/data/service/api_service.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = TextEditingController();
  var node = FocusNode();
  String data = 'Detected sentence...';
  String data2 = '...';
  String imgData = '';

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => node.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: color.primaryContainer,
        body: CustomPaint(
          painter: Painter(color),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Profanity Detector + Filter',
                    style: Font.poppins(
                      style: TextStyle(
                        color: color.primary.withAlpha(180),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
                    )),
                const SizedBox(height: 85),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    style: Font.lato(),
                    controller: controller,
                    enableSuggestions: true,
                    focusNode: node,
                    onChanged: (a) async {
                      if (controller.text.isEmpty) {
                        data = "Start typing again";
                      }
                      final wordFilter = await ApiService().getWordFilter(a);
                      setState(() {
                        data = wordFilter!.clean.toString();
                        data2 = wordFilter.profanities.toString();
                      });
                      return log(data);
                    },
                    decoration: InputDecoration(
                      hintText: "Type to verify words...",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.deepOrange.withAlpha(110)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: color.primary.withAlpha(110), width: 3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                Text(data, style: Font.quicksand(style: TextStyle(color: color.primary.withAlpha(150), fontSize: 25, fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                Text(softWrap: true, 'Filtered words: $data2', style: Font.lato(style: TextStyle(color: color.primary, fontSize: 20))),
                const SizedBox(height: 150),
                MaterialButton(
                  onPressed: () => getImage((message) => setState(() => imgData = message)),
                  height: 50,
                  minWidth: 250,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  color: color.primary.withAlpha(130),
                  child: Text('Detect Image', style: Font.poppins(style: TextStyle(color: color.secondaryContainer, fontSize: 20))),
                ),
                const SizedBox(height: 20),
                Text(imgData, style: Font.lato(style: TextStyle(color: color.primary, fontSize: 20))),
                //Flex(direction: Axis.vertical)
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImage(void Function(String message) callback) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    var file = await File(image!.path).readAsBytes();
    var data = await ApiService().getImageFilter(base64.encode(file));
    //log(base64.encode(file));
    //log(data.predictions!.unsafe.toString());
    callback(data.message!);
  }
}

class Painter extends CustomPainter {
  Painter(this.colorScheme);

  ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    var path = Path();
    var paint = Paint();
    var offset = Offset((width / 6) + 10, height / 2);
    var offset2 = offset.translate(-50, offset.dy / 2);
    var offset3 = offset.translate(100, 100);
    var offset4 = offset.translate(100, -4 * offset.dy / 5);
    var offset5 = offset.translate(3 * width / 5, 4 * offset.dy / 5);
    var offset6 = offset5.translate((width - offset5.dx) / 7, -2 * offset5.dy / 3);
    var random = math.Random(500);

    paint.color = Colors.red.shade200;
    paint.style = PaintingStyle.fill;
    paint.strokeJoin = StrokeJoin.round;

    //var rect = Rect.fromPoints(Offset(path.getBounds().width, path.getBounds().height), Offset(dx, dy));

    double y = 4 * height / 5;
    path.moveTo(width, 0);
    path.cubicTo(150, height / 3, 3 * width / 2, 2 * height / 3, 150, y);
    path.conicTo(0, y + 50, 100, y + 100, 1);
    path.lineTo(220, height);
    path.arcTo(Rect.fromCenter(center: Offset(220, height - 70), width: 250, height: 140), math.pi / 2, -math.pi / 2, false);
    path.cubicTo(100, y + 50, width, y + 10, width, y);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawCircle(offset, 20, Paint()..color = Colors.orangeAccent);
    canvas.drawCircle(offset2, 10, Paint()..color = Colors.greenAccent);
    canvas.drawCircle(offset3, 5, Paint()..color = Colors.redAccent);
    canvas.drawCircle(offset4, 15, Paint()..color = Colors.purpleAccent);
    canvas.drawCircle(offset5, 45, Paint()..color = Colors.yellowAccent.shade400.withAlpha(110));
    canvas.drawCircle(offset6, 10, Paint()..color = Colors.indigoAccent.withAlpha(130));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
