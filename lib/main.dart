
import 'package:camera/camera.dart';
import 'package:deep_waste/controller/category_notifier.dart';
import 'package:deep_waste/controller/item_notifier.dart';
import 'package:deep_waste/screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CategoryNotifier()),
          ChangeNotifierProvider(create: (_) => ItemNotifier()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Deep Waste',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black //here you can give the text color
                ),
            brightness: Brightness.light,
            canvasColor: Colors.transparent,
            primarySwatch: Colors.blue,
            fontFamily: "Montserrat",
          ),
          builder: EasyLoading.init(),
          home: HomeScreen(),
        ));
  }
}
