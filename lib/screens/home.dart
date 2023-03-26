import 'dart:io';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:garbage_manager/constants/app_properties.dart';
import 'package:garbage_manager/constants/size_config.dart';
import 'package:garbage_manager/database_manager.dart';
import 'package:garbage_manager/models/Item.dart';
import 'package:garbage_manager/screens/components/garbage_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../utils.dart';
import 'components/alert.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> _items = [];

  ImagePicker _imagePicker = ImagePicker();
  String predictedResult = "";

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

    predictedResult = result['label'];
    await _updateItem(_items, predictedResult);

    showAlert(
        bContext: context,
        title: "Result",
        content: "Put it in collection point: ${predictedResult.toUpperCase()}.\n\n"
            "Predicted with ${confidence * 100}% confidence",
        callback: () {
          setState(() {
            predictedResult = result['label'];
          });
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
      appBar: AppBar(
          title: Text("Collection Points"), elevation: 0, centerTitle: true),
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
          ]),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: GarbageItemList(
              predictedItem: predictedResult,
            )),
        SizedBox(width: getProportionateScreenWidth(20)),
      ]))),
    );
  }
}
