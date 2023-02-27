import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_webview/Helper.dart';
import 'package:flutter_webview/webview.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("password")
        .doc("passwordid")
        .get();
    Map data = querySnapshot.data() as Map;
    password = data["password"];
    url = data["url"];
    print(password);
  } on FirebaseException catch (e) {
    print(e);
  } catch (e) {
    print(e);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WebViewApp(),
    );
  }
}
