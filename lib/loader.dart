import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
                      CupertinoActivityIndicator(
                        animating: true,
                        radius: 30,
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
