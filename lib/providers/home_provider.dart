import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Screens/assembly_report.dart';
import '../Screens/district_report.dart';
import '../Screens/home_screen.dart';
import '../Screens/howToPay_Screen.dart';
import '../Screens/update.dart';
import '../Views/District_report_model.dart';
import '../Views/ageModel.dart';
import '../Views/enroller_payments_model.dart';
import '../Views/icons_model.dart';
import '../Views/panjayath_model.dart';
import '../Views/receipt_list_model.dart';
import '../Views/reportModel.dart';
import '../Views/topEnrollers_model.dart';
import '../Views/top_lead_model.dart';
import '../Views/unit_model.dart';
import '../Views/video_model.dart';
import '../Views/ward_model.dart';
import '../Views/ward_total_model.dart';
import '../constants/alerts.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/strings.dart';
import '../constants/text_style.dart';
import '../service/device_info.dart';
import '../service/wards_service.dart';

class HomeProvider extends ChangeNotifier {
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;


  bool stopeBool = false;
  double totalCollection = 0;
  double totalCount = 0;
  String totalDhotis = '';
  List<String> sliderList = [];
  List<PaymentDetails> historyList = [];
  List<WardTotalModel> wardTotalList = [];
  List<PaymentDetails> paymentDetailsList = [];
  List<EnrollerPaymentsModel> enrollerPaymentsList= [];
  StreamSubscription? _streamSubscription;
  StreamSubscription? _streamSubscriptionWardTotal;
  int currentLimit=0;
  int currentAssemblyLimit = 0;
  bool kpccMonitor = false;
  double wardTotal=0;
  // double wardTotalTransactionsCount=0;
  // WardTotalModel? modelUnit;

  DateTime pickedDate=DateTime.now();
  String  selectedDate='';

  List<String> toppReportsList=['Top Unit','Top Panchayath','Top Municipality','Top Assembly','Leader Board'];

  String? appVersion;
  double totalOther=0.0;
  double totalAmount=0.0;
  int activeIndex = 0;

  TextEditingController searchEt=TextEditingController();
  TextEditingController EnrollerPaymentSearchCt=TextEditingController();

  TextEditingController entrollerNameCT = TextEditingController();
  TextEditingController entrollerPhoneCT = TextEditingController();
  TextEditingController entrollerPlaceCT = TextEditingController();
  TextEditingController addEntrollerPhoneCT = TextEditingController();
  TextEditingController adminDistrictNameCT = TextEditingController();
  List<TopEnrollersModel> topEnrollersModel = [];
  List<TopLeadModel> topLeadlist = [];
  List<String> adminViewDistrictList=[];
  String enrollerNoOfPayments="0";
  double EnrollerPaymenttotal=0.0;
  String EnrollerPaymentName="";






  PanjayathModel?selectedEnrollerPanchayath ;
  AssemblyDropListModel? selectedEnrollerAssembly;

  TextEditingController enrollerPanchayathCT = TextEditingController();
  TextEditingController enrollerAssemblyCT = TextEditingController();
  TextEditingController enrollerDistrictCT = TextEditingController();
  TextEditingController enrollerStateCT = TextEditingController();


  bool enrollerNoPaymet=false;
  bool checkEnrollerExist= false;
  bool enrollerDeviceID= false;
  String EnrollerName="";
  String EnrollerID="";
  String EnrollerPlace="";
  List<IconGS> iconGS = [];
  double starRating=0;





  ///admin
  List<String> upiList = [];
  TextEditingController upiIdController = TextEditingController();
  List<String> modeList = [];
  TextEditingController modeController = TextEditingController();
  List<DistrictReportModel> districtWiseReportList=[];
  List<TopStateModel> topStateModelList=[];
  List<AssemblyReportModel> assemblyWiseReportList=[];
  List<TopAssemblyModel> topAssemblyList=[];
  List<TopPanchayathModel> topPanchayathList=[];
  List<TopPanchayathModel> topPanchayathListNew=[];
  List<TopPanchayathModel> topMuncipalityList=[];
  List<TopWardModel> topWardList=[];

  ///unit report
  List<WardModel> wards = [];
  StreamSubscription? unitStream;

  // List<String> districtList=[];
  List<PanjayathModel> panjayathList=[];
  List<AssemblyModel> assemblyList=[];
  List<MandalamModel> mandalamList=[];
  List<BlockModel> blockList=[];

  List<UnitModel> unitList=[];
  List<WardModel> chipsetBoothList=[];

  String? selectedDistrict;
  PanjayathModel? selectedPanjayath;
  String? selectedAssembly;
  String? selectedBlock;
  String? selectedMandalam;
  UnitModel? selectedUnit;
  WardModel? selectedBooth;

  double filterCollection = 0;
  double panchayathTarget = 0;
  double eachDistrictTotal = 0.0;
  bool filter = false;
  Map<dynamic, dynamic> newWardMap={};
  Map<dynamic, dynamic> hideWardMap={};

  TextEditingController assemblyTc=TextEditingController();
  TextEditingController blockTc=TextEditingController();
  TextEditingController mandalamTc=TextEditingController();
  TextEditingController boothCT=TextEditingController();

  TextEditingController panjayathTc=TextEditingController();
  TextEditingController unitTc=TextEditingController();

  StreamSubscription? dateTimeStream;
  String termsAndCondition = '';
  String aboutUs = '';
  String contactNumber='';
  String contactUs='';
  String contactTime='';
  String iosPaymentGateway='';
  WardTotalModel? fromWard;
  String currentVersion='';
  String  receiptPinWard='OFF';
  String  historyPinWard='OFF';

  String  selectReport='ASSEMBLY';
  String  noPaymentText='';
  String buildNumber="";


  String  intentPaymentOption='OFF';
  String  easyPayAndroidQrPaymentOption='OFF';
  String  easyPayAndroidPaymentOption='OFF';
  String  razorpayAndroidPaymentOption='OFF';
  String  ccavenueAndroidPaymentOption='OFF';

  String  easyPayIosPaymentOption='OFF';
  String  razorpayIosPaymentOption='OFF';
  String  ccavenueIosPaymentOption='OFF';


  /// home icons


  ///admin app password
  String adminPassword='';

  bool isLaunched = false;
  String launchStatus="LAUNCH";
  AudioPlayer? audioPlayer;

  List<AssemblyTotalModel> assemblyTotalList = [];
  AssemblyTotalModel? fromReportAssembly;

  List<DistrictDropListModel> districtList = [];

  double assemblyReceiptTotal = 0;
  double assemblyTotalTransactionsCount = 0;
  AssemblyTotalModel? modelUnit;


  HomeProvider() {fetchReceiptList(5);

    iconGS.add(IconGS("Report", "assets/Report_icon.png"));
    iconGS.add(IconGS("Transactions", "assets/Transactionsicon.png"));
    iconGS.add(IconGS("District Report", "assets/District_report_icon.png"));
    iconGS.add(IconGS("Lead", "assets/topers.png"));
    iconGS.add(IconGS("My History", "assets/My_history_icon.png"));
    iconGS.add(IconGS("Be An Enroller", "assets/topers.png"));
print("teeeeeeeeeee");
    notifyListeners();
    getAppVersion();
    fetchDatabaseWard();
    // fetchHistory();
    fetchHistoryFromFireStore();
    fetchWard();
    fetchTotal();
    fetchDetails();
    lockPinWardReceipt();
    lockPinWardHistory();
    lockIntentPaymentOption();
  lockEazypayPaymentOption();
  lockrazorpayandroidPaymentOption();
  lockccavenueAndroidPaymentOption();
  lockrazorpayIosPaymentOption();
  lockrEazypatIosPaymentOption();
  lockEazypayQrPaymentOption();
  lockccavenueIosPaymentOption();
    noPaymentMessage();
    lockIosPaymentButton();
    checkPassword();
    changeReport();
  }

  void checkIsOn(){
    mRoot.child("inaguration").onValue.listen((event) {
      if(event.snapshot.value.toString()=="ON") {
        final player=AudioCache();
        player.play('music.mp3');
        controllerCenter.play();
        isLaunched=true;
      }
      });
      }



  //InagurationTvScreen start
  void inagurationTriggerKKD(BuildContext context){

    mRoot.child("inaguration").onValue.listen((event) {
      if(event.snapshot.value.toString()=="ON"){
        // final player=AudioCache();
        // player.play('music.mp3');
        controllerCenter.play();
        isLaunched=true;
        callNextReplacement(HomeScreenNew(), context);
        sss();
        notifyListeners();
      }else{
        print("asdfvcxdlfiewijsdkfj");
      }
      notifyListeners();
    });



    // mRoot.child("inaguration").onValue.listen((event) {
    //   if(event.snapshot.value.toString()=="ON"){
    //     final player=AudioCache();
    //     player.play('music.mp3');
    //     controllerCenter.play();
    //     isLaunched=true;
    //     callNextReplacement(HomeScreenNew(), context);
    //     sss();
    //     notifyListeners();
    //   }
    //   notifyListeners();
    //
    // });


  }

  void stopeBoolTrue(){
    stopeBool=true;
    notifyListeners();
  }

  Future<void> setLaunchStatus(String data,bool launch,context) async {
    launchStatus=data;
    isLaunched = launch;
    final player = AudioCache();
    if(launch==true) {
      audioPlayer = await player.play('music.mp3');
      notifyListeners();
    }
    else{
      audioPlayer?.stop();

    }
    notifyListeners();
  }



  //InagurationTvScreen end

