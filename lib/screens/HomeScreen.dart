import 'dart:io';

import 'package:deep_waste/constants/app_properties.dart';
import 'package:deep_waste/constants/size_config.dart';
import 'package:deep_waste/database_manager.dart';
import 'package:deep_waste/main.dart';
import 'package:deep_waste/models/Item.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../realtime/real_time_detection.dart';
import '../utils.dart';
import 'components/alert.dart';
import 'components/history.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> _items = [];

  ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadModel();
    _loadHistory();
  }

  _loadHistory() {
    DatabaseManager.instance.getItems().then((value) {
      setState(() {
        _items = value;
      });
    });
  }

  _imageFromCamera() async {
    try {
      PickedFile capturedImage =
      await _imagePicker.getImage(source: ImageSource.camera);
      final File imagePath = File(capturedImage.path);
      if (capturedImage == null) {
        showAlert(
            bContext: context,
            title: "Error choosing file",
            content: "No file was selected");
      } else {
        _uploadImage(imagePath);
      }
    } catch (e) {
      showAlert(
          bContext: context, title: "Error capturing image file", content: e);
    }
  }

  _imageFromGallery() async {
    PickedFile uploadedImage =
    await _imagePicker.getImage(source: ImageSource.gallery);
    final File imagePath = File(uploadedImage.path);

    if (uploadedImage == null) {
      showAlert(
          bContext: context,
          title: "Error choosing file",
          content: "No file was selected");
    } else {
      _uploadImage(imagePath);
    }
  }

  _realTimeDetection() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RealTimeDetectionWidget(cameras)));
  }

  Future _loadModel() async {
    Tflite.close();
    String absPathModelPath = "assets/models/garbage_model.tflite";
    String classLabel = "assets/labels/labels.txt";
    try {
      await Tflite.loadModel(model: absPathModelPath, labels: classLabel);
    } on PlatformException {
      print("Couldn't load model");
    }
  }

  _uploadImage(File image) async {
    EasyLoading.show(status: 'Predicting...');
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 1,
        threshold: 0.2,
        asynch: true);

    EasyLoading.dismiss();
    var result = output[0];
    var confidence = getNumber(result['confidence'], precision: 2);
    final predictedResult = result['label'];
    await _updateItem(_items, predictedResult);

    showAlert(
        bContext: context,
        title: "Done!",
        content: "Predicted ${result['label']} with ${confidence * 100}% confidence.");
    setState(() {
    });
  }

  Future _updateItem(List<Item> items, String itemName) async {
    var matchedItem = items.firstWhere(
            (_item) => _item.name.toLowerCase() == itemName,
        orElse: () => null);
    matchedItem.count = matchedItem.count + 1;
    await DatabaseManager.instance.updateItem(matchedItem);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: white,
      floatingActionButton: FabCircularMenu(
          ringDiameter: getProportionateScreenWidth(130.0),
          ringColor: Color(0xff69c0dc),
          ringWidth: getProportionateScreenWidth(40.0),
          fabSize: getProportionateScreenWidth(44.0),
          fabElevation: getProportionateScreenWidth(8.0),
          fabCloseIcon: Icon(
            Icons.close,
          ),
          fabOpenIcon: Icon(
            Icons.photo,
          ),
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.camera_alt_outlined),
                onPressed: () => _imageFromCamera()),
            IconButton(
                icon: Icon(Icons.folder), onPressed: () => _imageFromGallery()),
            IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () => _realTimeDetection())
          ]),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
        History(),
        SizedBox(width: getProportionateScreenWidth(20)),
      ]))),
    );
  }
}
