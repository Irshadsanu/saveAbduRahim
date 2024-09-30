import 'dart:async';
import 'dart:io';

import 'package:bloodmoney/providers/home_provider_reciept.dart';
import 'package:bloodmoney/providers/main_provider.dart';
import 'package:bloodmoney/testing%20page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:unique_identifier/unique_identifier.dart';

import 'package:url_strategy/url_strategy.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import '../constants/shake_effect.dart';
import '../providers/web_provider.dart';
import 'package:provider/provider.dart';
import 'Admin/admin_login_screen.dart';
import 'Admin/issue_clearance_page.dart';
import 'Screens/FinaleDayScreen.dart';
import 'Screens/InagurationTvScreen.dart';
import 'Screens/TvMonitorScreen.dart';
import 'Screens/animationTest.dart';
import 'Screens/donation_success.dart';
import 'Screens/end_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/inaguration_screen.dart';
import 'Screens/no_paymet_gatway.dart';
import 'Screens/splash_screen.dart';
import 'Screens/bank_payment_page.dart';
import 'Screens/stoppScreen.dart';
import 'Screens/upload_excel.dart';
import 'Screens/upload_portal_login.dart';
import 'getReport.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String? paymentID;

  if(!kIsWeb) {
    await Firebase.initializeApp();
  }else {
    await Firebase.initializeApp(

        options:const FirebaseOptions(
            apiKey: "AIzaSyAIDIeRGMwI7IE91JPBzI_lRXzSM9fvBJE",
            authDomain: "bloodmoneyapp-bbc1c.firebaseapp.com",
            databaseURL: "https://bloodmoneyapp-bbc1c-default-rtdb.firebaseio.com",
            projectId: "bloodmoneyapp-bbc1c",
            storageBucket: "bloodmoneyapp-bbc1c.appspot.com",
            messagingSenderId: "367190222556",
            appId: "1:367190222556:web:59ee8d3ad5ad500c9af619",
            measurementId: "G-69F04YKJZ3"
        )

    );

  }
  if(!kIsWeb){
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    bool weWantFatalErrorRecording = true;
    FlutterError.onError = (errorDetails) {
      if(weWantFatalErrorRecording){
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      } else {
        // FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    // String strDeviceID= await DeviceInfo().fun_initPlatformState();
    String? strDeviceID= "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    FirebaseCrashlytics.instance.setUserIdentifier(strDeviceID!);
    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    runZonedGuarded(() {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) =>
          runApp( MyApp(paymentID: '',)));
      // runApp( MyApp(paymentID: '',));
    },
        FirebaseCrashlytics.instance.recordError);

  }else{
    setPathUrlStrategy();
    String? refNum = Uri.base.queryParameters["id"];
    if(refNum==null){

      paymentID="General";

    }else{

      paymentID=refNum;

    }

    print("dssedsqwer"+paymentID.toString());


    runApp( MyApp(paymentID: paymentID!,));
  }


}

class MyApp extends StatelessWidget {
  String paymentID="";
   MyApp({Key? key,required this.paymentID}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>DonationProvider(),),
        ChangeNotifierProvider(create: (context)=>HomeProvider(),),
        ChangeNotifierProvider(create: (context)=>HomeProviderReceiptApp(),),
        ChangeNotifierProvider(create: (context)=>WebProvider(),),
        ChangeNotifierProvider(create: (context)=>MainProvider(),),
      ],
      child: MaterialApp(
        title: 'SAVE ABDUL RAHIM',
        // title: 'BOCHE YACHAKA FUND',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(primarySwatch: Colors.blue,),
        // home: TestPage(),
        home: UploadLogIn(),
        // home: GetReport(),
        // home: AdminLoginScreen(),
        // home: UploadExcel(),
        // home:  StoppScreen(),
        // home:  SplashScreen(paymentID:paymentID,),
        // home: EndScreen(),
        // home:   InagurationScreen(),
        // home:   InagurationTvScreen(),
        // home:   HomeScreenNew(),
        // home: const   Intern(),
        // home: TvMonitorScreem(),

      ),
    );
  }
}