  lockPinWardReceipt(){
    mRoot.child('0').child('PinWardReceipt').onValue.listen((event) {
      if(event.snapshot.exists){
        receiptPinWard=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }

  lockPinWardHistory(){
    mRoot.child('0').child('PinWardHistory').onValue.listen((event) {
      if(event.snapshot.exists){
        historyPinWard=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }

  changeReport(){
    mRoot.child('0').child('SelectReport').onValue.listen((event) {
      if(event.snapshot.exists){
        selectReport=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }


void inagurationON(){

  mRoot.child("0").child("inaguration").set("ON");
  // mRoot.child("0").child("PaymentGateway35").set("ON");
    
}
  void inagurationOFF(){

    mRoot.child("0").child("inaguration").set("OFF");
    // mRoot.child("0").child("PaymentGateway35").set("ON");

  }
void inagurationTrigger(BuildContext context){
    mRoot.child("0").child("inaguration").onValue.listen((event) {

      if(event.snapshot.value.toString()=="ON"){
        // final player=AudioCache();
        // player.play('music.mp3');
        callNextReplacement(HomeScreenNew(), context);
        notifyListeners();


      }
      notifyListeners();

    });
}
testBase(){
  HashMap<String, Object> map = HashMap();
  map["test"] = "success";
    db.collection("testing").doc("hhh").set(map);
    mRoot.child("testewr").set(map);
}

  void lockApp() {
    mRoot.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map[!Platform.isIOS ? 'AppVersion' : 'iOSVersion'].toString().split(',');
        if (!versions.contains(appVersion)) {
          String ADDRESS = map[!Platform.isIOS ?'ADDRESS':'ADDRESS_iOS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }
  void lockAppMonitor() {
    mRoot.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['MonitorVersion'].toString().split(',');
        print(monitorVersion.toString()+"dfdssaa");
        print(versions.toString()+"dfdssaa");
        if (!versions.contains(monitorVersion)) {
          String ADDRESS = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }
  void lockAppTv() {
    mRoot.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['tvVersion'].toString().split(',');
        if (!versions.contains(tvVersion)) {
          String ADDRESS = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }

  void noPaymentMessage() {
    mRoot.child("0").child('noPayment').onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;

        noPaymentText = map['TEXT'].toString();

      }
    });
  }

  void fetchDatabaseWard() {
    mRoot.child('NewWards').onValue.listen((databaseEvent) {
      if (databaseEvent.snapshot.value != null) {
         newWardMap = databaseEvent.snapshot.value as Map;
        notifyListeners();
      }
    });
    mRoot.child('hidewards').onValue.listen((databaseEvent) {
      if (databaseEvent.snapshot.value != null) {
        hideWardMap = databaseEvent.snapshot.value as Map;
        notifyListeners();
      }
    });


  }

  void fetchDatabaseAssembly() {
    mRoot.child('NewAssembly').onValue.listen((databaseEvent) {
      if (databaseEvent.snapshot.value != null) {
         newWardMap = databaseEvent.snapshot.value as Map;
        notifyListeners();
      }
    });
    mRoot.child('hideAssembly').onValue.listen((databaseEvent) {
      if (databaseEvent.snapshot.value != null) {
        hideWardMap = databaseEvent.snapshot.value as Map;
        notifyListeners();
      }
    });


  }

  // fetchHistory() async {
  //   if(!kIsWeb){
  //     String strDeviceID= await DeviceInfo().fun_initPlatformState();
  //
  //
  //     mRoot.child('UserPayments').onValue.listen((event) {
  //       historyList.clear();
  //       if(event.snapshot.exists){
  //         print("nodeexist");
  //         Map<dynamic, dynamic> map = event.snapshot.value as Map;
  //         map.forEach((key, value) {
  //           mRoot.child(value['OrderRef']).onValue.listen((value) {
  //             if(value.snapshot.exists){
  //               print("dataexist");
  //               Map<dynamic, dynamic> data = value.snapshot.value as Map;
  //               if(!historyList.map((e) =>e.id).contains(key)){
  //                 historyList.add(PaymentDetails(
  //                     key,
  //                     data['Amount'].toString(),
  //                     data['Name'].toString(),
  //                     data['PaymentApp']??'',
  //                     data['PhoneNumber'].toString(),
  //                     data['Status'].toString(),
  //                     data['Time']??'',
  //                     data['Ward'].toString(),
  //                     data["district"].toString(),
  //                     data["panchayath"].toString(),
  //                     data["wardname"].toString(),
  //                     data["wardnumber"].toString(),
  //                     data['UpiID']??'',
  //                     data['RefNo']??'','','',
  //                   data['Dhothies'].toString(),));
  //                 notifyListeners();
  //               }else{
  //                 final index = historyList.indexWhere((element) => element.id == key);
  //                 historyList[index]=PaymentDetails(
  //                     key,
  //                     data['Amount'].toString(),
  //                     data['Name'].toString(),
  //                     data['PaymentApp'].toString(),
  //                     data['PhoneNumber'].toString(),
  //                     data['Status'].toString(),
  //                     data['Time'].toString(),
  //                     data['Ward'].toString(),
  //                     data["district"].toString(),
  //                     data["panchayath"].toString(),
  //                     data["wardname"].toString(),
  //                     data["wardnumber"].toString(),
  //                     data['UpiID']??'',
  //                     data['RefNo']??'','','','');
  //                 notifyListeners();
  //               }
  //
  //               historyList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));
  //
  //               notifyListeners();
  //
  //
  //             }
  //           });
  //           notifyListeners();
  //
  //         });
  //         notifyListeners();
  //
  //       }
  //       notifyListeners();
  //
  //     });
  //   }
  //
  // }
Future<void> fetchHistoryFromFireStore() async {
    print("function work2345");


  historyList.clear();
    if(!kIsWeb){
      // String? strDeviceID="";
      // if(Platform.isAndroid){
      //   strDeviceID= await DeviceInfo().fun_initPlatformState();
      //
      // }else if(Platform.isIOS){
      //   try {
      //     strDeviceID = await UniqueIdentifier.serial;
      //   } on PlatformException {
      //     strDeviceID = 'Failed to get Unique Identifier';
      //   }
      //
      // }else{
      //   print("");
      // }

      String? strDeviceID= "";
      try {
        strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        strDeviceID = 'Failed to get Unique Identifier';
      }
      print(strDeviceID.toString()+' INDD  D(J');
      db.collection("MonitorNode")
          .where("DeviceId",isEqualTo:strDeviceID)
          .snapshots()
          .listen((value){
        historyList.clear();
        for (var element in value.docs){

          Map<dynamic,dynamic>map=element.data();

          historyList.add(PaymentDetails(
              element.id.toString(),
              map["Amount"].toString(),
              map["Name"].toString(),
              map["PaymentApp"].toString(),
              map["PhoneNumber"].toString(),
              map["Status"].toString(),
              map["Time"].toString(),
              map["state"].toString(),
              map["district"].toString(),
              map["assembly"]??"",
              map["UpiID"].toString(),
              map["RefNo"].toString(),
              map["Receipt Status"].toString(),
              map["PaymentUpi"].toString(),
              map["EnrollerName"]??"NILL",
              map['NameShowStatus'].toString(),
              map["EnrollerId"]??"NILL",
              map["Platform"]??"NILL",
            map["DeviceId"]??"NILL",
          ));

          print("asdfghj"+historyList.length.toString());
          notifyListeners();

        }
        historyList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));
      });
      
    }
    notifyListeners();
}

  fetchHistory() async {
    if(!kIsWeb){
      // String strDeviceID= await DeviceInfo().fun_initPlatformState();

      String? strDeviceID= "";
      try {
        strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        strDeviceID = 'Failed to get Unique Identifier';
      }

      mRoot.child('UserPayments').child(strDeviceID!).onValue.listen((event) {
        print("ideees  "+strDeviceID!);
        if(event.snapshot.exists){
          Map<dynamic, dynamic> map = event.snapshot.value as Map;
          map.forEach((key, value) {
            mRoot.child(value['OrderRef']).onValue.listen((value) {
              if(value.snapshot.exists){
                Map<dynamic, dynamic> data = value.snapshot.value as Map;
                String count =data['Amount']??'';
                // print("ideees  "+count+"  "+value.snapshot)
                if(count!=''){
                  int amount =(int.parse(count));
                  count = (amount/600).toStringAsFixed(0);
                }

                if(!historyList.map((e) =>e.id).contains(key)){
                  historyList.add(PaymentDetails(
                      key,
                      data['Amount'].toString(),
                      data['Name'].toString(),
                      data['PaymentApp'].toString(),
                      data['PhoneNumber'].toString(),
                      data['Status'].toString(),
                      data['Time'].toString(),
                      map["state"].toString(),
                      map["district"].toString(),
                      map["assembly"].toString(),
                      data['UpiID']??'',
                      data['RefNo']??'','','',data['EnrollerName']??"NILL","",map["EnrollerId"]??"NILL",map["Platform"]??"NILL",map["DeviceId"]??"NILL",
                  ));
                  notifyListeners();
                }else{
                  final index = historyList.indexWhere((element) => element.id == key);
                  historyList[index]=PaymentDetails(
                      key,
                      data['Amount'].toString(),
                      data['Name'].toString(),
                      data['PaymentApp'].toString(),
                      data['PhoneNumber'].toString(),
                      data['Status'].toString(),
                      data['Time'].toString(),
                      map["state"].toString(),
                      map["district"].toString(),
                      map["assembly"]??"",
                      data['UpiID']??'',
                      data['RefNo']??'','','',data['EnrollerName']??"NILL","",map["EnrollerId"]??"NILL",map["Platform"]??"NILL",map["DeviceId"]??"NILL",
                      );
                }

                historyList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));


              }
            });
            notifyListeners();

          });
          notifyListeners();

        }
        notifyListeners();

      });
    }

  }

  checkInternet(BuildContext context){
    print("haaaaaaahahaha");

    mRoot.child(".info/connected").onValue.listen((event)    {
      if(event.snapshot.value.toString() == "true"){
        print("ggggggggg1");

        if(FirebaseAuth.instance.currentUser!=null){
          print("hhhhhhhhhheeeeeee");


        }else{
          print("keeeeeeee");
          try {
            print("mmmmmmmmmwww");

            final userCredential =
            FirebaseAuth.instance.signInAnonymously().then((value) {
              print("Signed in with temporary account.");
              print(value.user?.uid.toString());


            });

          } on FirebaseAuthException catch (e) {



            switch (e.code) {
              case "operation-not-allowed":
                print("Anonymous auth hasn't been enabled for this project.");
                break;
              default:
                print("Unknown error.");
            }
          } on Exception catch(e){
            print("SSSSSSSSSSSSSSSSSSSSSSSSSSSS");
          }
        }

      } else {
        final snackBar = SnackBar(
            backgroundColor:Colors.transparent ,
            elevation:0,
            duration: const Duration(milliseconds: 3000),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CupertinoActivityIndicator(color: myWhite,radius: 10,),
                const SizedBox(width: 5,),
                Text("Connecting...", textAlign: TextAlign.center,softWrap: true,
                  style: snackbarStyle2,
                ),
              ],
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }

    });



  }


  void fetchWard() {
    if(unitStream!=null){
      unitStream!.cancel();
    }
    unitStream= db
        .collection('WardTotalAmount')
        .orderBy('Amount', descending: true)
        .limit(10)
        .snapshots()
        .listen((event) {
      wardTotalList.clear();

      filterCollection=0;
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          print(element.id.toString()+"sfddsds");
          filterCollection=filterCollection+double.parse(element.get('Amount').toString());
          wardTotalList.add(
              WardTotalModel(double.parse(element.get('Amount').toString()), element.get('district'),element.get('assembly'), element.get('panchayath'), element.get('wardname'),element.get("Target").toString()));
          notifyListeners();
        }
      }
      notifyListeners();

    });
  }

  fetchSliderImage() {
    mRoot.child('SliderImage').onValue.listen((databaseEvent) {
      sliderList.clear();
      if (databaseEvent.snapshot.value != null) {
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          sliderList.add(value.toString());
          notifyListeners();
        });
      }
    });
  }

  void fetchTotal() {
    print("function work test 1");
    db.collection('Total').doc('Total').snapshots().listen((event) {
      if (event.exists) {
        totalCollection = double.parse(event.get('Amount').toString());
        totalCount=double.parse(event.get('Count').toString());
        notifyListeners();
      }
    });
  }


  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate:  DateTime(2100),
    );

    if (picked != null) {
      pickedDate = picked;
    }
  }

  void streamSubscriptionCancel(){
    _streamSubscription!.cancel();
    // _streamSubscriptionWardTotal!.cancel();
  }

  void buzzer(String status){
    print("Buzzeerr");
    if(status!="Success"){

      // final player=AudioCache();
      // player.play('alert.mp3');

    }

  }
  void fetchReceiptListForMonitorApp(int limit) {
    if(_streamSubscription!=null){
      _streamSubscription!.cancel();
    }

    _streamSubscription=db.collection('MonitorNode').orderBy('Time',descending: true).limit(limit).snapshots().listen((event) {
      paymentDetailsList.clear();
      if(event.docs.isNotEmpty){
int x=0;
        for (var element in event.docs) {

          Map<dynamic, dynamic> map = element.data() as Map;
          paymentDetailsList.add(PaymentDetails(
              element.id, map['Amount'].toString(),
              map['Name'].toString(),
              map['PaymentApp'].toString(),
              map['PhoneNumber'].toString(),
              map['Status'].toString(),
              map['Time'].toString(),
              map["state"].toString(),
              map["district"].toString(),
              map["assembly"]??"",
              map['PaymentUpi'].toString(),
              map['RefNo'].toString(), map['Receipt Status'].toString(),
            '',map["EnrollerName"]??"NILL",map['NameShowStatus'].toString(),
            map["EnrollerId"]??"NILL",map["Platform"]??"NILL",map["DeviceId"]??"NILL",
          ));

          try{
            paymentDetailsList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));

          }catch(e){}

          if(paymentDetailsList.first.status != "Success"){
            // print("FFFFF"+map['Status'].toString()+x.toString());
            // Vibrate.vibrate();
            // final player=AudioCache();
            // player.play('alert.mp3');



          }



          notifyListeners();
        }
      }

    });



