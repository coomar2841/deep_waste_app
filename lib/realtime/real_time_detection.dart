import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'bndbox.dart';
import 'camera.dart';
import 'models.dart';

class RealTimeDetectionWidget extends StatefulWidget {
  final List<CameraDescription> cameras;

  RealTimeDetectionWidget(this.cameras);

  @override
  _RealTimeDetectionState createState() => new _RealTimeDetectionState();
}

class _RealTimeDetectionState extends State<RealTimeDetectionWidget> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = mobilenet;

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Stack(
            children: [
              Camera(
                widget.cameras,
                setRecognitions,
              ),
              BndBox(
                  _recognitions == null ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,
                  _model),
            ],
          );
  }
}
