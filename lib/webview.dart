import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  // For Loading Sign
  bool isLoading = true;

  // Webview Controller
  WebViewController controller = WebViewController();

  // Function for changing URL
  changeUrl(String url) {
    WebViewController newcontroller = WebViewController();
    newcontroller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse(url),
      );
    if (mounted) {
      setState(() {
        controller = newcontroller;
      });
    }
  }

  int _selectedIndex = 0;
  final List<String> urlList = <String>[
    'https://calcadames.railes.io/login',
    // 'https://usamasadiq.engineer/#services',
    // 'https://usamasadiq.engineer/#portfolio',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeUrl(urlList[_selectedIndex]);
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    changeUrl(urlList[index]);
  }

  void choiceAction(String choice) {
    if (choice == "SAIR") {
      SystemNavigator.pop();
      print('SAIR');
    } else if (choice == "EDITAR URL") {
      print('EDITAR URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(87, 118, 189, 1),
          leading: Image.asset("assets/logo-icon.png"),
          title: Text("calcadames".toUpperCase()),
          actions: [
            PopupMenuButton<String>(
              color: Color.fromRGBO(87, 118, 189, 1),
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return [
                  "SAIR",
                  "EDITAR URL",
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
            )
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : WebViewWidget(controller: controller),
        // Bottom Navigation Bar

        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: Colors.black,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.business),
        //       label: 'Business',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.school),
        //       label: 'School',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   onTap: _onTabTapped,
        // ),
      ),
    );
  }
}



// Previous Webview Example

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewApp extends StatefulWidget {
//   const WebViewApp({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewApp> createState() => _WebViewAppState();
// }
//
// class _WebViewAppState extends State<WebViewApp> {
//   WebViewController controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//   //..setBackgroundColor(const Color(0x00000000))
//     ..setNavigationDelegate(
//       NavigationDelegate(
//         onProgress: (int progress) {
//           // Update loading bar.
//         },
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           if (request.url.startsWith('https://flutter.dev/')) {
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(
//       Uri.parse('https://usamasadiq.engineer/'),
//     );
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WebViewWidget(controller: controller),
//       ),
//     );
//   }
// }