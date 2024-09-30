import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../constants/my_functions.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../Admin/admin_login_screen.dart';
import '../constants/my_colors.dart';
import '../providers/main_provider.dart';
import 'FinaleDayScreen.dart';
import 'TvMonitorScreen.dart';
import 'home.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  String paymentID;
  SplashScreen({Key? key,required this.paymentID}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DatabaseReference mRootReference =
  FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("splash referall1111111"+widget.paymentID.toString());
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
    MainProvider mainProvier = Provider.of<MainProvider>(context, listen: false);
    // homeProvider.lockAppTv();
    print("AAAASSSS");


    // homeProvider.lockApp();
    // homeProvider.lockAppTv();
    // if(!kIsWeb){
    // mRootReference.child("0").keepSynced(true);


    Future.delayed(const Duration(seconds:3), () async {
      print("widget.paymentID"+widget.paymentID);

      homeProvider.fetchHistoryFromFireStore();
      /// lock for Iuml hq

      ///lock only for monitor and admin appp
      homeProvider.lockAppMonitor();


      homeProvider.lockApp();
      homeProvider.fetchDetails();
      homeProvider.lockPinWardReceipt();
      homeProvider.lockPinWardHistory();
      homeProvider.changeReport();
      mainProvier.fetchImages();
      homeProvider.fetchCarouselImages();

      homeProvider.fetchtimerr();
      // homeProvider.startTimer();
      // homeProvider.startAutoScroll();
      // homeProvider.fetchCarouselImagesBoche();
      // donationProvider.fetchPanjayath();
      donationProvider.fetchAssembly();
      donationProvider.fetchDistrict();
      // donationProvider.getTodayTopper();
      homeProvider.getAllAssebmly();
      donationProvider.getTopper();



      // donationProvider.getHideWards();3
      // donationProvider.fetchAssembly();
      // donationProvider.otherPaymentButton();

      // donationProvider.getDirectReceipt(widget.paymentID,context);
      // donationProvider.getDirectReceipt(widget.paymentID,context);
      if(kIsWeb&&widget.paymentID!="General"){
        print("asasas");
        donationProvider.getDirectReceipt(widget.paymentID,context);
      }else{

        // homeProvider.fetchTopPanchayathReport();
        // homeProvider.fetchTopWardReport();
        // homeProvider.topLeadPayments();
        // homeProvider.fetchTopAssemblyReport();
        // homeProvider.currentLimit = 50;
        // homeProvider.fetchReceiptListForMonitorApp(50);
        // callNextReplacement(TvMonitorScreem(), context);



        callNextReplacement(HomeScreenNew(), context);


        // homeProvider.fetchTopPanchayathReport();
        // homeProvider.fetchTopWardReport();
        // homeProvider.topLeadPayments();
        // homeProvider.fetchTopAssemblyReport();
        // homeProvider.currentLimit = 50;
        // homeProvider.fetchReceiptListForMonitorApp(50);
        // callNextReplacement(TvMonitorScreem(), context);

        // homeProvider.fetchReceiptList(5);
        // callNextReplacement(FinaleDayScreen(), context);

        // if(FirebaseAuth.instance.currentUser!=null){
        //
        //
        // }else{
        //   try {
        //
        //     final userCredential =
        //     FirebaseAuth.instance.signInAnonymously().then((value) {
        //       print("Signed in with temporary account.");
        //       print(value.user?.uid.toString());
        //
        //
        //     });
        //
        //   } on FirebaseAuthException catch (e) {
        //
        //
        //
        //     switch (e.code) {
        //       case "operation-not-allowed":
        //         print("Anonymous auth hasn't been enabled for this project.");
        //         break;
        //       default:
        //         print("Unknown error.");
        //     }
        //   } on Exception catch(e){
        //     print("SSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        //   }
        // }


      }
      ///new code b



      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
    // homeProvider.inagurationTrigger(context);
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget mobile(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;

    return Scaffold(
        body:
        MediaQuery.of(context).orientation==Orientation.landscape
            ?
        SingleChildScrollView(
            child: Container(
              height: height,
              decoration: const BoxDecoration(
                  image:DecorationImage(
                      image:AssetImage("assets/splashFirstLayer.png"),
                      fit: BoxFit.cover
                  )
              ),
              child:Stack(
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Expanded(
                          flex:2,
                          child: SizedBox()
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     const SizedBox(
                      //       width: 75,
                      //     ),
                      //     Image.asset(
                      //       "assets/Quaid-e Millath.png",
                      //       scale: 3.3,
                      //     ),
                      //
                      //   ],
                      // ),


                      // const SizedBox(height: 40,),
                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 10),
                      //   height: height*0.2,
                      //   // height: 274,
                      //   width: width,
                      //   decoration: const BoxDecoration(
                      //     // color: Colors.yellow,
                      //     image: DecorationImage(image: AssetImage("assets/splash_text.png"),scale: 3,fit: BoxFit.fill),
                      //   ),
                      //
                      // ),

                      Expanded(
                        flex:3,
                        child: Container(
                          width: width*.70,
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset(
                            "assets/splashCenterImage.png",
                          ),
                        ),
                      ),

                      Expanded(
                        flex:3,
                        child: Container(
                          // color: Colors.blue,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              "assets/splashbgBottom.png",
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      height: 50,
                      width: width*.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: myWhite.withOpacity(0.80),
                      ),

                      child: Image.asset(
                        "assets/logo.png",
                        scale: 2.3,
                      ),
                    ),
                  )
                ],
              ),
            )
        )
            :
        SafeArea(
          child: SizedBox(
            height: height,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                 Expanded(
                  flex:2,
                  child: Column(
                    children: [
                      SizedBox(height: height*.05,),
                      const Text('"Join hands to wipe away this mother${"'"}s tears"',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "InconsolataCondensedBold",
                            fontWeight: FontWeight.w400,
                            color: cl434343
                        ),),
                    ],
                  ),
                ),

                 Expanded(
                  flex:2,
                  child: Center(
                    child:SizedBox(
                      width: width*.60,
                      child: Image.asset(
                        "assets/splashCen4xMin.png",
                        // "assets/bocheSplash.png",
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex:2,
                  child:
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:15.0),
                      child: Image.asset(
                        "assets/logo.png",
                        scale: 3,
                      ),
                    ),
                  )
                ),

              ],
            ),
          ),
        ));
  }

  Widget web(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;

    return SingleChildScrollView(
        child: Container(
          height: height,
          decoration: const BoxDecoration(
              image:DecorationImage(
                  image:AssetImage("assets/splashFirstLayer.png"),
                  fit: BoxFit.cover
              )
          ),
          child:Stack(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const Expanded(
                      flex:2,
                      child: SizedBox()
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     const SizedBox(
                  //       width: 75,
                  //     ),
                  //     Image.asset(
                  //       "assets/Quaid-e Millath.png",
                  //       scale: 3.3,
                  //     ),
                  //
                  //   ],
                  // ),


                  // const SizedBox(height: 40,),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 10),
                  //   height: height*0.2,
                  //   // height: 274,
                  //   width: width,
                  //   decoration: const BoxDecoration(
                  //     // color: Colors.yellow,
                  //     image: DecorationImage(image: AssetImage("assets/splash_text.png"),scale: 3,fit: BoxFit.fill),
                  //   ),
                  //
                  // ),

                  Expanded(
                    flex:3,
                    child: Container(
                      width: width*.70,
                      padding: const EdgeInsets.only(left: 20),
                      child: Image.asset(
                        "assets/splashCenterImage.png",
                      ),
                    ),
                  ),

                  Expanded(
                    flex:3,
                    child: Container(
                      // color: Colors.blue,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          "assets/splashbgBottom.png",
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),


                ],
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  height: 50,
                  width: width*.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: myWhite.withOpacity(0.80),
                  ),

                  child: Image.asset(
                    "assets/logo.png",
                    scale: 2.3,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}