    // _streamSubscription=mRoot.child("Payment").child(dayNode).onValue.listen((databaseEvent) {
    //   paymentDetailsList.clear();
    //   filteredPaymentDetailsList.clear();
    //
    //   if (databaseEvent.snapshot.value != null) {
    //     Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
    //     map.forEach((hourKey, hourValue) {
    //       Map<dynamic, dynamic> hourMap = hourValue['HourEntry'];
    //       hourMap.forEach((key, value) {
    //
    //         if( value['Status'].toString()=='Success'){
    //           paymentDetailsList.add(PaymentDetails(
    //               key,
    //               value['Amount'].toString(),
    //               value['Name'],
    //               value['PaymentApp'],
    //               value['PhoneNumber'],
    //               value['Status'],
    //               value['Time'].toString(),
    //               value['Ward'],
    //               value["district"],
    //               value["panchayath"],
    //               value["wardname"],
    //               value["wardnumber"],value['UpiID']??'',value['RefNo']??'')
    //           );
    //           filteredPaymentDetailsList=paymentDetailsList;
    //           filteredPaymentDetailsList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));
    //           notifyListeners();
    //
    //         }
    //
    //
    //
    //         notifyListeners();
    //       });
    //
    //       notifyListeners();
    //     });
    //   }
    //   notifyListeners();
    // });
  }
  void fetchReceiptList(int limit) {
    if(_streamSubscription!=null){
      _streamSubscription!.cancel();
    }


    _streamSubscription=db.collection('MonitorNode').where("Status",isEqualTo: "Success").orderBy('Time',descending: true).limit(limit).snapshots().listen((event) {
      paymentDetailsList.clear();
      if(event.docs.isNotEmpty){
        for (var element in event.docs) {

          Map<dynamic, dynamic> map = element.data();


          paymentDetailsList.add(PaymentDetails(
            element.id, map['Amount'].toString(),
              map['Name'].toString(),
              map['PaymentApp'].toString(),
              map['PhoneNumber'].toString(),
              map['Status'].toString(),
              map['Time'].toString(),
              map["state"].toString(),
              map["district"].toString(),
              map["assembly"]??"",
              map['UpiID'].toString(),
              map['RefNo'].toString(),
              map['Receipt Status'].toString(),'',
              map["EnrollerName"]??"NILL",
              map['NameShowStatus'].toString(),
              map["EnrollerId"]??"NILL",
              map["Platform"]??"NILL",
            map["DeviceId"]??"NILL",
          ));

          try{
            paymentDetailsList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));

          }catch(e){}
          notifyListeners();
        }
      }

    });

    // _streamSubscription=mRoot.child("Payment").child(dayNode).onValue.listen((databaseEvent) {
    //   paymentDetailsList.clear();
    //   filteredPaymentDetailsList.clear();
    //
    //   if (databaseEvent.snapshot.value != null) {
    //     Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
    //     map.forEach((hourKey, hourValue) {
    //       Map<dynamic, dynamic> hourMap = hourValue['HourEntry'];
    //       hourMap.forEach((key, value) {
    //
    //         if( value['Status'].toString()=='Success'){
    //           paymentDetailsList.add(PaymentDetails(
    //               key,
    //               value['Amount'].toString(),
    //               value['Name'],
    //               value['PaymentApp'],
    //               value['PhoneNumber'],
    //               value['Status'],
    //               value['Time'].toString(),
    //               value['Ward'],
    //               value["district"],
    //               value["panchayath"],
    //               value["wardname"],
    //               value["wardnumber"],value['UpiID']??'',value['RefNo']??'')
    //           );
    //           filteredPaymentDetailsList=paymentDetailsList;
    //           filteredPaymentDetailsList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));
    //           notifyListeners();
    //
    //         }
    //
    //
    //
    //         notifyListeners();
    //       });
    //
    //       notifyListeners();
    //     });
    //   }
    //   notifyListeners();
    // });
  }


  void fetchDetails() {
    mRoot.child('0').onValue.listen((event) {
      if(event.snapshot.exists){
      Map<dynamic,dynamic> map = event.snapshot.value as Map;
      termsAndCondition=map['TermsAndCondition'];
      aboutUs=map['AboutUs'];
      contactNumber=map['PhoneNumber']??'';
      contactUs=map['PhoneNumber2']??'';
      contactTime=map['AvailableTime']??'';
      iosPaymentGateway=map['IosPaymentGateway']??'';
      }
    });
  }

  void searchPayments(String query,BuildContext context) {
    print("queryaaaqqqq"+query.toString());
    showLoadingIndicator(context);

    paymentDetailsList.clear();
    notifyListeners();
    if(_streamSubscription!=null){

      _streamSubscription!.cancel();

    }

    db.collection('Payments').where('PhoneNumber',isEqualTo: query).get().then((value) {
      print("code here1111111111");
      if(value.docs.isNotEmpty){
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;

          if(!paymentDetailsList.map((item) => item.id).contains(element.id)){
            print("code here2222222");
            // String receiptStatus="notViewed";
            // if( element.data().containsKey("Receipt Status")){
            //   receiptStatus="Viewed";
            // }





            paymentDetailsList.add(PaymentDetails(
                element.id,
                map['Amount'].toString(),
                map['Name'].toString(),
                map['PaymentApp'].toString(),
                map['PhoneNumber'].toString(),
                map['Status'].toString(),
                map['Time'].toString(),
                map["state"].toString(),
                map["district"].toString(),
                map["assembly"]??"",
                map['UpiID'].toString(),
                map['RefNo'].toString(),
                map['Receipt Status'].toString(),
                '',
                map["EnrollerName"]??"NILL",
                map["NameShowStatus"].toString(),
                map["EnrollerId"]??"NILL",
                map["Platform"]??"NILL",map["DeviceId"]??"NILL",
            ));
            try{
              paymentDetailsList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));

            }catch(e){}
          }

          notifyListeners();
        }
      }


    });

    print("sdkfmkf"+query);
    db.collection('Payments').where('ID',isEqualTo: query).get().then((value) {
      if(value.docs.isNotEmpty){
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;
          if(!paymentDetailsList.map((item) => item.id).contains(element.id)){
            // String receiptStatus="notViewed";
            // if( element.data().containsKey("Receipt Status")){
            //   receiptStatus="Viewed";
            // }
            paymentDetailsList.add(PaymentDetails(
                element.id,
                map['Amount'].toString(),
                map['Name'].toString(),
                map['PaymentApp'].toString(),
                map['PhoneNumber'].toString(),
                map['Status'].toString(),
                map['Time'].toString(),
                map["state"].toString(),
                map["district"].toString(),
                map["assembly"]??"",
                map['UpiID'].toString(),
                map['RefNo'].toString(),
                map['Receipt Status'].toString(),
              '',map["EnrollerName"]??"NILL",
              map['NameShowStatus'].toString(),
              map["EnrollerId"]??"NILL",
                map["Platform"]??"NILL",
              map["DeviceId"]??"NILL",
            ));
            try{
              paymentDetailsList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));

            }catch(e){}
            notifyListeners();

          }


        }
      }
    });
    Future.delayed(const Duration(seconds: 1), () {
      finish(context);

    });
  }
