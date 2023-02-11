import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:matrimonial_app/Ui/Home_screen/provider/card_provider.dart';
import 'package:matrimonial_app/Ui/SplashScreen/splash_screen.dart';
import 'package:matrimonial_app/translations/LocalString.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('hi', 'HI')],
        path: 'assets/Language',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings, /*  onSelectNotification: viewNotification */
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
            ),
          ),
          payload: notification.title,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: GetMaterialApp(
        translations: LocaleString(),
        locale: Locale('en', 'US'),
        scrollBehavior: ScrollBehavior(
            androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 30),
              elevation: 0,
              primary: Colors.white,
              shape: CircleBorder(),
              minimumSize: Size.square(20),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home:
        // GridImageDemo()
            // SkeletonLoader()
            // skelatonDemo()
            Splash_screen(),
      ));
  Future<dynamic> viewNotification(payload) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Splash_screen()));
  }
}
