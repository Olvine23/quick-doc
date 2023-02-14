// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:hive/hive.dart';
import 'package:test/core/utils/custom_palette.dart';
import 'package:test/features/number_trivia/presentation/pages/authentication/auth_page.dart';
import 'package:sizer/sizer.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/books.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/docs.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/schedule_calendar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/camera_screen.dart';
import 'features/number_trivia/presentation/routes/routes.dart';

Box? box;
//This could be null
late var cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  var camera = cameras.first;
  print(cameras.length);
  print(cameras.first);
  final doc_dir = await getApplicationDocumentsDirectory();
  Hive.init(doc_dir.path);

  Hive.registerAdapter(BooksAdapter());
  box = await Hive.openBox<Books>('booksBox');
 
  Hive.registerAdapter(DocsAdapter());
  await Firebase.initializeApp();
  runApp(ProviderScope(
    child: DevicePreview(
        enabled: false,
        builder: (context) => MyApp(
              camera: camera,
            )),
  ));

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
        channelGroupKey: 'reminders',
        channelName: 'Basic instant notification',
        channelKey: 'instant_notification',
        channelDescription: "Notification channel triggers notif",
        channelShowBadge: true),
    NotificationChannel(
        channelKey: 'scheduled_notification',
        channelName: 'Scheduled Notification',
        channelDescription: 'This one is scheduled',
        ledColor: Colors.white,
        defaultColor: Color(0xFF9D50DD))
  ]);
}

class MyApp extends StatefulWidget {
  CameraDescription camera;
  MyApp({required this.camera, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return CalendarControllerProvider(
            controller: EventController(),
            child: MaterialApp(
              routes: routes,
              // home: CameraScreen(camera: widget.camera),
              useInheritedMediaQuery: true,
              builder: DevicePreview.appBuilder,
              locale: DevicePreview.locale(context),
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              // darkTheme: ThemeData.dark(),
              // themeMode: ThemeMode.system,
              theme: ThemeData(
                primarySwatch: Palette.kToDark,
                textTheme: GoogleFonts.montserratTextTheme(
                    Theme.of(context).textTheme),
              ),
              // home: Scaffold(backgroundColor: Colors.white,
            ) // body: AuthPage())),
            );
      }),
    );
  }
}
