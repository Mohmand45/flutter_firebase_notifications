import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseOnBackgroundMessageHandle(RemoteMessage message) async {
  try{
    print("Firebase Messaging: ${message.notification!.title} ");
    print("Firebase Messaging: ${message.notification!.body} ");

  }catch(e){
    print("Firebase Messaging Error: ${e.toString()} ");

  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseOnBackgroundMessageHandle);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> sss = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    firebaseMessaging.getToken().then((value) {
      print("FirebaseMessaging: ${value}");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print("Firebase Messaging onMessage: ${message.notification!.title} ");
      print("Firebase Messaging onMessage: ${message.notification!.body} ");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print("Firebase Messaging onMessageOpenedApp: ${message.notification!
          .title} ");
      print("Firebase Messaging onMessageOpenedApp: ${message.notification!
          .body} ");
    });
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Main Screen'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){

          },
          child: Icon(Icons.message),
        ),
        body: Center(
          child: Text('Main Screen Body',),
        ),
      )
    );
  }
}
