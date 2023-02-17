import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_webview/webview.dart';

import 'Helper.dart';

class Editurl extends StatelessWidget {
  var pincontoller = TextEditingController(text: password);

  var weburl = TextEditingController(text: url);

  Editurl({super.key});

  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice) {
      if (choice == "SAIR") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sair'),
              content: Text('Digite o pin'),
              actions: <Widget>[
                Card(
                    child: TextFormField(
                  controller: pincontoller,
                  decoration: InputDecoration(hintText: "*****"),
                )),
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (pincontoller.text.toString() == "$password") {
                      SystemNavigator.pop();
                    }
                  },
                ),
              ],
            );
          },
        );

        print('SAIR');
      } else if (choice == "VOLTAR") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewApp(),
            ));
        print('VOLTAR');
      }
    }

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(87, 118, 189, 1),
        leading: Image.asset("assets/logo-icon.png"),
        title: Text("calcadames".toUpperCase()),
        actions: [
          // IconButton(
          //     onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            color: Color.fromRGBO(87, 118, 189, 1),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return [
                "SAIR",
                "VOLTAR",
              ].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width / 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Url",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(87, 118, 189, 1)),
              ),
              TextFormField(
                controller: weburl,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "PIN",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(87, 118, 189, 1)),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "****"),
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show(status: "Completing...");
                        try {
                          await FirebaseFirestore.instance
                              .collection("password")
                              .doc("passwordid")
                              .update({
                            "password": pincontoller.text.trim(),
                            "url": weburl.text.trim()
                          });
                          // EasyLoading.dismiss();
                          EasyLoading.dismiss();

                          // EasyLoading.show(status: "Completed");

                          Navigator.pop(context);
                        } catch (e) {
                          EasyLoading.dismiss();

                          print(e);
                        }
                      },
                      child: Text("ok")))
            ],
          ),
        ),
      ),
    );
  }
}
