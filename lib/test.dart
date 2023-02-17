// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MyWebView extends StatefulWidget {
//   const MyWebView({Key? key}) : super(key: key);

//   @override
//   _MyWebViewState createState() => _MyWebViewState();
// }

// class _MyWebViewState extends State<MyWebView> {
//   late WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My WebView"),
//       ),
//       body: WebView(
//         initialUrl: 'https://www.google.com',
//         javascriptMode: JavascriptMode.unrestricted,
//         navigationDelegate: (NavigationRequest request) {
//           if (request.isForMainFrame &&
//               request.navigationType == NavigationType.pop) {
//             _showDialog();
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//         },
//       ),
//     );
//   }

//   void _showDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Alert"),
//           content: Text("Recent button is pressed"),
//           actions: <Widget>[
//             FlatButton(
//               child: Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