int transactionFetchCount = 0;
  // void wardReceiptListWithoutLimit(WardTotalModel unit) {
  //   print("cccccode hger");
  //
  //   print("cccccod33333 "+unit.district.toString());
  //   print("cccccode hger2222 "+unit.assembly.toString());
  //   print("cccccode466666 "+unit.panchayath.toString());
  //   print("cccccod444444 "+unit.wardname.toString());
  //   modelUnit=unit;
  //   wardTotal=0;
  //   wardTotalTransactionsCount=0.0;
  //   fetchWardTotal(unit);
  //   if(_streamSubscription!=null){
  //     _streamSubscription!.cancel();
  //   }
  //   _streamSubscription=db.collection('Payments')
  //       .where('wardName',isEqualTo: unit.wardname)
  //       .where('panchayath',isEqualTo: unit.panchayath)
  //       .where('district',isEqualTo: unit.district)
  //       .orderBy('Amount',descending: true)
  //       .snapshots().listen((value) {
  //     paymentDetailsList.clear();
  //     wardTotalTransactionsCount=0.0;
  //
  //     if(value.docs.isNotEmpty){
  //       print("cccccode hger22222");
  //
  //
  //       for (var element in value.docs) {
  //         print("ewfweheellowise "+element.id.toString());
  //
  //         // String receiptStatus="notViewed";
  //         // if( element.data().containsKey("Receipt Status")){
  //         //   receiptStatus="Viewed";
  //         // }
  //         Map<dynamic, dynamic> map = element.data() as Map;
  //
  //
  //
  //         paymentDetailsList.add(PaymentDetails(
  //             element.id, map['Amount'].toString(),
  //             map['Name'].toString(),
  //             map['PaymentApp'].toString(),
  //             map['PhoneNumber'].toString(),
  //             map['Status'].toString(),
  //             map['Time'].toString(),
  //             map["state"].toString(),
  //             map["district"].toString(),
  //             map["assembly"]??"",
  //             map['UpiID'].toString(),
  //             map['RefNo'].toString(),
  //             map['Receipt Status'].toString(),'',
  //             map["EnrollerName"]??"NILL",
  //             map['NameShowStatus'].toString(),
  //             map["EnrollerId"]??"NILL",
  //             map["Platform"]??"NILL",
  //           map["DeviceId"]??"NILL",
  //         ));
  //         print("aaaaaaaaaaqqqqq"+paymentDetailsList.length.toString());
  //         wardTotalTransactionsCount=paymentDetailsList.length.toDouble();
  //
  //         try{
  //           // paymentDetailsList.sort((a, b) => int.parse(b.amount).compareTo(int.parse(a.amount)));
  //
  //         }catch(e){}
  //         checkStarRating();
  //
  //         notifyListeners();
  //       }
  //     }else{
  //       print("issempty");
  //     }
  //
  //   });
  //
  // }
  // void wardReceiptList(WardTotalModel unit,int limit) {
  //   print("cccccode hger");
  //   print("cccccode hger3333 "+unit.wardname.toString());
  //   print("cccccode hger2222 "+unit.assembly.toString());
  //   print("cccccode hger111 "+unit.district.toString());
  //   modelUnit=unit;
  //   wardTotal=0;
  //   wardTotalTransactionsCount=0.0;
  //   fetchWardTotal(unit);
  //   if(_streamSubscription!=null){
  //     _streamSubscription!.cancel();
  //   }
  //   _streamSubscription=db.collection('Payments')
  //       .where('wardname',isEqualTo: unit.wardname)
  //       .where('panchayath',isEqualTo: unit.panchayath)
  //       .where('district',isEqualTo: unit.district)
  //       .orderBy('Time',descending: true)
  //       .limit(limit).snapshots().listen((value) {
  //     paymentDetailsList.clear();
  //     wardTotalTransactionsCount=0.0;
  //
  //     if(value.docs.isNotEmpty){
  //       print("cccccode hger22222");
  //
  //
  //       for (var element in value.docs) {
  //         print("ewfweheellowise "+element.id.toString());
  //
  //         // String receiptStatus="notViewed";
  //         // if( element.data().containsKey("Receipt Status")){
  //         //   receiptStatus="Viewed";
  //         // }
  //         Map<dynamic, dynamic> map = element.data() as Map;
  //
  //
  //
  //         paymentDetailsList.add(PaymentDetails(
  //             element.id, map['Amount'].toString(),
  //             map['Name'].toString(),
  //             map['PaymentApp'].toString(),
  //             map['PhoneNumber'].toString(),
  //             map['Status'].toString(),
  //             map['Time'].toString(),
  //             map["state"].toString(),
  //             map["district"].toString(),
  //             map["assembly"]??"",
  //             map['UpiID'].toString(),
  //             map['RefNo'].toString(),
  //             map['Receipt Status'].toString(),'',
  //             map["EnrollerName"]??"NILL",
  //             map['NameShowStatus'].toString(),
  //             map["EnrollerId"]??"NILL",
  //             map["Platform"]??"NILL",
  //           map["DeviceId"]??"NILL",
  //         ));
  //         print("aaaaaaaaaaqqqqq"+paymentDetailsList.length.toString());
  //         wardTotalTransactionsCount=paymentDetailsList.length.toDouble();
  //
  //         try{
  //           paymentDetailsList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));
  //
  //         }catch(e){}
  //         checkStarRating();
  //
  //         notifyListeners();
  //       }
  //     }else{
  //       print("issempty");
  //     }
  //
  //   });
  //
  // }



  void assemblyReceiptListWithoutLimit(AssemblyTotalModel unit) {
    modelUnit = unit;
    assemblyReceiptTotal = 0;
    assemblyTotalTransactionsCount = 0.0;
    fetchAssemblyReceiptTotal(unit);
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }
    _streamSubscription = db
        .collection('Payments')
        .where('state', isEqualTo: unit.state)
        .where('assembly', isEqualTo: unit.assembly)
        .where('district', isEqualTo: unit.district)
    // .orderBy('Time',descending: true)
    // .limit(limit)
        .snapshots()
        .listen((value) {
      assemblyTotalTransactionsCount = 0.0;

      if (value.docs.isNotEmpty) {
        paymentDetailsList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          paymentDetailsList.add(PaymentDetails(
              element.id.toString(),
              map["Amount"].toString(),
              map["Name"].toString(),
              map["PaymentApp"].toString(),
              map["PhoneNumber"].toString(),
              map["Status"].toString(),
              map["Time"].toString(),
              map["state"].toString(),
              map["district"].toString(),
              map["assembly"].toString(),
              map["UpiID"].toString(),
              map["RefNo"].toString(),
              map["Receipt Status"].toString(),
              map["PaymentUpi"].toString(),
              map["EnrollerName"] ?? "NILL",
              map['NameShowStatus'].toString(),
              map["EnrollerId"] ?? "NILL",
              map["Platform"]??"NILL",
              map["DeviceId"]??"NILL",
          ));
          assemblyTotalTransactionsCount = paymentDetailsList.length.toDouble();
          try {
            paymentDetailsList
                .sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));
          } catch (e) {}
          // checkStarRating();

          notifyListeners();
        }
      } else {
      }

    });

  }

  void assemblyReceiptList(AssemblyTotalModel unit, int limit) {
    modelUnit = unit;
    assemblyReceiptTotal = 0;
    assemblyTotalTransactionsCount = 0.0;
    fetchAssemblyReceiptTotal(unit);
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }
    _streamSubscription = db
        .collection('Payments')
        .where('state', isEqualTo: unit.state)
        .where('assembly', isEqualTo: unit.assembly)
        .where('district', isEqualTo: unit.district)
    // .orderBy('Time',descending: true)
        .limit(limit)
        .snapshots()
        .listen((value) {
      assemblyTotalTransactionsCount = 0.0;

      if (value.docs.isNotEmpty) {
        paymentDetailsList.clear();

        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          paymentDetailsList.add(PaymentDetails(
              element.id.toString(),
              map["Amount"].toString(),
              map["Name"].toString(),
              map["PaymentApp"].toString(),
              map["PhoneNumber"].toString(),
              map["Status"].toString(),
              map["Time"].toString(),
              map["state"].toString(),
              map["district"].toString(),
              map["assembly"].toString(),
              map["UpiID"].toString(),
              map["RefNo"].toString(),
              map["Receipt Status"].toString(),
              map["PaymentUpi"].toString(),
              map["EnrollerName"] ?? "NILL",
              map['NameShowStatus'].toString(),
              map["EnrollerId"] ?? "NILL",
            map["Platform"]??"NILL",
            map["DeviceId"]??"NILL",));
          assemblyTotalTransactionsCount = paymentDetailsList.length.toDouble();
          try {
            paymentDetailsList
                .sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));
          } catch (e) {}
          notifyListeners();
        }
      } else {
      }

    });

  }

  void fetchAssemblyReceiptTotal(AssemblyTotalModel unit) {
    assemblyReceiptTotal = 0;
    if (_streamSubscriptionWardTotal != null) {
      _streamSubscriptionWardTotal!.cancel();
    }
    _streamSubscriptionWardTotal = db
        .collection('AssemblyTotalAmount')
        .doc('${unit.state}_${unit.district}_${unit.assembly}')
        .snapshots()
        .listen((event) {
      if (event.exists) {
        assemblyReceiptTotal = double.parse(event.get('Amount').toString());
        notifyListeners();
      }
    });
  }

  void refreshAssembly(AssemblyTotalModel unit, BuildContext context) {
    showLoadingIndicator(context);
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }

    _streamSubscription = db
        .collection('Payments')
        .where('state', isEqualTo: unit.state.toString())
        .where('assembly', isEqualTo: unit.assembly.toString())
        .where('district', isEqualTo: unit.district.toString())
        .snapshots()
        .listen((value) {
      assemblyReceiptTotal = 0;
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          assemblyReceiptTotal = assemblyReceiptTotal +
              double.parse(
                  element.get('Amount').toString().replaceAll(",", ""));
          if (value.docs.last.id == element.id) {
            db
                .collection('AssemblyTotalAmount')
                .doc('${unit.state}_${unit.district}_${unit.assembly}')
                .set({"Amount": assemblyReceiptTotal}, SetOptions(merge: true));
            Future.delayed(const Duration(seconds: 1), () {
              finish(context);

            });
          }
          notifyListeners();
        }
      } else {
        print("emppptyy");
        assemblyReceiptTotal = 0;
        notifyListeners();
        finish(context);

      }

    });
  }


  Future<void> getAllAssebmly() async {
    assemblyList = await WardsService(newWardMap,hideWardMap).fetchAllAssemblies();
  }

  // Future<void> fetchDropdown(String from, var item) async {
  //   print("fetchdropdownfunctionworkhere");
  //
  //
  //
  //   switch (from) {
  //     case '':
  //
  //       filter=false;
  //       panchayathPosterComplete=false;
  //       panchayathPosterNotCompleteComplete=false;
  //       panchayathTarget=0.0;
  //       districtList.clear();
  //       panjayathList.clear();
  //       unitList.clear();
  //       selectedDistrict=null;
  //       districtList = await WardsService(newWardMap,hideWardMap).getDistrict();
  //       print("districtListmmm"+districtList.length.toString());
  //
  //       break;
  //     case 'District':
  //       filter=true;
  //       panchayathPosterComplete=false;
  //       panchayathPosterNotCompleteComplete=false;
  //       panchayathTarget=0.0;
  //       selectedDistrict=item;
  //       selectedAssembly=null;
  //       assemblyTc.clear();
  //       assemblyList.clear();
  //       panjayathList.clear();
  //       unitList.clear();
  //       if(item!='All'){
  //         assemblyList = await WardsService(newWardMap,hideWardMap).getAssembly(item,'');
  //         fetchDistrict(item);
  //       }else{
  //         filter=false;
  //         fetchWard();
  //       }
  //       break;
  //     case 'Assembly':
  //       filter=true;
  //       panchayathPosterComplete=false;
  //       panchayathPosterNotCompleteComplete=false;
  //       panchayathTarget=0.0;
  //       selectedAssembly=item.assembly;
  //       selectedPanjayath=null;
  //       panjayathTc.clear();
  //       panjayathList.clear();
  //       unitList.clear();
  //       AssemblyModel assemblyModel = item;
  //       if(assemblyModel.assembly!='All'){
  //         panjayathList = await WardsService(newWardMap,hideWardMap).getPanjayath(assemblyModel.district,assemblyModel.assembly);
  //         fetchAssembly(item);
  //       }else{
  //         filter=false;
  //         fetchWard();
  //       }
  //       break;
  //     case 'Panjayath':
  //       filter=true;
  //       panchayathPosterComplete=false;
  //       panchayathPosterNotCompleteComplete=false;
  //       selectedUnit=null;
  //       unitTc.clear();
  //       selectedPanjayath =item;
  //       unitList.clear();
  //       PanjayathModel panjayathModel =item;
  //       if(panjayathModel.panjayath!='All'){
  //         unitList = await WardsService(newWardMap,hideWardMap).getUnit(panjayathModel.district,panjayathModel.assembly,panjayathModel.panjayath);
  //         fetchPanjayath(item);
  //       }else{
  //         // fetchDistrict(panjayathModel.district);
  //         fetchAssembly(AssemblyModel(selectedUnit!.district, selectedUnit!.assembly));
  //       }
  //       break;
  //     case 'Unit':
  //       filter=true;
  //       selectedUnit=item;
  //       if(selectedUnit!.unit!='All'){
  //         onWardSearch(item);
  //       }else{
  //         fetchPanjayath(PanjayathModel(selectedUnit!.district, selectedUnit!.assembly,selectedUnit!.panjayath,0));
  //       }
  //       break;
  //   }
  //
  //   notifyListeners();
  // }

  fetchDropdown(var item){
    filter = true;
    selectedAssembly = item.assembly;
    AssemblyDropListModel assemblyDropListModel = item;
    if (assemblyDropListModel.assembly != 'All') {
      fetchAssemblyTotal(item);
    } else {
      filter = false;
      fetchWholeAssemblyTotal();
    }
  }

  List<String> stateList = [];
  List<AssemblyDropListModel> assemblyDropList = [];
  String? selectedState;
  Map<dynamic,dynamic> hideStateMap = {};

  fetchReportState() async {
    filterCollection =0;
    filter = false;
    stateList.clear();
    districtList.clear();
    assemblyDropList.clear();
    selectedState = null;

    List<String> baseStateList = [];
    List<String> jsonStateList = [];
    List<String> hideStateList = [];
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    mRoot.child('NewAssembly').onValue.listen((databaseEvent) {
      Map <dynamic, dynamic> map = jsonResponse as Map;
      jsonStateList.clear();
      jsonStateList.add('All');
      map.forEach((key, value) {
        if(!jsonStateList.contains(value['State'].toString())){
          jsonStateList.add(value['State'].toString());
        }
      });

      if (databaseEvent.snapshot.value != null) {
        Map<dynamic, dynamic> baseMap = databaseEvent.snapshot.value as Map;
        baseStateList.clear();
        baseMap.forEach((key, value) {
          if(!baseStateList.contains(value['State'].toString())){
            baseStateList.add(value['State'].toString());
          }
        });
        notifyListeners();
      }

      mRoot.child('hideAssembly').onValue.listen((databaseEvent) {

        hideStateList.clear();
        if (databaseEvent.snapshot.value != null) {
          hideStateMap= databaseEvent.snapshot.value as Map;
          Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
          map.forEach((key, value) {
            if(!hideStateList.contains(value['State'].toString())){
              hideStateList.add(value['State'].toString());
            }
          });
          stateList=jsonStateList+baseStateList;

          stateList.removeWhere((item1) => hideStateList.any((item2) => (item1 == item2)));

          notifyListeners();
        }else{
          print("hiii welccomeee");
          stateList=jsonStateList+baseStateList;

        }

      });



    });
  }


  fetchReportDistrict(var item) async {
    filter = true;
    selectedState = item;
    selectedDistrict = null;
    selectedAssembly = null;
    districtList.clear();
    assemblyDropList.clear();
    assemblyTc.clear();
    print(item.toString()+"kffffffffffff");
    if (item != 'All') {
      print("fmmmmmmmm");
      List<DistrictDropListModel> jsonDistrictList = [];
      var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
      var jsonResponse = json.decode(jsonText.toString());
      mRoot.child('NewAssembly').onValue.listen((databaseEvent) {
        Map <dynamic, dynamic> map = jsonResponse as Map;
        jsonDistrictList.add(DistrictDropListModel(item,'All'));
        map.forEach((key, value) {
          if(value['State'].toString()==item){
            if(!jsonDistrictList.map((item) => item.district).contains(value['District'].toString())){
              jsonDistrictList.add(DistrictDropListModel(item, value['District'].toString()));
            }
          }
        });

        if (databaseEvent.snapshot.value != null) {
          Map<dynamic, dynamic> baseMap = databaseEvent.snapshot.value as Map;
          baseMap.forEach((key, value) {
            if(value['State'].toString()==item){
              if(!jsonDistrictList.map((item) => item.district).contains(value['District'].toString())){
                jsonDistrictList.add(DistrictDropListModel(item, value['District'].toString()));
              }
            }
          });
          notifyListeners();
        }
        districtList=jsonDistrictList;
      });
      fetchStateTotal(item);
    }
    else {
      print("nnnnnnnnnnnnnnnnn");

      filter = false;
      fetchWholeAssemblyTotal();
    }
  }

  fetchReportAssembly(var item) async {
    filter = true;
    selectedDistrict = item.district;
    selectedAssembly = null;
    assemblyDropList.clear();
    DistrictDropListModel districtDropListModel = item;
    print(item);
    if (districtDropListModel.district != 'All') {
      print("klllklklk");
      List<AssemblyDropListModel> jsonAssemblyList = [];
      var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
      var jsonResponse = json.decode(jsonText.toString());
      mRoot.child('NewAssembly').onValue.listen((databaseEvent) {
        Map <dynamic, dynamic> map = jsonResponse as Map;
        map.forEach((key, value) {
          if(value['District'].toString()==item.district&&value['State'].toString()==item.state){
            if(!jsonAssemblyList.map((item2) => item2.assembly).contains(value['Assembly'].toString())){
              jsonAssemblyList.add(AssemblyDropListModel(item.state,item.district,value['Assembly']));
            }
          }
        });

        if (databaseEvent.snapshot.value != null) {
          Map<dynamic, dynamic> baseMap = databaseEvent.snapshot.value as Map;
          baseMap.forEach((key, value) {
            if(value['District'].toString()==item.district&&value['State'].toString()==item.state){
              if(!jsonAssemblyList.map((item2) => item2.assembly).contains(value['Assembly'].toString())){
                jsonAssemblyList.add(AssemblyDropListModel(item.state,item.district,value['Assembly']));
              }
            }
          });
          notifyListeners();
        }
        assemblyDropList=jsonAssemblyList;
      });
      fetchDistrictTotal(item);
    } else {
      print("zjsuyetyu");
      filter = false;
      fetchStateTotal(item.state);
    }
  }






  void fetchWholeAssemblyTotal() {
    if (unitStream != null) {
      unitStream!.cancel();
    }
    unitStream = db
        .collection('AssemblyTotalAmount')
        .orderBy('Amount', descending: true)
        .limit(10)
        .snapshots()
        .listen((event) {
      assemblyTotalList.clear();
      filterCollection = 0;
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          try{
            filterCollection =
                filterCollection + double.parse(element.get('Amount').toString());
            assemblyTotalList.add(AssemblyTotalModel(
                double.parse(element.get('Amount').toString()),
                element.get('state'),
                element.get('district'),
                element.get('assembly')));
            notifyListeners();
          }catch(e){
          }
        }
      }
      notifyListeners();
    });
  }



  void fetchStateTotal(String state) {
    if (unitStream != null) {
      unitStream!.cancel();
    }
    unitStream = db
        .collection('AssemblyTotalAmount')
        .where('state', isEqualTo: state)
        .orderBy('Amount', descending: true)
        .snapshots()
        .listen((event) {
      assemblyTotalList.clear();
      filterCollection = 0;
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          filterCollection =
              filterCollection + double.parse(element.get('Amount').toString());
          assemblyTotalList.add(AssemblyTotalModel(
            double.parse(element.get('Amount').toString()),
            element.get('state'),
            element.get('district'),
            element.get('assembly'),
          ));
          notifyListeners();
        }
        assemblyTotalList.sort((a, b) => b.amount.compareTo(a.amount));

        if (assemblyTotalList.length > 19) {
          assemblyTotalList = assemblyTotalList.getRange(0, 19).toList();
        }
      }
      notifyListeners();
    });
  }

  void fetchDistrictTotal(DistrictDropListModel item) {
    if (unitStream != null) {
      unitStream!.cancel();
    }
    unitStream = db
        .collection('AssemblyTotalAmount')
        .where('district', isEqualTo: item.district)
        .where('state', isEqualTo: item.state)
        .snapshots()
        .listen((event) {
      assemblyTotalList.clear();
      filterCollection = 0;
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          filterCollection =
              filterCollection + double.parse(element.get('Amount').toString());
          assemblyTotalList.add(AssemblyTotalModel(
            double.parse(element.get('Amount').toString()),
            element.get('state'),
            element.get('district'),
            element.get('assembly'),
          ));
          notifyListeners();
        }
        assemblyTotalList.sort((a, b) => b.amount.compareTo(a.amount));

        if (assemblyTotalList.length > 19) {
          assemblyTotalList = assemblyTotalList.getRange(0, 19).toList();
        }
      }
      notifyListeners();
    });
  }

  void fetchAssemblyTotal(AssemblyDropListModel item) {
    if (unitStream != null) {
      unitStream!.cancel();
    }
    unitStream = db
        .collection('AssemblyTotalAmount')
        .where('district', isEqualTo: item.district)
        .where('assembly', isEqualTo: item.assembly)
        .where('state', isEqualTo: item.state)
        .snapshots()
        .listen((event) {
      assemblyTotalList.clear();
      filterCollection = 0;
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          filterCollection =
              filterCollection + double.parse(element.get('Amount').toString());
          assemblyTotalList.add(AssemblyTotalModel(
            double.parse(element.get('Amount').toString()),
            element.get('state'),
            element.get('district'),
            element.get('assembly'),
          ));
          notifyListeners();
        }
        assemblyTotalList.sort((a, b) => b.amount.compareTo(a.amount));
        if (assemblyTotalList.length > 19) {
          assemblyTotalList = assemblyTotalList.getRange(0, 19).toList();
        }
      }
      notifyListeners();
    });
  }



  // Future<void> fetchDropdown(String from, var item) async {
  //
  //   switch (from) {
  //     case '':
  //
  //       filter=false;
  //       districtList.clear();
  //
  //       panjayathList.clear();
  //       assemblyList.clear();
  //       unitList.clear();
  //       chipsetBoothList.clear();
  //       selectedDistrict=null;
  //       districtList = await WardsService(newWardMap).getDistrict();
  //
  //       break;
  //     case 'District':
  //       filter=true;
  //       selectedDistrict=item;
  //       selectedPanjayath=null;
  //       chipsetBoothList.clear();
  //       assemblyList.clear();
  //       assemblyTc.clear();
  //       panjayathList.clear();
  //       unitList.clear();
  //       if(item!='All'){
  //         assemblyList = await WardsService(newWardMap).getAssembly(item);
  //         // mandalamList = await WardsService(newWardMap).getMandalam(item);
  //         print(item.toString()+"wisedistrictee"+mandalamList.length.toString());
  //         fetchDistrict(item);
  //       }else{
  //         filter=false;
  //         fetchWard();
  //       }
  //       break;
  //     case 'Assembly':
  //       filter=true;
  //
  //       selectedAssembly=item.assembly;
  //
  //       // assemblyTc.clear();
  //       // assemblyList.clear();
  //       unitList.clear();
  //       AssemblyModel assemblyModel = item;
  //       if(assemblyModel.assembly!='All'){
  //         blockList = await WardsService(newWardMap).getBlock(assemblyModel.district,assemblyModel.assembly);
  //         print(item.assembly.toString()+"enrijw1234");
  //         fetchAssembly(item);
  //       }else{
  //         print(item.assembly.toString()+"enrwerty5567");
  //         filter=false;
  //         fetchWard();
  //       }
  //       break;
  //     case 'Block':
  //       filter=true;
  //
  //       selectedBlock=item.block;
  //
  //       // blockTc.clear();
  //       // blockList.clear();
  //       unitList.clear();
  //       BlockModel blockModel = item;
  //       if(blockModel.block!='All'){
  //         mandalamList = await WardsService(newWardMap).getMandalam(blockModel.district,blockModel.assembly,blockModel.block);
  //         print(item.assembly.toString()+"enrijw1234");
  //         fetchBlock(item);
  //       }else{
  //         print(item.assembly.toString()+"enrwerty5567");
  //         filter=false;
  //         fetchWard();
  //       }
  //       break;
  //     case 'Mandalam':
  //       filter=true;
  //       print(item.mandalam.toString()+"enrijw");
  //       selectedMandalam=item.mandalam;
  //
  //       // mandalamTc.clear();
  //       // mandalamList.clear();
  //       unitList.clear();
  //       MandalamModel mandalamModel = item;
  //       if(mandalamModel.mandalam!='All'){
  //         chipsetBoothList = await WardsService(newWardMap).getMandalamBooth(mandalamModel.district,mandalamModel.assembly,mandalamModel.block,mandalamModel.mandalam);
  //         print(item.mandalam.toString()+"enrijw1234"+chipsetBoothList.length.toString()+"dasedf");
  //         fetchMandalam(item);
  //       }else{
  //         print(item.mandalam.toString()+"enrwerty5567");
  //         filter=false;
  //         fetchWard();
  //       }
  //       break;
  //     case 'Booth':
  //       filter=true;
  //       selectedBooth=item;
  //       if(selectedBooth!.booth!='All'){
  //         print("wedselectReport"+selectReport.toString());
  //         onWardSearch(item);
  //
  //         // selectReport=="ASSEMBLY"? onWardSearch(item):onMandalalmBoothSearch(item);
  //         // onMandalalmBoothSearch(item);
  //       }else{
  //         // fetchPanjayath(PanjayathModel(selectedUnit!.district, selectedUnit!.panjayath));
  //       }
  //       break;
  //   }
  //
  //   notifyListeners();
  // }


  // void onMandalalmBoothSearch(WardModel selectedUnit) {
  //   print("onMandalalmBoothSearch");
  //   if(unitStream!=null){
  //     unitStream!.cancel();
  //   }
  //   unitStream=
  //       db
  //       .collection('WardTotalAmount')
  //       .where('district',isEqualTo: selectedBooth.district)
  //       .where('mandalam',isEqualTo: selectedBooth.mandalam)
  //       .where('booth',isEqualTo: selectedBooth.booth)
  //       .snapshots()
  //       .listen((event) {
  //     wardTotalList.clear();
  //     filterCollection=0;
  //     if (event.docs.isNotEmpty) {
  //       for (var element in event.docs) {
  //         filterCollection=filterCollection+double.parse(element.get('Amount').toString());
  //         wardTotalList.add(WardTotalModel(
  //             double.parse(element.get('Amount').toString()),
  //             element.get('district'),
  //             element.get('assembly'),
  //             element.get('booth'),));
  //         notifyListeners();
  //       }
  //     }
  //     notifyListeners();
  //
  //   });
  // }
  void onWardSearch(UnitModel selectedBooth) {
    print("onwaardsearchnsdjn");
    if(unitStream!=null){
      unitStream!.cancel();
    }
    unitStream=
        db
        .collection('WardTotalAmount')
            .where('district',isEqualTo: selectedUnit?.district)
            .where('assembly',isEqualTo: selectedUnit?.assembly)
            .where('panchayath',isEqualTo: selectedUnit?.panjayath)
            .where('wardname',isEqualTo: selectedUnit?.unit)
        .snapshots()
        .listen((event) {
      wardTotalList.clear();
      filterCollection=0;
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          filterCollection=filterCollection+double.parse(element.get('Amount').toString());
          wardTotalList.add(WardTotalModel(
            double.parse(element.get('Amount').toString()),
            element.get('district'),
            element.get('assembly'),
            element.get('panchayath'),
            element.get('wardname'),element.get("Target").toString()));
          notifyListeners();
        }
      }
      notifyListeners();

    });
  }

  void fetchDistrict(String district) {
    String dhotis='';
    if(unitStream!=null){
      unitStream!.cancel();
    }
    unitStream=
        db.collection('WardTotalAmount').where('district',isEqualTo: district).orderBy('Amount',descending: true).snapshots().listen((event) {
          wardTotalList.clear();
          filterCollection=0;
          if (event.docs.isNotEmpty) {
            for (var element in event.docs) {
              print(element.id.toString()+"sddqqw122");
              filterCollection=filterCollection+double.parse(element.get('Amount').toString());
              wardTotalList.add(WardTotalModel(
                double.parse(element.get('Amount').toString()),
                element.get('district'), element.get('assembly'), element.get('panchayath'), element.get('wardname'),element.get("Target").toString()));
              notifyListeners();
            }
            wardTotalList.sort((a, b) => b.amount.compareTo(a.amount));

            if(wardTotalList.length>19){
              wardTotalList =  wardTotalList.getRange(0, 19).toList();
            }
          }
          notifyListeners();

        });
  }
  void fetchAssembly(AssemblyModel item) {
    if(unitStream!=null){
      unitStream!.cancel();
    }
    unitStream=
        db.collection('WardTotalAmount')
            .where('district',isEqualTo: item.district)
            .where('assembly',isEqualTo: item.assembly)
            .snapshots()
            .listen((event) {
          wardTotalList.clear();
          filterCollection=0;
          if (event.docs.isNotEmpty) {
            for (var element in event.docs) {
              print(element.id.toString()+"shgtgbhs");
              filterCollection=filterCollection+double.parse(element.get('Amount').toString());
              wardTotalList.add(WardTotalModel(
                double.parse(element.get('Amount').toString()),
                element.get('district'),
                element.get('assembly'),
                element.get('panchayath'),
                element.get('wardname'),element.get("Target").toString()));


              notifyListeners();
            }
            wardTotalList.sort((a, b) => b.amount.compareTo(a.amount));

            if(wardTotalList.length>19){
              wardTotalList =  wardTotalList.getRange(0, 19).toList();
            }
          }
          notifyListeners();

        });
  }
  // void fetchBlock(BlockModel item) {
  //   if(unitStream!=null){
  //     unitStream!.cancel();
  //   }
  //   unitStream=
  //       db
  //           .collection('WardTotalAmount')
  //           .where('district',isEqualTo: item.district)
  //           .where('assembly',isEqualTo: item.assembly).where('block',isEqualTo: item.block)
  //           .snapshots()
  //           .listen((event) {
  //         wardTotalList.clear();
  //         filterCollection=0;
  //         if (event.docs.isNotEmpty) {
  //           for (var element in event.docs) {
  //             filterCollection=filterCollection+double.parse(element.get('Amount').toString());
  //             wardTotalList.add(WardTotalModel(
  //               double.parse(element.get('Amount').toString()),
  //               element.get('district'),
  //               element.get('assembly'),
  //               element.get('booth'),));
  //
  //
  //             notifyListeners();
  //           }
  //           wardTotalList.sort((a, b) => b.amount.compareTo(a.amount));
  //
  //           if(wardTotalList.length>19){
  //             wardTotalList =  wardTotalList.getRange(0, 19).toList();
  //           }
  //         }
  //         notifyListeners();
  //
  //       });
  // }
  // void fetchMandalam(MandalamModel item) {
  //   if(unitStream!=null){
  //     unitStream!.cancel();
  //   }
  //   unitStream=
  //       db
  //           .collection('WardTotalAmount')
  //           .where('district',isEqualTo: item.district).where('assembly',isEqualTo: item.assembly).where('block',isEqualTo: item.block)
  //           .where('mandalam',isEqualTo: item.mandalam)
  //           .snapshots()
  //           .listen((event) {
  //         wardTotalList.clear();
  //         filterCollection=0;
  //         if (event.docs.isNotEmpty) {
  //           for (var element in event.docs) {
  //             filterCollection=filterCollection+double.parse(element.get('Amount').toString());
  //             wardTotalList.add(WardTotalModel(
  //               double.parse(element.get('Amount').toString()),
  //               element.get('district'),
  //               element.get('assembly'),
  //               element.get('booth'),));
  //
  //
  //             notifyListeners();
  //           }
  //           wardTotalList.sort((a, b) => b.amount.compareTo(a.amount));
  //
  //           if(wardTotalList.length>19){
  //             wardTotalList =  wardTotalList.getRange(0, 19).toList();
  //           }
  //
  //         }
  //         notifyListeners();
  //
  //       });
  // }
  bool panchayathPosterComplete=false;
  bool panchayathPosterNotCompleteComplete=false;

  String panchayathPosterPanchayath="";
  String panchayathPosterAssembly="";
  String panchayathPosterDistrict="";
  void fetchPanjayath(PanjayathModel item) {
    panchayathTarget=0.0;
    panchayathPosterPanchayath="";
    panchayathPosterAssembly="";
    panchayathPosterDistrict="";
    if(unitStream!=null){
      unitStream!.cancel();
    }
    unitStream=
        db
            .collection('WardTotalAmount')
            .where('district',isEqualTo: item.district)
            .where('assembly',isEqualTo: item.assembly)
            .where('panchayath',isEqualTo: item.panjayath)
            .snapshots()
            .listen((event) {
          wardTotalList.clear();
          filterCollection=0;
          panchayathTarget=0;
          panchayathPosterComplete=false;
          panchayathPosterNotCompleteComplete=false;
          panchayathPosterPanchayath="";
          panchayathPosterAssembly="";
          panchayathPosterDistrict="";
          if (event.docs.isNotEmpty) {
            for (var element in event.docs) {
              panchayathTarget=panchayathTarget+double.parse(element.get('Target').toString());

              print(panchayathTarget.toString()+"keeee");
              filterCollection=filterCollection+double.parse(element.get('Amount').toString());
              if(filterCollection>=panchayathTarget){
                panchayathPosterComplete=true;
                panchayathPosterNotCompleteComplete=false;
                panchayathPosterPanchayath=item.panjayath.toString();
                panchayathPosterAssembly=item.assembly.toString();
                panchayathPosterDistrict=item.district.toString();
                notifyListeners();

              }else{
                panchayathPosterComplete=false;

                panchayathPosterNotCompleteComplete=true;
                panchayathPosterPanchayath="";
                panchayathPosterAssembly="";
                panchayathPosterDistrict="";
                notifyListeners();

              }
              print(filterCollection.toString()+"wiseecheck2222");


              wardTotalList.add(WardTotalModel(
                double.parse(element.get('Amount').toString()),
                element.get('district'),
                element.get('assembly'),
                element.get('panchayath'),
                element.get('wardname'),element.get("Target").toString()));
              wardTotalList.sort((a, b) => b.amount.compareTo(a.amount));

              notifyListeners();
            }
          }
          notifyListeners();

        });
  }
 
  
  
  void fetchWardTotal(WardTotalModel unit){
    wardTotal=0;
    if(_streamSubscriptionWardTotal!=null){
      _streamSubscriptionWardTotal!.cancel();
    }
    _streamSubscriptionWardTotal= db.collection('WardTotalAmount').doc('${unit.district}_${unit.panchayath}_${unit.wardname}').snapshots().listen((event){
      if (event.exists) {
        wardTotal = double.parse(event.get('Amount').toString());
        notifyListeners();
      }
    });
  }


  // void loopRefreshWard(){
  //
  //   String paymentDistrict = '';
  //   String paymentPanchayath = '';
  //   String paymentWardName = '';
  //   double paymentWardSingleTotal = 0;
  //   double paymentWardTotal = 0;
  //   db.collection('Payments').get().then((snapshot) {
  //
  //     for (var element in snapshot.docs) {
  //       paymentWardTotal = 0;
  //       paymentWardSingleTotal = 0;
  //       paymentDistrict = element.get('district').toString();
  //       paymentPanchayath = element.get('panchayath').toString();
  //       paymentWardName = element.get('wardname').toString();
  //       paymentWardSingleTotal = double.parse( element.get('Amount').toString().replaceAll(",", ""));
  //       db.collection('WardTotalAmount')
  //           .where('district',isEqualTo: paymentDistrict)
  //           .where('panchayath',isEqualTo: paymentPanchayath)
  //           .where('wardname',isEqualTo: paymentWardName).get().then((totalValue) {
  //         if(totalValue.docs.isNotEmpty) {
  //           paymentWardTotal = paymentWardSingleTotal + double.parse( totalValue.docs.first.get('Amount').toString().replaceAll(",", ""));
  //           db.collection('WardTotalAmount').doc('${paymentDistrict}_${paymentPanchayath}_$paymentWardName').update({"Amount": paymentWardTotal});
  //         }else{
  //           print('no value');
  //         }
  //       });
  //     }
  //   });
  // }


  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child:  const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              backgroundColor: Colors.white,
              title:  LoadingIndicator(
                  text: 'Please wait'
              ),
            )
        );
      },
    );
  }

  Future<void> getAppVersion() async {

     PackageInfo.fromPlatform().then((value) {


       currentVersion=value.version;
       buildNumber = value.buildNumber;
       appVersion=buildNumber;




       notifyListeners();
     });

  }

  void onTextChanged(String value, String from) {
    if(from=='Assembly'){
      assemblyTc.text=value;
    }else{
      boothCT.text=value;
    }
    notifyListeners();
  }

  void checkPassword() {
    mRoot.child('0').child('PS').onValue.listen((event) {
      if(event.snapshot.exists){
        String pass=event.snapshot.value.toString();
        DateTime now=DateTime.now();
        int passTime=DateTime(now.year,now.month,now.day,0,0,0,0,0).millisecondsSinceEpoch;
        double passDouble=(passTime/double.parse(pass));
        adminPassword =passDouble.truncate().toString();
      }
    });
  }

  ///admin

  void fetchUpiDetails(String from){
    mRoot.child("0").child("AccountDetials").child("PaymentGateway").child(from).onValue.listen((event) {
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        upiIdController.text = map["UpiId"].toString();
        modeController.text = map["UpiAdd"].toString();
        notifyListeners();
      }
    });
    notifyListeners();
  }


  void getUpiIdListAdmin(){

    mRoot.child("0").child("AccountDetials").child("UPIID").onValue.listen((event) {
      print("FJHYNGBFVDC");
      upiList.clear();
      if (event.snapshot.exists) {
        print("cvcbbvbbvbbvbbbbbbbbb"+event.snapshot.ref.path.toString());
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        print(map.toString()+"cdgvfhdgvbfh");
        map.forEach((key, value) {
          print("GGGGGGGGGGG"+value);
          upiList.add(value);
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  void getModeListAdmin(){
    mRoot.child("0").child("AccountDetials").child("MODE").onValue.listen((event) {
      print("FJHYNGBFVDC");
      modeList.clear();
      if (event.snapshot.exists) {
      print("cvcbbvbbvbbvbbbbbbbbb"+event.snapshot.ref.path.toString());
      Map<dynamic, dynamic> map = event.snapshot.value as Map;
      print(map.toString()+"cdgvfhdgvbfh");
      map.forEach((key, value) {
        print("GGGGGGGGGGG"+value);
        modeList.add(value);
        notifyListeners();
      });
      }
    });
    notifyListeners();
  }

  void updateUpiDetails(String from){
    HashMap<String, Object> map = HashMap();
    map["UpiId"] = upiIdController.text.toString();
    map["UpiAdd"] = modeController.text.toString();
    mRoot.child("0").child("AccountDetials").child("PaymentGateway").child(from).update(map);
    print(map.toString()+"VHHBBBBBBb");
    notifyListeners();
  }

  void clearUpi(){
    upiIdController.clear();
    modeController.clear();
    notifyListeners();
  }
Future<void> checkEnrollerDeviceID() async {
  // String? strDeviceID= "";
  //
  // if(Platform.isAndroid){
  //   strDeviceID= await DeviceInfo().fun_initPlatformState();
  //
  // }else if(Platform.isIOS){
  //   try {
  //     strDeviceID = await UniqueIdentifier.serial;
  //   } on PlatformException {
  //     strDeviceID = 'Failed to get Unique Identifier';
  //   }
  //
  // }else{
  //   print("");
  // }

  String? strDeviceID= "";
  try {
    strDeviceID = await UniqueIdentifier.serial;
  } on PlatformException {
    strDeviceID = 'Failed to get Unique Identifier';
  }
  var enrollerValue = await db.collection("Enrollers").where("DeviceId", isEqualTo:strDeviceID).get();

  if(enrollerValue.docs.isEmpty){
    enrollerDeviceID=false;
    print("exist code here"+enrollerDeviceID.toString());

    notifyListeners();

  }else{
    for (var element in enrollerValue.docs) {
      Map<dynamic, dynamic> map = element.data();
      EnrollerID=map["Phone"].toString();
      EnrollerName=map["Name"].toString();

      notifyListeners();


    }
    enrollerDeviceID=true;
    print("exist code here22"+enrollerDeviceID.toString());
    notifyListeners();

  }



}


  void onSelectVolunteerPanchayath(AssemblyDropListModel? assembly) {
    selectedEnrollerAssembly = assembly;
    if (assembly != null) {
      enrollerStateCT.text = assembly.state;
      enrollerAssemblyCT.text = assembly.assembly;
      enrollerDistrictCT.text = assembly.district;
      notifyListeners();
    }
    notifyListeners();
  }


  Future<void> addEnrollers(BuildContext ctx) async {
    String enrollerId = DateTime.now().millisecondsSinceEpoch.toString();
    // String? strDeviceID= "";
    //
    // if(Platform.isAndroid){
    //   strDeviceID= await DeviceInfo().fun_initPlatformState();
    //
    // }else if(Platform.isIOS){
    //   try {
    //     strDeviceID = await UniqueIdentifier.serial;
    //   } on PlatformException {
    //     strDeviceID = 'Failed to get Unique Identifier';
    //   }
    //
    // }else{
    //   print("");
    // }

    String? strDeviceID= "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    HashMap<String, Object> map = HashMap();
    map["Name"] = entrollerNameCT.text.toString();
    map["Phone"] = entrollerPhoneCT.text.toString();
    map["Place"] = enrollerAssemblyCT.text.toString();
    map["District"] = enrollerDistrictCT.text.toString();
    map["State"] = enrollerStateCT.text.toString();
    map["DeviceId"] = strDeviceID!;

    db.collection("Enrollers").doc(enrollerId).set(map);

    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
      backgroundColor: Colors.blue,
      content: Text("Volunteer Added Successfully."),
      duration: Duration(milliseconds: 3000),
    ));

  }
  void clearEnrollerData(){
    entrollerNameCT.clear();
    entrollerPhoneCT.clear();
    entrollerPlaceCT.clear();
    notifyListeners();
  }

  Future<void> enrollerExistCheck(String phoneNumber) async {
      print(phoneNumber.toString()+"function work");
      checkEnrollerExist=false;

    var enrollerValue = await db.collection("Enrollers").where("Phone", isEqualTo:phoneNumber).get();
    if(enrollerValue.docs.isEmpty){
      checkEnrollerExist=false;
      print("exist code here"+checkEnrollerExist.toString());

      notifyListeners();

    }else{
      for (var element in enrollerValue.docs) {
        Map<dynamic, dynamic> map = element.data();
        EnrollerName=map["Name"].toString();
        EnrollerPlace=map["Place"].toString();

      }

      checkEnrollerExist=true;

      print("exist code here22"+checkEnrollerExist.toString());
      notifyListeners();

    }



}
void addToEnrollList(String name,String phone,String amount,String paymentId,String place){
  String EnId="";

    db.collection("Enrollers").where("Phone",isEqualTo:phone).get().then((value){
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {

          EnId=element.id.toString();
          print(EnId.toString()+"dsfseefsedc");

        }
        print("sdfgdsqqf"+EnId.toString());
        db.collection('Enrollers').doc(EnId).update({"TotalAmount": FieldValue.increment(double.parse(amount))});
        db.collection('Enrollers').doc(EnId).update({"TotalCount": FieldValue.increment(1)});

        HashMap<String, Object> map = HashMap();
        map["EnrollerId"] = phone;
        map["EnrollerName"] = name;
        map["EnrollerPlace"] = place;
        map["EnrolleedTime"] = DateTime.now();
        db.collection("Payments").doc(paymentId).update(map);
        db.collection("MonitorNode").doc(paymentId).update(map);

      }

    });



}

  void checkStarRating(){

    print("Staaaaaarr");

    if(paymentDetailsList.length>=100){
      print("astaarr11");
      starRating=5;
    }else if(paymentDetailsList.length>=75){
      print("astaarr22");
      starRating=4;
    }else if(paymentDetailsList.length>=50){
      print("astaarr33");
      starRating=3;
    }else if(paymentDetailsList.length>=25){
      print("astaarr44");
      starRating=2;
    }else if(paymentDetailsList.length>=10){
      print("astaarr55");
      starRating=1;
    }else{
      print("astaarr66");
      starRating=0;
    }
    // starRating=5;
    ///comment  starRating=3; after testing
    // notifyListeners();
  }
  
  
  void fetchTopStateWiseReport(){
    topStateModelList.clear();
    if(unitStream!=null){
      unitStream!.cancel();
    }
    unitStream = db.collection('STATE_TOTAL').orderBy('Amount',descending: true).limit(10).snapshots().listen((event) {
      print("kjjjj");
      topStateModelList.clear();
        if(event.docs.isNotEmpty){
          print("kkkkkkkkkk1111");
        for (var element in event.docs) {
          print("kkkkkkkkkk");

          topStateModelList.add(TopStateModel(
              element.get('state').toString(),
              double.parse(element.get('Amount').toString()) ,
              double.parse(element.get('TRANSACTION_COUNT').toString())));

          notifyListeners();
        }
      }
      notifyListeners();
    });
  }
  void fetchDistrictWiseReport(){
    districtWiseReportList.clear();
    if(unitStream!=null){
      unitStream!.cancel();
    }
    unitStream = db.collection('DISTRICT_TOTAL').orderBy('Amount',descending: true).limit(20).snapshots().listen((event) {
      print("kjjjj");
        districtWiseReportList.clear();
        if(event.docs.isNotEmpty){
          print("kkkkkkkkkk1111");
        for (var element in event.docs) {
          print("kkkkkkkkkk");

          districtWiseReportList.add(DistrictReportModel(
              element.get('state').toString(),
              element.get('district').toString(),
              double.parse(element.get('Amount').toString()) ,
              double.parse(element.get('TRANSACTION_COUNT').toString())));
          print(districtWiseReportList.length.toString()+"jhghj");
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void fetchDistrictWiseAssemblyReport(String district, BuildContext context3) {
    assemblyWiseReportList.clear();
    if (unitStream != null) {
      unitStream!.cancel();
    }
    unitStream = db
        .collection('ASSEMBLY_TOTAL')
        .where("DISTRICT", isEqualTo: district)
        .orderBy('AMOUNT', descending: true)
        .snapshots()
        .listen((event) {
      assemblyWiseReportList.clear();
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          try{
            assemblyWiseReportList.add(AssemblyReportModel(
                element.get('ASSEMBLY').toString(),
                element.get('DISTRICT').toString(),
                double.parse(element.get('AMOUNT').toString()),
                double.parse(element.get('TRANSACTION_COUNT').toString())));
            notifyListeners();
          }catch(e){
          }
        }
      }
      notifyListeners();
    });
    callNext(
        AssemblyReport(
          from: '',
        ),
        context3);
  }


 void fetchTopAssemblyReport()  {
    print(' OEMFOF');
    topAssemblyList.clear();
    if (unitStream != null) {
      unitStream!.cancel();
    }
    unitStream = db
        .collection('AssemblyTotalAmount')
        .orderBy('Amount', descending: true)
        .limit(50)
        .snapshots()
        .listen((event) {
      topAssemblyList.clear();
      if (event.docs.isNotEmpty) {
        assemblyTopListforTv.clear();
        print(' IJEEIF');
        for (var element in event.docs) {
            try{
              topAssemblyList.add(TopAssemblyModel(
                  element.get('assembly').toString(),
                  element.get('district').toString(),
                  double.parse(element.get('Amount').toString()),
                  double.parse(element.get('TRANSACTION_COUNT').toString())));
              print(topAssemblyList.length.toString()+' IJCOISCO ');
              notifyListeners();
            }catch(e){
            }

        }
        for(var ee in topAssemblyList){
          assemblyTopListforTv.add(OrganizationCollectedModel(ee.assembly, ee.assemblyAmount.toString()));
        }
      }
      notifyListeners();
    });
  }

  Future<void> fetchTopPanchayathReport() async {
    topPanchayathList.clear();
    if (unitStream != null) {
      unitStream!.cancel();
    }
    unitStream =await db
        .collection('PANCHAYATH_TOTAL').where("DISTRICT",isEqualTo: "KASARGOD")
        .orderBy('AMOUNT', descending: true)
        // .limit(100)
        .snapshots()
        .listen((event) {
      topPanchayathList.clear();
      if (event.docs.isNotEmpty) {
        municipalityTopListforTv.clear();
        panchayathTopListforTv.clear();
        for (var element in event.docs) {
          try{
            topPanchayathList.add(TopPanchayathModel(
                element.get('PANCHAYATH').toString(),
                element.get('DISTRICT').toString(),
                double.parse(element.get('AMOUNT').toString()),
                double.parse(element.get('TRANSACTION_COUNT').toString())));


            topMuncipalityList=  topPanchayathList.where((element) =>element.panchayath.contains("MUNICIPALITY")).toList();
             if(topMuncipalityList.length>15){
              topMuncipalityList=topMuncipalityList.getRange(0, 15).toList();
            }else if(topMuncipalityList.length>10 && topMuncipalityList.length<15){
              topMuncipalityList=topMuncipalityList.getRange(0, 10).toList();
            }else if(topMuncipalityList.length>5 && topMuncipalityList.length<10){
               topMuncipalityList=topMuncipalityList.getRange(0, 5).toList();
             }

            topPanchayathListNew=  topPanchayathList.where((element) =>!element.panchayath.contains("MUNICIPALITY")).toList();
            topPanchayathListNew=topPanchayathListNew.getRange(0, 20).toList();

            notifyListeners();
          }catch(e){
          }
        }
        for(var ee in topPanchayathListNew){
          panchayathTopListforTv.add(OrganizationCollectedModel(ee.panchayath, ee.panchayathAmount.toString()));
        }for(var ee in topMuncipalityList){
          municipalityTopListforTv.add(OrganizationCollectedModel(ee.panchayath, ee.panchayathAmount.toString()));
        }
        print(panchayathTopListforTv.length.toString()+' DIENFIRF');
        print(municipalityTopListforTv.length.toString()+' WDEDW');
      }
      notifyListeners();
    });

  }

  Future<void> fetchTopWardReport() async {
    topWardList.clear();
    if (unitStream != null) {
      unitStream!.cancel();
    }
    unitStream =await db
        .collection('WardTotalAmount')
        .orderBy('Amount', descending: true)
        .limit(100)
        .snapshots()
        .listen((event) {
      topWardList.clear();
      if (event.docs.isNotEmpty) {
        print(' DENDIENDIED');
        unitTopListforTv.clear();
        for (var element in event.docs) {
          try{
            topWardList.add(TopWardModel(
                element.get('wardname').toString(),
                element.get('panchayath').toString(),
                element.get('district').toString(),
                double.parse(element.get('Amount').toString()),
                double.parse(element.get('TRANSACTION_COUNT').toString())));
            topWardList= topWardList.where((element) =>!element.ward.toString()
                .contains("FAMILY CONTRIBUTION")).where((element) =>!element.ward.toString().contains("OTHER")).toList();
            print(' DEDEDEDEDE'+topWardList.length.toString());
            notifyListeners();
          }catch(e){
          }

        }
        for(var ee in topWardList){
          unitTopListforTv.add(OrganizationCollectedModel(ee.ward, ee.panchayathAmount.toString()));
        }
      }
      notifyListeners();
    });
  }

  getcolors(int index){
    Color border=Color(0xFF78FFD6);
    Color border1=Color(0xFFAAEED9);

    if(index==0){
      border=Color(0xFFFF7100);
      border1=Color(0xFFD0996D);
    }else if(index==1){
      border=Color(0xFF9254FF);
      border1=Color(0xFFAC8AE7);
    }else if(index==2){
      border=Color(0xFFFF54F6);
      border1=Color(0xFFB684B3);
    }else if(index==2){
      border=Color(0xFF5FFF54);
      border1=Color(0xFF6AB265);
    }else if(index==4){
      border=Color(0xFFEFE636);
      border1=Color(0xFFB2AE57);
    }else if(index==5){
      border=Color(0xFF54BDFF);
      border1=Color(0xFF77BCE8);
    }else if(index==6){
      border=Color(0xFFFF54F6);
      border1=Color(0xFFD77AD2);
    }else if(index==7){
      border=Color(0xFFADF632);
      border1=Color(0xFFCAEE8F);
    }else if(index==8){
      border=Color(0xFF3A69FF);
      border1=Color(0xFF7993E5);
    }else if(index==9){
      border=Color(0xFF5EFF8A);
      border1=Color(0xFF8ED2A1);
    }else if(index==10){
      border=Color(0xFF5845FF);
      border1=Color(0xFF918CC7);

    }else if(index==11){
      border=Color(0xFF585CE5);
      border1=Color(0xFF9192CE);

    }else if(index==12){
      border=Color(0xFFFF3491);
      border1=Color(0xFFB97C98);
    }else if(index==13){
      border=Color(0xFFD777FF);
      border1=Color(0xFFC5A7D2);
    }else if(index==14){
      border=Color(0xFF108079);
      border1=Color(0xFF74ECE4);
    }
    List<Color> a=[border,border1];
    return a;
  }


  void getTopEnrollers(){

    print("topenrollerworkk");
    if(unitStream!=null){
      unitStream!.cancel();
    }
    unitStream= db.collection('Enrollers').orderBy('TotalAmount', descending: true).limit(10).snapshots().listen((event) {
      topEnrollersModel.clear();

      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {

          topEnrollersModel.add(TopEnrollersModel(element.get("Name"), element.get('Phone'),element.get("Place")??"", double.parse(element.get('TotalAmount').toString())));
          notifyListeners();
          print("topEnrollersModelssdgff"+topEnrollersModel.length.toString());
        }
      }
      notifyListeners();

    });



  }

   getEnrollerPayments(String id){
     EnrollerPaymenttotal=0.0;
     EnrollerPaymentName="";
    print("sdgfvafvr"+id.toString());
    enrollerPaymentsList.clear();

    db.collection('Payments').where('EnrollerId',isEqualTo: id).get().then((value) {
      if(value.docs.isNotEmpty){
        enrollerPaymentsList.clear();
        enrollerNoPaymet=false;
        print("IFFFFFFF");
        for (var element in value.docs) {
            enrollerPaymentsList.add(EnrollerPaymentsModel(
              element.id, element.get('Amount').toString(),
              element.get('Name').toString(),
              element.get('EnrollerName').toString(),
              element.get('EnrollerId').toString(),
              element.get('state').toString(),
              element.get('district').toString(),
              element.get('assembly').toString(),
              element.get('Time').toString(),

            ));
            EnrollerPaymentName=element.get('EnrollerName').toString();

            EnrollerPaymenttotal+=element.get('Amount');

            print("enrollerPaymentsListadf"+enrollerPaymentsList.length.toString());

            try{
              enrollerPaymentsList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));
            }catch(e){}

          notifyListeners();
        }
        enrollerNoOfPayments=(enrollerPaymentsList.length).toString();

        print("enrollerPaymentsListadf11111"+enrollerNoOfPayments.toString());
      }else{
        enrollerNoPaymet=true;
        print("SSSSSSSAaaaa"+id);
        db.collection('Enrollers').where("Phone",isEqualTo: id).get().then((value) {
          if(value.docs.isNotEmpty){
            print("SSSSSSSA");
            for(var el in value.docs){
              Map<dynamic,dynamic>map=el.data() as Map;
              EnrollerPaymentName=map["Name"].toString();
              notifyListeners();
            }
          }
        });
      }
      notifyListeners();
    });

  }


  void aa(){
    print("sdfsdfsdfsdf");
    enrollerNoOfPayments="0";
    EnrollerPaymenttotal=0.0;
    print("sdfsdfsdfsdfaaaaa"+enrollerNoOfPayments.toString());
    enrollerPaymentsList.clear();
    notifyListeners();
  }

  Future<void> topLeadPayments() async {
    print("topenrollerworkk1111");
    if(unitStream!=null){
      unitStream!.cancel();
    }
    unitStream=await db
        .collection('Payments')
        .orderBy('Amount', descending: true)
        .limit(20)
        .snapshots()
        .listen((event) {
      topLeadlist.clear();

      if (event.docs.isNotEmpty) {
        leadersTopListforTv.clear();
        for (var element in event.docs) {
          leadersTopListforTv.add(OrganizationCollectedModel( element.get("Name"),element.get("Amount").toString()));

          topLeadlist.add(TopLeadModel(
            element.get("Name"),
            element.get("state"),
            element.get("district"),
            element.get("assembly"),
            element.get("NameShowStatus"),
            double.parse(element.get("Amount").toString()),));
          notifyListeners();
          print("topEnrollersModelssdgff122222"+topLeadlist.length.toString());
        }
        print(leadersTopListforTv.length.toString()+' ODMOLKD');

      }
      notifyListeners();

    });

  }
  addDistrictOtherAmount(){
    print("successsss222");
    double totalDistrict=0.0;



    db.collection("DISTRICTS_TOTAL").get().then((value) {
      if(value.docs.isNotEmpty){

        for (var element in value.docs) {
          totalDistrict=totalDistrict+ element.data()['AMOUNT'];

        }
        print(totalDistrict.toString()+"assssssssss");
        totalOther=totalCollection-totalDistrict;
        notifyListeners();
        print("aaaaaaaaaaaaaqqq"+totalOther.toString());


      }


    });








  }
  late ConfettiController controllerCenter = ConfettiController(duration: Duration(seconds: 10000));


  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 6;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  void sss(){
    controllerCenter.play();
    notifyListeners();
  }
  
  Future<void> fetchDistrictsforAdmin() async {
    db.collection('DISTRICTS_TOTAL').get().then((value){
      if(value.docs.isNotEmpty){
        for(var element in value.docs) {
          adminViewDistrictList.add(element.id.toString());
          notifyListeners();
        }
      }
    });
  }



  lockIntentPaymentOption(){
    mRoot.child('0').child('IntentPaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        intentPaymentOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }
  lockEazypayPaymentOption(){
    mRoot.child('0').child('easyPayAndroidPaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        easyPayAndroidPaymentOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }
  lockrazorpayandroidPaymentOption(){
    mRoot.child('0').child('razorpayAndroidPaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        razorpayAndroidPaymentOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }
  lockccavenueAndroidPaymentOption(){
    mRoot.child('0').child('ccavenueAndroidPaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        ccavenueAndroidPaymentOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }

  lockrazorpayIosPaymentOption(){
    mRoot.child('0').child('razorpayIosPaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        razorpayIosPaymentOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }
  lockccavenueIosPaymentOption(){
    mRoot.child('0').child('ccavenueIosPaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        ccavenueIosPaymentOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }
  lockrEazypatIosPaymentOption(){
    mRoot.child('0').child('easyPayIosPaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        easyPayIosPaymentOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }
  lockEazypayQrPaymentOption(){
    mRoot.child('0').child('easyPayAndroidQrPaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        easyPayAndroidQrPaymentOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }
  void adminViewDistrictTotal(String district){
     totalAmount=0.0;
    db.collection('Payments').where('district',isEqualTo: district).get().then((event) {
    if(event.docs.isNotEmpty){
      for(var element in event.docs) {
        totalAmount=totalAmount+ double.parse(element.get('Amount').toString());
        notifyListeners();
      }
    }
    });
  }

  void clearAdminDistricttotal(){
    totalAmount=0.0;
    notifyListeners();
  }

  void clearEnrollerDetails(){

    enrollerNoOfPayments="0";
    EnrollerPaymentSearchCt.text="";
   enrollerPaymentsList.clear();
    EnrollerPaymentName="";
   EnrollerPaymenttotal=0.0;
    enrollerNoPaymet=false;
   notifyListeners();
  }

bool refresheEchDistrict=false;
  void refreshDistrict(String district,BuildContext context){
    // if(_streamSubscription!=null){
    //   _streamSubscription!.cancel();
    // }
    refresheEchDistrict=true;

    print("QQQQQQQQ"+district);

    db.collection('WardTotalAmount').where('district',isEqualTo: district).get().then((event) {

      if (event.docs.isNotEmpty) {
        eachDistrictTotal=0.0;
        for (var element in event.docs) {
          eachDistrictTotal = eachDistrictTotal + double.parse(element.get('Amount').toString());


        }

        db.collection('DISTRICTS_TOTAL').doc(district).update({"AMOUNT": eachDistrictTotal});

        var snackBar = SnackBar(
          content: Text(district+" Refreshed"),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        refresheEchDistrict=false;

      }

    });

  }


  /// videos
  late  YoutubePlayerController videoController;
  int videoIndex = 0;
  String videoId = '';
  String description = '';
  String firstVideo = '';
  String planVideo = "";
  String level4 = "";
  String level5 = "";
  bool videoUrl = false;
  List<bool> plyCheck = [false, false, false];
 List<VideoModel> videoList= [];

  getVideo(BuildContext context) {
    db.collection("VIDEO").doc("Payment").get().then((event) {
      if(event.exists){
           Map<dynamic, dynamic> map = event.data() as Map;
                videoId = map["LINK"].toString();
                description = map["DESCRIPTION"].toString();
                callNext(HowToPayScreen(videoId: videoId, description: description,), context);
                notifyListeners();
           videoList.add(VideoModel(map["LINK"].toString(), map["DESCRIPTION"].toString(),));
      }
      notifyListeners();

    });

  }

  videoPlay() {
    videoController = YoutubePlayerController(
      initialVideoId: videoList.first.videoLink,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        hideControls: false,
        endAt: 0,

        mute: true,
      ),
    );
    notifyListeners();
  }
  changePlayPause(index) {
    for (int i = 0; i < plyCheck.length; i++) {
      if (plyCheck[i] == true) {
        plyCheck[i] = false;
      } else if (i != index) {
        plyCheck[i] = false;
      } else {
        plyCheck[i] = true;

      }
    }

    notifyListeners();
  }

  getVideoIndex() {
    plyCheck = [false, false, false];

    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();







  void addData(){



    HashMap<String, Object> map = HashMap();

    map["name"]=nameController.text;
    map["phone"]=phoneController.text;


    DateTime now=DateTime.now();

    String id=now.millisecondsSinceEpoch.toString();




    // db.collection("Students").add(map);

    db.collection("Students").doc(id).set(map);




  }

  final ImagePicker picker = ImagePicker();
  File? fileimage;
  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileimage = File(response.file!.path);

      notifyListeners();
    }
  }

  String newPicekd='';
  imageFromCamera() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      // fileimage = File(pickedFile.path);
      cropImage(pickedFile.path, '');
      // newPicekd=pickedFile.path;
      print(newPicekd+"23232323=========");
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }

  imageFromGallery() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      cropImage(pickedFile.path, '');

      newPicekd=pickedFile.path ;
      print(newPicekd+"23232323=========");
      notifyListeners();
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.camera_enhance_sharp,
                    color: clC46F4E,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () => {imageFromCamera(), Navigator.pop(context)}),
              ListTile(
                  leading: const Icon(Icons.photo, color: clC46F4E),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () => {imageFromGallery(), Navigator.pop(context)}),
            ],
          );
        });
  }


  Future<void> cropImage(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      fileimage = File(croppedFile.path);
      notifyListeners();
    }
    print("gggggggggggg666" + fileimage.toString());
  }


  // List<String> toppReportsList=['Top Unit','Top Panchayath','Top Municipality','Leader Board'];

  List<OrganizationCollectedModel> assemblyTopListforTv=[];
  List<OrganizationCollectedModel>  panchayathTopListforTv=[];
  List<OrganizationCollectedModel>  municipalityTopListforTv=[];
  List<OrganizationCollectedModel>  unitTopListforTv=[];
  List<OrganizationCollectedModel>  leadersTopListforTv=[];

  List<OrganizationCollectedModel> finaleToopers(String from){
    List<OrganizationCollectedModel> list=[];
    print(from+' ASSEMBLYYY'+assemblyTopListforTv.length.toString());
    print(from+' MUNICIPALITY'+municipalityTopListforTv.length.toString());
    print(from+' PANCHAYATHHHHH'+panchayathTopListforTv.length.toString());
    print(from+' UNITTT'+unitTopListforTv.length.toString());
    if(from=='Top Unit'){
      list=unitTopListforTv;
    }else if(from=='Top Panchayath'){
      list=panchayathTopListforTv;
    }else if(from=='Top Municipality'){
      list=municipalityTopListforTv;
    }else if(from=='Leader Board'){
      print(' IRNFIRFRF');
      list=leadersTopListforTv;
    }else if(from=='Top Assembly'){
      list=assemblyTopListforTv;
    }
    return list;
  }

  String  iosPaymentButton='OFF';
  lockIosPaymentButton(){
    mRoot.child('0').child('iosPaymentButton10').onValue.listen((event) {
      if(event.snapshot.exists){
        iosPaymentButton=event.snapshot.value.toString();
        notifyListeners();
        print(iosPaymentButton.toString()+"Payment Button");
        print(iosPaymentButton.toString()+"Payment Button");
      }
    });
  }
  List<dynamic>carouselImages=[];
  void fetchCarouselImages(){
    carouselImages.clear();
    db.collection("CAROUSEL_IMAGES").get().then((value){
      if(value.docs.isNotEmpty){
        carouselImages.clear();
        for(var element in value.docs){
          Map<dynamic,dynamic>map=element.data();
          carouselImages.add(map["IMAGE"]);
        }
        notifyListeners();
        // print("hhhhhhhhhhhh "+carouselImages.length.toString());

      }
      notifyListeners();
    });

  }
  void fetchCarouselImagesBoche(){
    carouselImages.clear();
    db.collection("CAROUSEL_IMAGES_BOCHE").get().then((value){
      if(value.docs.isNotEmpty){
        carouselImages.clear();
        for(var element in value.docs){
          Map<dynamic,dynamic>map=element.data();
          carouselImages.add(map["IMAGE"]);
        }
        notifyListeners();
        // print("hhhhhhhhhhhh "+carouselImages.length.toString());

      }
      notifyListeners();
    });

  }
  late DateTime targetTime =DateTime.now();
  late DateTime scheduledTimeFrom;
  Duration remainingTime = const Duration();
  Timer? timer;
  late PageController _pageController;
  int currentPage = 0;
  int totalPages =
  5; // Change this to the total number of pages in your PageView
  // final _duration = const Duration(seconds: 10);
  void startTimer() {


    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime currentTime = DateTime.now();
      if (currentTime.isAfter(targetTime)) {


        // timer.cancel();
        // Add your code here to handle timer completion
        // For example, you could display a message or execute some function.
      } else {



        remainingTime = targetTime.difference(currentTime);

        notifyListeners();

      }
    });
  }

  void fetchtimerr(){


      db.collection("TIME").get().then((value){
        if(value.docs.isNotEmpty) {
          for (var element in value.docs) {

            Timestamp timestamp =element.get('date') ;
            scheduledTimeFrom = DateTime.parse(timestamp.toDate().toString());


              targetTime = scheduledTimeFrom;

              startTimer();

          }
        }

      });


  }

  // void startAutoScroll() {
  //   timer = Timer.periodic(_duration, (_) {
  //     if (currentPage < totalPages - 1) {
  //       currentPage++;
  //     } else {
  //       currentPage = 0;
  //     }
  //     // _pageController.animateToPage(
  //     //   _currentPage,
  //     //   duration: const Duration(milliseconds: 500),
  //     //   curve: Curves.easeInOut,
  //     // );
  //   });
  // }
}
