import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final GlobalKey<State>? _progressLoader = GlobalKey<State>();

class CommonUtils {
  static Future<void> showProgressLoading(BuildContext context) async {
    if (_progressLoader!.currentContext != null) {
      return;
    }
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  elevation: 0,
                  key: _progressLoader,
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white.withOpacity(0.9),
                        ),
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CupertinoActivityIndicator(
                                radius: 17,
                                animating: true,
                              ),
                            ),
                           
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    
                  ]));
        });
  }

 static void hideProgressLoading() {
    if (_progressLoader!.currentContext != null &&
        Navigator.canPop(_progressLoader!.currentContext!)) {
      Navigator.of(_progressLoader!.currentContext!, rootNavigator: true).pop();
    }
  }
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpinKit Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Align(
                child: LayoutBuilder(
                  builder: (context, _) {
                    return Container();
                  },
                ),
                alignment: Alignment.bottomCenter,
              ),
              Positioned.fill(
                child: Center(
                    child: Container(
                  color: Colors.transparent,
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SpinKitFadingCircle(
                        size: 60.0,
                        color: Color(0xffFB5557),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Loading....",
                        style: TextStyle(
                          fontFamily: 'VisbyCF',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
