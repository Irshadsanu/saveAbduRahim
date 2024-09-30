import 'dart:async';
import 'dart:io';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloodmoney/Screens/payment_history.dart';
import 'package:bloodmoney/Screens/receiptlist_monitor_screen.dart';
import 'package:bloodmoney/Screens/reciept_list_page.dart';
import 'package:bloodmoney/Screens/top_enrollers_screen.dart';
import 'package:bloodmoney/Screens/ward_history.dart';
import 'package:bloodmoney/providers/main_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/alerts.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/strings.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import '../providers/home_provider_reciept.dart';
import '../providers/web_provider.dart';
import 'Toppers_home_screen.dart';
import 'be_an_enroller.dart';
import 'district_report.dart';
import 'donate_page.dart';
import 'enrollerPayments_screen.dart';
import 'leadReport.dart';
import 'no_paymet_gatway.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
 
  late ConfettiController controllerCenter = ConfettiController(duration: const Duration(seconds: 5000));


  // late DateTime _targetTime;
  // late DateTime scheduledTimeFrom;
  // Duration _remainingTime = const Duration();
  // Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // startTimer();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoScroll();
  }

  @override
  void dispose() {
    // _timer?.cancel();
    super.dispose();
  }
  FirebaseFirestore db = FirebaseFirestore.instance;


  // void fetchCarouselImagesBoche(){
  //
  //   setState(() {
  //     db.collection("TIME").snapshots().listen((value){
  //       if(value.docs.isNotEmpty) {
  //         for (var element in value.docs) {
  //           Map<dynamic, dynamic>map = element.data();
  //           Timestamp timestamp = map['date'];
  //           scheduledTimeFrom = DateTime.parse(timestamp.toDate().toString());
  //           print(scheduledTimeFrom.toString()+' FINRJIRF');
  //           setState(() {
  //             _targetTime = scheduledTimeFrom;
  //             _startAutoScroll();
  //             startTimer();
  //             _startAutoScroll();
  //           });
  //         }
  //       }
  //
  //     });
  //
  //   });
  // }


  void _startAutoScroll() {
    // _timer = Timer.periodic(_duration, (_) {
    //   if (_currentPage < _totalPages - 1) {
    //     _currentPage++;
    //   } else {
    //     _currentPage = 0;
    //   }
    //   // _pageController.animateToPage(
    //   //   _currentPage,
    //   //   duration: const Duration(milliseconds: 500),
    //   //   curve: Curves.easeInOut,
    //   // );
    // });
  }

  void startTimer() {
    // const oneSec = const Duration(milliseconds: 1);
    // _timer = Timer.periodic(
    //   oneSec,
    //       (Timer timer) {
    //     DateTime currentTime = DateTime.now();
    //     if (currentTime.isAfter(_targetTime)) {
    //       timer.cancel();
    //       // Add your code here to handle timer completion
    //       // For example, you could display a message or execute some function.
    //     } else {
    //       setState(() {
    //         _remainingTime = _targetTime.difference(currentTime);
    //       });
    //     }
    //   },
    // );
  }
  late PageController _pageController;
  int _currentPage = 0;
  int _totalPages =
  5; // Change this to the total number of pages in your PageView
  final _duration = const Duration(seconds: 10);
  final List<int> amount = [
    100,
    500,
    1000,
    2000,
    5000,
    10000,
  ];

  final List<Color> colors = [
    clB3EFD2,
    clEFB3B3,
    clCAE8F1,
    clB3EFEF
  ];

  void sss(){
    controllerCenter.play();
    setState(() {

    });
  }
  final List<String> amountInWords = [
    "Five Hundred",
    "Thousand",
    "Five Thousand",
    "Ten Thousand",
    "Twenty Five Thousand",
    "Fifty Thousand",
  ];

  List<String> images = [
    "assets/car1.jpg",
    "assets/car2.jpg",



  ];

  List<String> contriImg = [
    "assets/Transactions.png",
    "assets/MyHistory.png",
    "assets/Reports.png",
    "assets/LeaderBoard.png",
    "assets/ToppersClub.png",
    "assets/TopVolunteers.png",
    "assets/VolunteerRegistration.png",
    "assets/VolunteerPayments.png",
  ];

  List<String> contriText = [
    "Transactions",
    "My History",
    "Reports",
    "Leader board",
    "Top\Reports",
    "Top\nVolunteers",
    "Volunteer\nRegistration",
    "Volunteer\nPayments",
  ];




  List<String> PTCText = [
    "Privacy Policy",
    "Terms and condition",
    "Contact Us",
    "About Us",
  ];

  List<IconData> PTCIcon = [
    Icons.privacy_tip,
    Icons.beenhere_outlined,
    Icons.wifi_tethering,
    Icons.info_outline,
  ];

  List<String> reportText = [
    "Transactions",
    "My History",
    "Receipt",
    "Report"
  ];

  List<String> reportImg=[
    "assets/transactions.png",
    "assets/History.png",
    "assets/Reciept.png",
    "assets/report.png",
  ];

  List<String> prizes=[
    "assets/firsPrice.png",
    "assets/firsPrice.png",
    "assets/firsPrice.png",
  ];


  int activeIndex = 0;

  List<Widget> statsScreens = [
    WardHistory(),
    ReceiptListPage(
      from: 'home',
      total: '', state: '', district: '', assembly: '', target: '',
    ),
    DistrictReport(from: '',),
    PaymentHistory()
  ];
  bool isFinished = false;
  //bloodMoneyApp
  List<String> topCarouselImages=[
    "https://live.staticflickr.com/65535/50729624248_04e03bbf2d_b.jpg",
    "https://images.fineartamerica.com/images-medium-large-5/nature-is-pleased-with-simplicity-and-nature-is-no-dummy-isaac-newton-brandi-thompson.jpg",
    "https://media.wired.com/photos/5a84e80c263579570b6bfbef/master/pass/cliff-700678060.jpg"
  ];
  @override
  Widget build(BuildContext context) {

    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget mobile(context){

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    ///ba
    // homeProvider.sss();
    homeProvider.getAppVersion();
    if(Platform.isIOS){
      amount.clear();
    }

    return WillPopScope(
        onWillPop: () {
          return showExitPopup();
        },
        child: queryData.orientation == Orientation.portrait?
        SafeArea(
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            backgroundColor: Colors.white,

            body: SizedBox(
              height: height,
              child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                      children: [
                        //Two text,carousel,howtopayAndAppsupport
                        Container(
                          alignment:Alignment.center,
                          height: 435,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/HomeTpBg4x.jpg"),
                              fit: BoxFit.cover
                            ),
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50)),
                          ),
                          child: SizedBox(
                            height: 460,
                            width:width*.90,
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Text('"Join hands to wipe away this mother${"'"}s tears"',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "InconsolataCondensedBold",
                                          fontWeight: FontWeight.w400,
                                          color: cl434343
                                      ),),
                                      Text("“Cu D½bpsS I®oscm¸m³",style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "LeelaHeavy",
                                          color: cl434343
                                      ),
                                      ),
                                      Text(" ssI tImÀ¡pI”",style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "LeelaHeavy",
                                          color: cl434343
                                      ),
                                      ),
                                    ]
                                ),
                                //carousel
                                SizedBox(
                                  height: 200,
                                  // color:Colors.blue,
                                  child: Consumer<HomeProvider>(
                                      builder: (context,value,child) {
                                        return Column(
                                          children: [
                                            Container(
                                              height: 180,
                                              width: width,
                                              decoration: BoxDecoration(
                                                // color:myWhite,
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                                              child: CarouselSlider.builder(
                                                itemCount:value.carouselImages.isNotEmpty? value.carouselImages.length:images.length,
                                                itemBuilder: (context, index, realIndex) {
                                                  //final image=value.imgList[index];
                                                  final image =value.carouselImages.isNotEmpty? value.carouselImages[index]:images[index];
                                                  return buildImage(image, context,value.carouselImages.isEmpty?"asset":"online");
                                                },
                                                options: CarouselOptions(
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    // autoPlayCurve: Curves.linear,
                                                    height: 200,
                                                    viewportFraction: 1,
                                                    autoPlay: true,
                                                    //enableInfiniteScroll: false,
                                                    pageSnapping: true,
                                                    enlargeStrategy:
                                                    CenterPageEnlargeStrategy.height,
                                                    enlargeCenterPage: true,
                                                    autoPlayInterval: const Duration(seconds: 3),
                                                    onPageChanged: (index, reason) {
                                                      setState(() {
                                                        activeIndex = index;
                                                      });
                                                    }),
                                              ),
                                            ),
                                            buidIndiaCator(value.carouselImages.isNotEmpty?value.carouselImages.length:images.length, context)
                                          ],
                                        );
                                      }
                                  ),
                                ),

                                //How to pay and support
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Consumer<HomeProvider>(
                                        builder: (context,value1,child) {
                                          return
                                            // value1.iosPaymentButton =='ON'?
                                            1==1?
                                            InkWell(
                                              onTap: (){
                                                homeProvider.getVideo(context);
                                              },
                                              child: Container(
                                                width:140,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: clFFFFFF,
                                                    borderRadius: BorderRadius.circular(24)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      alignment: Alignment.center,
                                                      height:20,
                                                      width:30,
                                                      decoration:BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(color:clFF0000,width:1)
                                                      ),
                                                      child: const Icon(Icons.play_arrow,color: clFF0000,size:15,),
                                                    ),
                                                    const SizedBox(width:8),
                                                    const Text("How to Pay?",
                                                      style: TextStyle(fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: "PoppinsMedium",
                                                        color: cl434343,
                                                      ),),
                                                  ],
                                                ),
                                              ),
                                            ):const SizedBox();
                                        }
                                    ),

                                    const SizedBox(width:20),

                                    Container(
                                      height: 40,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          color: clFFFFFF,
                                          borderRadius: BorderRadius.circular(24)
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          alertSupport(context);
                                        },
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.phone_in_talk_outlined,size: 19,color: cl000000,),
                                            SizedBox(width:8),
                                            Text("App support",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "PoppinsMedium",
                                                color:cl434343,
                                              ),),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Center(
                                  child: Container(
                                    height: 65,
                                    width: 325,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        color: clFFFFFF,
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await Share.shareWithResult('https://abdulrahimlegalassistance.page.link/app');
                                      },
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5,top: 5,bottom: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Share Link",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins",
                                                    color:Colors.black,
                                                  ),),
                                                Text("Tell your friends, family and neighbours.\nShare it with whole World.",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color:cl434343,
                                                  ),),

                                              ],
                                            ),
                                          ),
                                          SizedBox(width:8),
                                          CircleAvatar(
                                            radius: 25,
                                              backgroundColor: clC46F4E,
                                              child: Icon(Icons.share,size: 25,color: Colors.white,)),


                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,)
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10,),
                        Consumer<DonationProvider>(
                          builder: (context,value,child) {
                            return value.timerLock=="ON"? Column(
                              children: [


                                Padding(
                                  padding: const EdgeInsets.only(left: 7.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Consumer<HomeProvider>(
                                            builder: (context,provider,_) {
                                              return Text(
                                                (provider.remainingTime.inDays).toString().padLeft(2, '0'),
                                                style: GoogleFonts.akshar(textStyle: monitoTvTextAmmountbluue),
                                              );
                                            }
                                          ),
                                          Text(
                                            "Days",
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.5),
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 11,left: 4,right: 4),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 1,
                                              backgroundColor: Colors.red,
                                            ),
                                            SizedBox(height: 5,),
                                            CircleAvatar(
                                              radius: 1,
                                              backgroundColor: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Consumer<HomeProvider>(
                                            builder: (context,provider,_) {
                                              return Text(
                                                (provider.remainingTime.inHours%24).toString().padLeft(2, '0'),
                                                style: GoogleFonts.akshar(
                                                    textStyle: monitoTvTextAmmountbluue),
                                              );
                                            }
                                          ),
                                          Text(
                                            "Hours",
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.5),
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 11,left: 4,right: 4),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 1,
                                              backgroundColor: Colors.red,
                                            ),
                                            SizedBox(height: 5,),
                                            CircleAvatar(
                                              radius: 1,
                                              backgroundColor: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Consumer<HomeProvider>(
                                            builder: (context,provider,_) {
                                              return Text(
                                                  (provider.remainingTime.inMinutes % 60)
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  style: GoogleFonts.akshar(
                                                      textStyle: monitoTvTextAmmountbluue));
                                            }
                                          ),
                                          Text(
                                            "Minutes",
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.5),
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 11,left: 4,right: 4),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 1,
                                              backgroundColor: Colors.red,
                                            ),
                                            SizedBox(height: 5,),
                                            CircleAvatar(
                                              radius: 1,
                                              backgroundColor: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Column(
                                        children: [
                                          Consumer<HomeProvider>(
                                            builder: (context,provider,_) {
                                              return Text(
                                                  (provider.remainingTime.inSeconds % 60).toString().padLeft(2, '0'),
                                                  style: GoogleFonts.akshar(
                                                      textStyle: monitoTvTextAmmountbluue));
                                            }
                                          ),
                                          Text(
                                            "Seconds",
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.5),
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ],

                                      ),


                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(


                                  width: 180,
                                  height: 25,
                                  // color: Colors.red,
                                  decoration:   BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                                    border: Border.all(color: clC46F4E,),
                                    color: Colors.red,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Last chance: Save a life now",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "InconsolataCondensedBold",
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white
                                        ),),

                                      SizedBox(height: 1,)
                                    ],

                                  ),
                                ),

                              ],
                            ):SizedBox();
                          }
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              //Amount And collectedSofar
                              Consumer<HomeProvider>(
                                  builder: (context,valuw1,child) {
                                    return InkWell(
                                      onTap: (){
                                        if(valuw1.iosPaymentButton=='ON') {
                                          mRoot
                                              .child('0')
                                              .child('PaymentGateway36')
                                              .onValue
                                              .listen((event) {
                                            if (event.snapshot.value.toString() == 'ON') {
                                              DonationProvider donationProvider = Provider
                                                  .of<DonationProvider>(
                                                  context, listen: false);
                                              donationProvider.amountTC.text = "";
                                              donationProvider.nameTC.text = "";
                                              donationProvider.phoneTC.text = "";
                                              donationProvider.subCommitteeCT.text = "";
                                              donationProvider.kpccAmountController.text =
                                              "";
                                              donationProvider.onAmountChange('');
                                              donationProvider.clearGenderAndAgedata();
                                              donationProvider.selectedPanjayathChip = null;
                                              donationProvider.chipsetWardList.clear();
                                              donationProvider.chipsetAssemblyList.clear();
                                              donationProvider.selectedAssembly = null;'1';
                                              donationProvider.minimumbool = true;

                                              callNext(DonatePage(), context);
                                            } else {
                                              callNext(const NoPaymentGateway(), context);
                                            }
                                          });
                                        } },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        height: 85,
                                        width: width,
                                        child:Consumer<HomeProvider>(
                                            builder: (context, value, child) {
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [


                                                  SizedBox(
                                                    height:60,
                                                    width: width,
                                                    child: FittedBox(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          const Text(
                                                            "₹ ",
                                                            style: TextStyle(
                                                                fontFamily: 'InterRegular',
                                                                color:cl434343,
                                                                fontWeight: FontWeight.w400
                                                            ),
                                                          ),

                                                          Text(
                                                            getAmount(value.totalCollection),
                                                            style: const TextStyle(
                                                                fontFamily: 'LilitaOneRegular',
                                                                color:cl434343,
                                                                fontWeight: FontWeight.w400
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  const Text("Collected so far",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 13,
                                                        color:clC1C1C1,
                                                        fontWeight: FontWeight.w700
                                                    ),),
                                                ],
                                              );
                                            }),

                                      ),
                                    );
                                  }
                              ),

                              const SizedBox(height: 20,),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 150,
                                    child: const Text("Today's Toppers",
                                      style:  TextStyle(
                                          fontFamily: "ChangaOneRegular",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: clC46F4E
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height:10),

                                  SizedBox(
                                    width: width,
                                    child: Consumer<DonationProvider>(
                                        builder: (context, value, child) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: value.toppersList.length,
                                            // itemCount: 3,
                                            itemBuilder: (context, index) {
                                              var item = value.toppersList[index];
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(width:5),
                                                    item.name == 'No payments yet'
                                                        ? const SizedBox(
                                                      width: 20,
                                                    )
                                                        : Container(
                                                      padding: const EdgeInsets.only(top: 4),
                                                      alignment: Alignment.topCenter,
                                                      // color:Colors.red,
                                                      width: 30,
                                                      child: Image.asset(
                                                        prizes[index],
                                                        width: 35,
                                                        height: 35,
                                                        scale: 2,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8,),
                                                    // item.name == 'No payments yet'
                                                    //     ? const SizedBox(width: 100.0)
                                                    //     : const SizedBox(),
                                                    // item.name == 'No payments yet'
                                                    //     ? const SizedBox()
                                                    //     : const SizedBox(width: 20.0),
                                                    // Add horizontal spacing
                                                    Flexible(
                                                      fit: FlexFit.tight,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          // item.name == 'No payments yet'
                                                          //     ? const SizedBox(
                                                          //   height: 10,
                                                          // )
                                                          //     : const SizedBox(),
                                                          // item.name == 'No payments yet'
                                                          //     ? const SizedBox()
                                                          //     : const SizedBox(
                                                          //   width: 100,
                                                          // ),
                                                           Text(
                                                            item.name,
                                                            style: const TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 15,
                                                              color: myBlack,
                                                            ),
                                                          ),
                                                          Text(
                                                            item.assembly,
                                                            style:  TextStyle(
                                                              color: cl434343.withOpacity(0.4),
                                                              fontSize: 10.63,
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // const Spacer(),
                                                    // Push the trailing text to the right
                                                    item.name == 'No payments yet'
                                                        ? const SizedBox()
                                                        :  Text("₹"+
                                                          getAmount(item.amount),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w800,
                                                          fontSize: 17.76,
                                                          color:myBlack
                                                      ),

                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                  ),


                                ],
                              ),

                              const SizedBox(height: 10,),

                              const Text("Quick pay",style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: cl434343
                              ),),

                              const SizedBox(height: 10,),

                              //6GridView
                              amount.isEmpty
                                  ? const SizedBox()
                                  : Container(
                                height: 125,
                                alignment: Alignment.center,
                                child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 3,
                                        mainAxisExtent: 55
                                    ),
                                    // padding: const EdgeInsets.all(12),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: amount.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          donationProvider.kpccAmountController.text = amount[index].toString();
                                          donationProvider.subCommitteeCT.text = "";
                                          donationProvider.nameTC.text = "";
                                          donationProvider.phoneTC.text = "";
                                          donationProvider.clearGenderAndAgedata();
                                          donationProvider.selectedPanjayathChip = null;
                                          donationProvider.chipsetAssemblyList.clear();
                                          donationProvider.selectedAssembly = null;
                                          donationProvider.minimumbool=false;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DonatePage()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                                          child: Container(
                                            alignment: Alignment.center,
                                              // height: 60,
                                              width: 144,
                                              decoration:   BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                                                  border: Border.all(color: clC46F4E,width: 0.3),
                                                  color: clFFFFFF
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                      "₹ ",
                                                      style: TextStyle(
                                                          color: cl4F4F4F,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500)
                                                  ),
                                                  Text(
                                                      '${amount[index]}',
                                                      style: const TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: cl4F4F4F,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w700)
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    }),
                              ),

                              const SizedBox(height: 15,),

                              //8GridView
                              GridView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 0,
                                      crossAxisCount: 4,
                                      mainAxisExtent: 95),
                                  itemCount: contriImg.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Consumer<HomeProvider>(
                                        builder: (context, value2, child) {
                                          return InkWell(
                                            onTap: () async {
                                              if (index == 0) {
                                                //Transactions
                                                if (!kIsWeb) {
                                                  PackageInfo packageInfo =
                                                  await PackageInfo.fromPlatform();
                                                  String packageName = packageInfo.packageName;
                                                  if (packageName != 'com.spine.bloodmoneymonitor' &&
                                                      packageName != 'com.spine.dhotiTv') {
                                                    print("ifconditionwork");
                                                    homeProvider.searchEt.text = "";
                                                    homeProvider.currentLimit = 50;
                                                    homeProvider.fetchReceiptList(50);
                                                    callNext(ReceiptListPage(from: "home", total: '', state: '', district: '', assembly: '', target: '',),
                                                        context);
                                                  } else {
                                                    homeProvider.currentLimit = 50;
                                                    homeProvider.fetchReceiptListForMonitorApp(50);
                                                    callNext( ReceiptListMonitorScreen(), context);

                                                    // homeProvider.fetchPaymentReceiptList();
                                                  }
                                                } else {
                                                  homeProvider.searchEt.text = "";
                                                  homeProvider.currentLimit = 50;
                                                  homeProvider.fetchReceiptList(50);
                                                  callNext(ReceiptListPage(from: "home", total: '', state: '', district: '', assembly: '', target: '',),
                                                      context);
                                                }
                                              }
                                              else if (index == 1) {
                                                //My History
                                                homeProvider.fetchHistoryFromFireStore();
                                                callNext(PaymentHistory(), context);
                                              }
                                              if (index == 2) {
                                                //Report
                                                homeProvider.selectedDistrict = null;
                                                homeProvider.selectedPanjayath = null;
                                                homeProvider.selectedUnit = null;
                                                homeProvider.panchayathTarget=0.0;
                                                homeProvider.panchayathPosterPanchayath="";
                                                homeProvider.panchayathPosterAssembly="";
                                                homeProvider.panchayathPosterDistrict="";
                                                homeProvider.panchayathPosterComplete=false;
                                                homeProvider.panchayathPosterNotCompleteComplete=false;
                                                // homeProvider.fetchDropdown('', '');
                                                // homeProvider.fetchWard();
                                                homeProvider.fetchReportState();
                                                homeProvider.fetchWholeAssemblyTotal();
                                                callNext(WardHistory(), context);
                                              }
                                              else if (index == 3) {
                                                //Lead
                                                homeProvider.topLeadPayments();
                                                callNext(LeadReport(), context);
                                              }
                                              else if (index == 4) {
                                                //Topper's\nClub
                                                // callNext( DistrictReport(from: '',), context);
                                                callNext( ToppersHomeScreen(), context);
                                                print("hhhhhwise");
                                                homeProvider.fetchTopAssemblyReport();
                                              }
                                              else if (index == 5){
                                                //Top\nVolunteers
                                                homeProvider.getTopEnrollers();
                                                callNext(const TopEnrollersScreen(), context);
                                              }
                                              else if (index == 6) {
                                                //Volunteer\nRegistration
                                                print("device click here");
                                                HomeProvider homeProvider =
                                                Provider.of<HomeProvider>(context, listen: false);
                                                await homeProvider.checkEnrollerDeviceID();
                                                if (value2.enrollerDeviceID) {
                                                  print("deviceid already exixt");
                                                  deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                } else {
                                                  homeProvider.clearEnrollerData();
                                                  callNext(BeAnEnroller(), context);
                                                }
                                              }
                                              else if (index == 7) {
                                                //Volunteer\nPayments
                                                print("clikk22334");
                                                homeProvider.clearEnrollerDetails();
                                                callNext(const EnrollerPaymentsScreen(), context);
                                              }
                                            },
                                            child: Center(
                                              child: Container(
                                                  padding: const EdgeInsets.all(0),
                                                  alignment: Alignment.center,
                                                  width: width * .20,
                                                  // height: 48,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15)),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                                        alignment:Alignment.topCenter,
                                                        height: 60,
                                                        decoration:  const BoxDecoration(
                                                            color:clEEEEEE,
                                                            borderRadius: BorderRadius.all(Radius.circular(25))
                                                        ),
                                                        child: Container(
                                                          alignment:Alignment.center,
                                                          decoration: const BoxDecoration(
                                                              color:myWhite,
                                                              borderRadius: BorderRadius.all(Radius.circular(25))
                                                          ),
                                                          height: 50,
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                                color:clC46F4F,

                                                              borderRadius: BorderRadius.all(Radius.circular(13))
                                                            ),
                                                            height: 35,
                                                            child: Image.asset(
                                                              contriImg[index],
                                                              scale: 4.2,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          alignment: Alignment.center,
                                                          width: width,
                                                          height: 35,
                                                          child: Text(
                                                            contriText[index],
                                                            textAlign: TextAlign.center,
                                                            style: const TextStyle(
                                                                fontFamily: "PoppinsMedium",
                                                                fontSize: 11,
                                                                fontWeight: FontWeight.w600,
                                                                color: cl000000
                                                            ),
                                                            overflow: TextOverflow.fade,
                                                          )),
                                                    ],
                                                  )),
                                            ),
                                          );
                                        });
                                  }),

                              const SizedBox(height: 15,),

                        //P&T&C
                        Container(
                          // color: Colors.red,
                          height: 55,
                          // padding: EdgeInsets.only(bottom: 5,top: 5),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0,bottom: 15,top: 10),
                                child: InkWell(
                                  onTap:(){
                                    if(index==0){
                                      alertTerm(context);
                                    } else if(index==1){
                                      alertTermsAndConditions(context);
                                    } else if(index==2){
                                      alertContact(context);
                                    }else if(index==3){
                                      alertAbout(context);
                                    }
                                  },
                                  child: Container(
                                    // padding: const EdgeInsets.symmetric(horizontal: 8),
                                    alignment: Alignment.center,
                                    height: 40,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color:myWhite,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      // border: Border.all(color: clE1E1E1),
                                      boxShadow: [
                                        BoxShadow(
                                            color:cl000000.withOpacity(0.25),
                                            // spreadRadius:,
                                            blurRadius:3,
                                            offset: const Offset(0, 1.78)
                                        )
                                      ]
                                    ),
                                    child: Row(
                                      children: [
                                         Icon(PTCIcon[index],size: 17,),
                                        SizedBox(width:2),
                                        Text(
                                          PTCText[index],
                                          style: const TextStyle(
                                              color: cl434343,
                                              fontSize: 11,
                                              fontFamily: "Lato",
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),


                              //version
                              Consumer<HomeProvider>(builder: (context, value, child) {

                                return Container(
                                  // color: myWhite,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),)),
                                );
                              }),

                              SizedBox(height: 7,),

                              // Text("Donors making donations are not eligible for Tax exemption under Section 80G",
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: myBlack.withOpacity(0.45),fontFamily: "Poppins"),),
                              Container(
                                // color: myWhite,
                                height: 80,
                              )
                            ],
                          ),
                        )

                      ])),
            ),

            ///floating action button
            floatingActionButton: Consumer<HomeProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 2),
                child:
                InkWell(
                  onTap: () {
                    // homeProvider.testBase();
                    mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                      if (event.snapshot.value.toString() == 'ON') {
                        DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                        donationProvider.amountTC.text = "";
                        donationProvider.nameTC.text = "";
                        donationProvider.phoneTC.text = "";
                        donationProvider.subCommitteeCT.text = "";
                        donationProvider.kpccAmountController.text = "";
                        donationProvider.onAmountChange('');
                        donationProvider.clearGenderAndAgedata();
                        donationProvider.selectedPanjayathChip = null;
                        donationProvider.chipsetAssemblyList.clear();
                        donationProvider.selectedAssembly = null;'1';
                        donationProvider.minimumbool=true;
                        callNext(DonatePage(), context);
                      } else {
                        callNext(const NoPaymentGateway(), context);
                      }
                    });
                  },
                  child:
                  // SizedBox(
                  //   width: width * .900,
                  //   child: SwipeableButtonView(
                  //
                  //     buttonText: 'Participate Now',
                  //   buttontextstyle: const TextStyle(
                  //     fontSize: 21,
                  //       color: myWhite, fontWeight: FontWeight.bold
                  //   ),
                  //   //  buttonColor: Colors.yellow,
                  //     buttonWidget: Container(
                  //       child: const Icon(
                  //         Icons.arrow_forward_ios_rounded,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                  //
                  //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                  //     disableColor: Colors.purple,
                  //
                  //     isFinished: isFinished,
                  //     onWaitingProcess: () {
                  //       Future.delayed(const Duration(milliseconds: 10), () {
                  //         setState(() {
                  //           isFinished = true;
                  //         });
                  //       });
                  //     },
                  //     onFinish: () async {
                  //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                  //         if (event.snapshot.value.toString() == 'ON') {
                  //           DonationProvider donationProvider =
                  //           Provider.of<DonationProvider>(context,
                  //               listen: false);
                  //           donationProvider.amountTC.text = "";
                  //           donationProvider.nameTC.text = "";
                  //           donationProvider.phoneTC.text = "";
                  //           donationProvider.kpccAmountController.text = "";
                  //           donationProvider.onAmountChange('');
                  //           donationProvider.clearGenderAndAgedata();
                  //           donationProvider.selectedPanjayathChip = null;
                  //           donationProvider.chipsetWardList.clear();
                  //           donationProvider.selectedWard = null;
                  //           '1';
                  //
                  //           callNext(DonatePage(), context);
                  //         } else {
                  //           callNext(const NoPaymentGateway(), context);
                  //         }
                  //       });
                  //       setState(() {
                  //         isFinished = false;
                  //       });
                  //     },
                  //   ),
                  // )
                  ///
                  Container(
                    height: 50,
                    // width: width * .760,
                    margin: EdgeInsets.symmetric(horizontal: 21),
                    decoration:  BoxDecoration(
                      boxShadow:  [
                        const BoxShadow(
                          color:cl3655A2,
                        ),
                        BoxShadow(
                          color: cl000000.withOpacity(0.25),
                          spreadRadius: -5.0,
                          // blurStyle: BlurStyle.inner,
                          blurRadius: 20.0,
                        ),

                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: clC46F4F

                    ),
                    child: const Center(
                        child: Text(
                          "Contribute Now",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              color: myWhite, fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
              );
            }),
          ),
        ):
        Scaffold(
          backgroundColor: clFFFFFF,
          body: SizedBox(
            width:width,
            child: Stack(
              children: [


                SizedBox(
                  width:width,
                  // color:Colors.blue,
                  child: Row(
                    children: [
                      Expanded(
                          flex:1,
                          child: Container(
                            // color:Colors.red,
                              child:Image.asset("assets/TvLeft4x.png",fit: BoxFit.cover)
                          )),
                      Expanded(
                        flex:1,
                        child: SizedBox(
                          // color:Colors.red,
                          // width:500,
                          height: height,
                          child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Column(children: [
                                SizedBox(
                                  height: 445,//height*.58
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: width,
                                          height:380,//380
                                          // height: 0.42*height,
                                          decoration:   BoxDecoration(
                                            color: Colors.grey.withOpacity(0.3),
                                            image: const DecorationImage(
                                              image: AssetImage("assets/ksdHomeTpImg.jpeg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(left:width*.05),
                                            height:150,
                                            width:170,
                                            decoration: const BoxDecoration(
                                              // color:Colors.red,
                                                image:DecorationImage(
                                                    image:AssetImage("assets/ksdHomeTope.png")
                                                )
                                            ),
                                          ),
                                        ),
                                      ),


                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: InkWell(
                                          onTap: (){
                                            mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                                              if (event.snapshot.value.toString() == 'ON') {
                                                DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                donationProvider.amountTC.text = "";
                                                donationProvider.nameTC.text = "";
                                                donationProvider.phoneTC.text = "";
                                                donationProvider.subCommitteeCT.text = "";
                                                donationProvider.kpccAmountController.text = "";
                                                donationProvider.onAmountChange('');
                                                donationProvider.clearGenderAndAgedata();
                                                donationProvider.selectedPanjayathChip = null;
                                                donationProvider.chipsetAssemblyList.clear();
                                                donationProvider.selectedAssembly = null;'1';
                                                donationProvider.minimumbool=true;

                                                callNext(DonatePage(), context);
                                              } else {
                                                callNext(const NoPaymentGateway(), context);
                                              }
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 20),
                                            height: 135,
                                            width: width,
                                            decoration:  const BoxDecoration(
                                              // color:Colors.blue,
                                              image: DecorationImage(
                                                  image: AssetImage("assets/homeAmount_bgrnd.png",),
                                                  fit: BoxFit.fill
                                              ),

                                            ),
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // Image.asset(
                                                //   "assets/splash_text.png",
                                                //   scale: 5.5,
                                                // ),
                                                SizedBox(
                                                  height: 0.105*height,
                                                  child: Consumer<HomeProvider>(
                                                      builder: (context, value, child) {
                                                        return Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text("Collected so far,",
                                                              style: blackPoppinsM12,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(left: 0, bottom: 10),
                                                                  child: Image.asset(
                                                                    'assets/rs.png',
                                                                    // height:15,
                                                                    scale: 2,
                                                                    color: myWhite,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 5),
                                                                  child: Text(
                                                                      getAmount(value.totalCollection),
                                                                      style:  GoogleFonts.akshar(textStyle: whiteGoogle38)
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),

                                          ),
                                        ),
                                      ),

                                      // Positioned(
                                      //   left: 0,
                                      //   bottom: 10,
                                      //   child: Stack(
                                      //     children: [
                                      //       SizedBox(
                                      //         height: 0.251*height,
                                      //         width: width,
                                      //         //color: Colors.purple,
                                      //         // decoration: BoxDecoration(
                                      //         //  //  color: Colors.purple,
                                      //         //   borderRadius: BorderRadius.circular(30),
                                      //         // ),
                                      //         child: CarouselSlider.builder(
                                      //           itemCount: images.length,
                                      //           itemBuilder: (context, index, realIndex) {
                                      //             //final image=value.imgList[index];
                                      //             final image = images[index];
                                      //             return buildImage(image, context);
                                      //           },
                                      //           options: CarouselOptions(
                                      //             clipBehavior: Clip.antiAliasWithSaveLayer,
                                      //            // autoPlayCurve: Curves.linear,
                                      //               height: 0.212*height,
                                      //               viewportFraction: 1,
                                      //               autoPlay: true,
                                      //               //enableInfiniteScroll: false,
                                      //               pageSnapping: true,
                                      //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                                      //               enlargeCenterPage: true,
                                      //               autoPlayInterval: const Duration(seconds: 3),
                                      //               onPageChanged: (index, reason) {
                                      //                 setState(() {
                                      //                   activeIndex = index;
                                      //                 });
                                      //               }),
                                      //         ),
                                      //       ),
                                      //       Positioned(
                                      //           left: 150,
                                      //           bottom: 20,
                                      //           child: buidIndiaCator(images.length, context))
                                      //     ],
                                      //   ),
                                      // ),

                                    ],
                                  ),
                                ),

                                // const SizedBox(height: 23,),

                                //     Container(
                                //       decoration:const BoxDecoration(
                                //         color: myWhite,
                                //        // border:Border.all(color: Colors.white,width: 0.2),
                                //         ),
                                //       //  color: myRed,
                                //       //  height: 50,
                                //         child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Padding(
                                //          padding: const EdgeInsets.only(left: 20.0),
                                //         child: Text(
                                //           !Platform.isIOS?"Contribute":"Reports",
                                //           style: b_myContributiontx,
                                //         ),
                                //       ),
                                //       // SizedBox(
                                //       //   width: width * .5,
                                //       // ),
                                //       Padding(
                                //         padding: const EdgeInsets.only(right: 12.0),
                                //         child: InkWell(
                                //           onTap: (){
                                //             print("1254");
                                //
                                //             alertSupport(context);
                                //
                                //           },
                                //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                const SizedBox(height: 20,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 38,
                                      width: 163,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow:  [
                                            BoxShadow(
                                                color: c_Grey.withOpacity(0.15),
                                                blurRadius: 2,
                                                spreadRadius: 2
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(19)
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          alertSupport(context);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text("Support",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "PoppinsMedium",
                                                color:cl3655A2,
                                              ),),
                                            Row(
                                              children: [
                                                const Icon(Icons.phone,size: 17,),
                                                const SizedBox(width: 10,),
                                                Image.asset("assets/whatsapp.png",scale:3.6,),
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ),

                                    Consumer<HomeProvider>(
                                        builder: (context,value11,child) {
                                          return
                                            value11.iosPaymentButton =='ON'?
                                            InkWell(
                                              onTap: (){
                                                homeProvider.getVideo(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10.0,right: 2),
                                                    child: Image.asset("assets/youtube.png",scale: 2,),
                                                  ),
                                                  const Text("How to Pay?",
                                                    style: TextStyle(fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "PoppinsMedium",
                                                      color: cl3655A2,
                                                    ),),
                                                ],
                                              ),
                                            ):const SizedBox();
                                        }
                                    ),


                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                                  child: Container(
                                    height: 100,
                                    width: width,
                                    decoration: const BoxDecoration(
                                        color: clFFFFFF,
                                        boxShadow: [
                                          BoxShadow(
                                              color: cl0x40CACACA,
                                              blurRadius: 16
                                          )

                                        ]

                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:12,bottom: 8,right: 8),
                                          child: Image.asset("assets/todaysTopper.png",scale: 3.3,),
                                        ),
                                        Container(width: 1,color: clD4D4D4,margin: const EdgeInsets.only(top: 12,bottom: 12),),
                                        // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                                        Flexible(
                                          fit:FlexFit.tight,
                                          child: Consumer<DonationProvider>(
                                              builder: (context,value,child) {
                                                return Container(
                                                  // color: Colors.yellow,
                                                  // width: width/1.9,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(height: 2,),
                                                        SizedBox(
                                                          width: width/2,
                                                          // color: Colors.red,
                                                          child: Text(
                                                            value.todayTopperName,
                                                            style: const TextStyle(
                                                                height: 1.3,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: "PoppinsMedium",
                                                                color: cl3655A2),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 2,),
                                                        value.todayTopperPlace != ""
                                                            ? Text(
                                                          value.todayTopperPlace,
                                                          style: const TextStyle(
                                                              height: 1.3,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                              fontFamily: "PoppinsMedium",
                                                              color: cl6B6B6B),
                                                        )
                                                            : const SizedBox(),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            value.todayTopperPanchayath=="FAMILY CONTRIBUTION"?const SizedBox():
                                                            Text(
                                                              value.todayTopperPanchayath,
                                                              style: const TextStyle(
                                                                  height: 1.3,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: "PoppinsMedium",
                                                                  color: cl6B6B6B
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const Padding(
                                                                  padding: EdgeInsets.only(
                                                                      right: 2),
                                                                  child: SizedBox(
                                                                    height: 15,
                                                                    child: Text(
                                                                      "₹",
                                                                      style: TextStyle(color: clblue,fontSize: 16),
                                                                      // scale: 7,
                                                                      // color: myBlack2,
                                                                    ),
                                                                  ),
                                                                ),
                                                                AutoSizeText(
                                                                  getAmount(value.todayTopperAmount),
                                                                  style: const TextStyle(
                                                                      fontWeight: FontWeight.w700,
                                                                      fontFamily: "PoppinsMedium",
                                                                      fontSize: 18,
                                                                      color: clblue),
                                                                )
                                                              ],
                                                            ),

                                                            // AutoSizeText.rich(
                                                            //   TextSpan(children: [
                                                            //     const TextSpan(
                                                            //         text: "₹ ",
                                                            //         style: TextStyle(fontSize: 14,color: cl323A71)),
                                                            //     TextSpan(
                                                            //       text: getAmount(value.todayTopperAmount),
                                                            //       style: const TextStyle(
                                                            //           fontWeight: FontWeight.w700,
                                                            //           fontFamily: "PoppinsMedium",
                                                            //           fontSize: 18,
                                                            //           color: cl323A71
                                                            //       ),
                                                            //     )
                                                            //   ]),
                                                            //   textAlign: TextAlign.center,
                                                            //   minFontSize: 5,
                                                            //   maxFontSize: 18,
                                                            //   maxLines: 1,
                                                            // ),
                                                          ],
                                                        ),
                                                        const SizedBox(width: 40,),

                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                amount.isEmpty
                                    ? const SizedBox()
                                    : Container(
                                  height: 125,
                                  alignment: Alignment.center,
                                  child: GridView.builder(
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 8,
                                          crossAxisCount: 2,
                                          mainAxisExtent: 50),
                                      padding: const EdgeInsets.all(12),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: amount.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            donationProvider.kpccAmountController.text = amount[index].toString();
                                            donationProvider.subCommitteeCT.text = "";
                                            donationProvider.nameTC.text = "";
                                            donationProvider.phoneTC.text = "";
                                            donationProvider.clearGenderAndAgedata();
                                            donationProvider.selectedPanjayathChip = null;
                                            donationProvider.chipsetAssemblyList.clear();
                                            donationProvider.selectedAssembly = null;'1';
                                            donationProvider.minimumbool=false;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => DonatePage()));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                                            child: Container(
                                                height: 42,
                                                width: 144,
                                                decoration:  const BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:  cl0x40CACACA,
                                                          spreadRadius: 2,
                                                          blurRadius: 20
                                                      )
                                                    ],
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    color: clFFFFFF
                                                ),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 0,top: 2.0,bottom: 2),
                                                        child: CircleAvatar(
                                                          backgroundColor: colors[index],
                                                          radius: 33,
                                                          foregroundImage: const AssetImage("assets/CoinGif.gif",),
                                                          // child: Image.asset("assets/CoinGif.gif",width: 80,),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Padding(
                                                            padding: EdgeInsets.only(top: 5.0),
                                                            child: Text(
                                                                "₹ ",
                                                                style: TextStyle(
                                                                    color: cl264186,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w500)
                                                            ),
                                                          ),
                                                          Text(
                                                              '${amount[index]}',
                                                              style: const TextStyle(
                                                                  fontFamily: "PoppinsMedium",
                                                                  color: cl264186,
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w700)
                                                          ),
                                                          const SizedBox(width: 10,)
                                                          // RichText(textAlign: TextAlign.start,
                                                          //   text: TextSpan(children: [
                                                          //     const TextSpan(
                                                          //         text: "₹ ",
                                                          //         style: TextStyle(
                                                          //             color: myBlack,
                                                          //             fontSize: 12,
                                                          //             fontWeight: FontWeight.w500),),
                                                          //     TextSpan(
                                                          //         text: '${amount[index]}',
                                                          //         style: const TextStyle(
                                                          //             fontFamily: "PoppinsMedium",
                                                          //             color: cl323A71,
                                                          //             fontSize: 20,
                                                          //             fontWeight: FontWeight.w700)),
                                                          //   ]),
                                                          // ),
                                                        ],
                                                      )
                                                    ])),
                                          ),
                                        );
                                      }),
                                ),

                                Container(
                                  padding: const EdgeInsets.all(0),
                                  // color:myWhite,
                                  child: GridView.builder(
                                      padding: const EdgeInsets.all(25),
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 0,
                                          crossAxisCount: 4,
                                          mainAxisExtent: 95),
                                      itemCount: contriImg.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Consumer<HomeProvider>(
                                            builder: (context, value2, child) {
                                              return InkWell(
                                                onTap: () async {

                                                  if (index == 0) {
                                                    //Transactions
                                                    if (!kIsWeb) {
                                                      PackageInfo packageInfo =
                                                      await PackageInfo.fromPlatform();
                                                      String packageName = packageInfo.packageName;
                                                      if (packageName != 'com.spine.bloodmoneymonitor' &&
                                                          packageName != 'com.spine.dhotiTv') {
                                                        print("ifconditionwork");
                                                        homeProvider.searchEt.text = "";
                                                        homeProvider.currentLimit = 0;
                                                        homeProvider.fetchReceiptList(50);
                                                        callNext(ReceiptListPage(from: "home", total: '', state: '', district: '', assembly: '', target: '',),
                                                            context);
                                                      } else {
                                                        homeProvider.currentLimit = 50;
                                                        homeProvider.fetchReceiptListForMonitorApp(50);
                                                        callNext( ReceiptListMonitorScreen(), context);

                                                        // homeProvider.fetchPaymentReceiptList();
                                                      }
                                                    } else {
                                                      homeProvider.searchEt.text = "";
                                                      homeProvider.currentLimit = 50;
                                                      homeProvider.fetchReceiptList(50);
                                                      callNext(ReceiptListPage(from: "home", total: '', state: '', district: '', assembly: '', target: '',),
                                                          context);
                                                    }
                                                  }
                                                  else if (index == 1) {
                                                    //My History
                                                    homeProvider.fetchHistoryFromFireStore();
                                                    callNext(PaymentHistory(), context);
                                                  }
                                                  if (index == 2) {
                                                    //Report
                                                    homeProvider.selectedDistrict = null;
                                                    homeProvider.selectedPanjayath = null;
                                                    homeProvider.selectedUnit = null;
                                                    homeProvider.panchayathTarget=0.0;
                                                    homeProvider.panchayathPosterPanchayath="";
                                                    homeProvider.panchayathPosterAssembly="";
                                                    homeProvider.panchayathPosterDistrict="";
                                                    homeProvider.panchayathPosterComplete=false;
                                                    homeProvider.panchayathPosterNotCompleteComplete=false;
                                                    homeProvider.fetchReportState();
                                                    // homeProvider.fetchDropdown('', '');
                                                    homeProvider
                                                        .fetchWholeAssemblyTotal();
                                                    callNext(WardHistory(), context);
                                                  }
                                                  else if (index == 3) {
                                                    //Lead
                                                    homeProvider.topLeadPayments();
                                                    callNext(LeadReport(), context);
                                                  }
                                                  else if (index == 4) {
                                                    //Topper's\nClub
                                                    // callNext( DistrictReport(from: '',), context);
                                                    callNext( ToppersHomeScreen(), context);
                                                    print("hhhhhwise");
                                                    homeProvider.fetchTopAssemblyReport();
                                                  }
                                                  else if (index == 5){
                                                    //Top\nVolunteers
                                                    homeProvider.getTopEnrollers();
                                                    callNext(const TopEnrollersScreen(), context);
                                                  }
                                                  else if (index == 6) {
                                                    //Volunteer\nRegistration
                                                    print("device click here");
                                                    HomeProvider homeProvider =
                                                    Provider.of<HomeProvider>(context, listen: false);
                                                    await homeProvider.checkEnrollerDeviceID();
                                                    if (value2.enrollerDeviceID) {
                                                      print("deviceid already exixt");
                                                      deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                    } else {
                                                      homeProvider.clearEnrollerData();
                                                      callNext(BeAnEnroller(), context);
                                                    }
                                                  }
                                                  else if (index == 7) {
                                                    //Volunteer\nPayments
                                                    print("clikk22334");
                                                    homeProvider.clearEnrollerDetails();
                                                    callNext(const EnrollerPaymentsScreen(), context);
                                                  }
                                                },
                                                child: Center(
                                                  child: Container(
                                                      padding: const EdgeInsets.all(0),
                                                      alignment: Alignment.center,
                                                      width: width * .20,
                                                      // height: 48,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15)),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            decoration: const BoxDecoration(
                                                              shape:BoxShape.circle,
                                                              gradient: LinearGradient(
                                                                begin: Alignment(0.00, -1.00),
                                                                end: Alignment(0, 1),
                                                                colors: [cl3655A2, cl264186],
                                                              ),
                                                            ),
                                                            height: 55,
                                                            child: Image.asset(
                                                              contriImg[index],
                                                              scale: 3,
                                                            ),
                                                          ),
                                                          Container(
                                                              alignment: Alignment.center,
                                                              width: width,
                                                              height: 35,
                                                              // color:Colors.yellow,
                                                              child: Text(
                                                                contriText[index],
                                                                textAlign: TextAlign.center,
                                                                style: const TextStyle(
                                                                    fontFamily: "PoppinsMedium",
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: cl3655A2
                                                                ),
                                                                overflow: TextOverflow.fade,
                                                              )),

                                                        ],
                                                      )),
                                                ),
                                              );
                                            });
                                      }),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 10, 30,0),
                                  child: SizedBox(
                                      height: 0.15*height,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: 3,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context, int index) {
                                          return InkWell(
                                            onTap:(){
                                              if(index==1){
                                                alertTermsAndConditions(context);
                                              }else if(index==2){
                                                alertContact(context);
                                              }else if(index==0){
                                                alertTerm(context);
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 12.0,left: 12),
                                              child: Column(
                                                  children: [
                                                    // CircleAvatar(
                                                    //   radius:30,
                                                    //   backgroundColor: clF8F8F8,
                                                    //   child: Image.asset(
                                                    //     PTCImg[index],
                                                    //     scale: 3,
                                                    //     color: cl3655A2,
                                                    //   ),
                                                    // ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      PTCText[index],
                                                      style: const TextStyle(
                                                          color: myBlack,
                                                          fontSize: 11,
                                                          fontFamily: "Lato",
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                  ]),
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                ),


                                Consumer<HomeProvider>(builder: (context, value, child) {
                                  print("aaaaaaaaaaaaaaaa"+value.buildNumber);
                                  return Container(
                                    // color: myWhite,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),)),
                                  );
                                }
                                ),
                                Container(
                                  // color: myWhite,
                                  height: 80,
                                )
                              ])),
                        ),
                      ),

                      Expanded(
                          flex:1,
                          child: Container(
                            // color:Colors.green,
                              child:Image.asset("assets/TvRight4x.png",fit: BoxFit.cover,)
                          )),
                    ],
                  ),
                ),

                Consumer<HomeProvider>(
                    builder: (context,value,child) {
                      return
                        value.isLaunched ?
                        Align(
                          alignment:Alignment.topRight ,
                          child:ConfettiWidget(
                            gravity: .3,
                            minBlastForce: 5, maxBlastForce: 800,
                            numberOfParticles: 500,
                            confettiController: controllerCenter,
                            blastDirectionality: BlastDirectionality.explosive,
                            // don't specify a direction, blast randomly
                            //blastDirection: BorderSide.strokeAlignOutside,
                            shouldLoop: true, // start again as soon as the animation is finished
                            colors: const [
                              Color(0xFFFFDF00),//Golden yellow
                              Color(0xFFD4AF37),//Metallic gold
                              Color(0xFFCFB53B),//Old gold
                              Color(0xFFC5B358),//Old gold
                              // Colors.green,
                              // Colors.blue,
                              // Colors.pink,
                              // Colors.orange,
                              // Colors.purple,
                              // Colors.red,
                              // Colors.greenAccent,
                              // Colors.white,
                              // Colors.lightGreen,
                              // Colors.lightGreenAccent
                            ], // manually specify the colors to be used
                            createParticlePath: value.drawStar, // define a custom shape/path.
                          ),
                        )
                            :const SizedBox();
                    }
                ),

                Consumer<HomeProvider>(
                    builder: (context,value,child) {
                      return value.isLaunched
                          ?Align(
                        alignment:Alignment.bottomLeft,
                        child: ConfettiWidget(
                          gravity: .3,
                          minBlastForce: 5, maxBlastForce: 800,
                          numberOfParticles: 500,
                          confettiController: controllerCenter,
                          blastDirectionality: BlastDirectionality.explosive,
                          shouldLoop: true,
                          colors: const [
                            Color(0xFFFFDF00), //Golden yellow
                            Color(0xFFD4AF37), //Metallic gold
                            Color(0xFFCFB53B), //Old gold
                            Color(0xFFC5B358), //Old gold
                          ], // manually specify the colors to be used
                          createParticlePath:
                          value.drawStar, // define a custom shape/path.
                        ),
                      ):const SizedBox();
                    }
                ),
              ],
            ),
          ),

          ///old body singlechid ,dont remove it
          ///

          ///floating action button
          // floatingActionButton: Consumer<HomeProvider>(builder: (context, value, child) {
          //   return ((kIsWeb ||
          //       Platform.isAndroid
          //       || value.iosPaymentGateway == 'ON')
          //       &&!Platform.isIOS
          //   )
          //       ? Padding(
          //     padding: const EdgeInsets.only(left: 0.0, right: 2),
          //     child:
          //     InkWell(
          //       onTap: () {
          //         // homeProvider.testBase();
          //         mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
          //           if (event.snapshot.value.toString() == 'ON') {
          //             DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
          //             donationProvider.amountTC.text = "";
          //             donationProvider.nameTC.text = "";
          //             donationProvider.phoneTC.text = "";
          //             donationProvider.subCommitteeCT.text = "";
          //             donationProvider.kpccAmountController.text = "";
          //             donationProvider.onAmountChange('');
          //             donationProvider.clearGenderAndAgedata();
          //             donationProvider.selectedPanjayathChip = null;
          //             donationProvider.chipsetWardList.clear();
          //             donationProvider.selectedWard = null;'1';
          //             donationProvider.minimumbool=true;
          //             callNext(DonatePage(), context);
          //           } else {
          //             callNext(const NoPaymentGateway(), context);
          //           }
          //         });
          //       },
          //       child:
          //       // SizedBox(
          //       //   width: width * .900,
          //       //   child: SwipeableButtonView(
          //       //
          //       //     buttonText: 'Participate Now',
          //       //   buttontextstyle: const TextStyle(
          //       //     fontSize: 21,
          //       //       color: myWhite, fontWeight: FontWeight.bold
          //       //   ),
          //       //   //  buttonColor: Colors.yellow,
          //       //     buttonWidget: Container(
          //       //       child: const Icon(
          //       //         Icons.arrow_forward_ios_rounded,
          //       //         color: Colors.grey,
          //       //       ),
          //       //     ),
          //       //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
          //       //
          //       //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
          //       //     disableColor: Colors.purple,
          //       //
          //       //     isFinished: isFinished,
          //       //     onWaitingProcess: () {
          //       //       Future.delayed(const Duration(milliseconds: 10), () {
          //       //         setState(() {
          //       //           isFinished = true;
          //       //         });
          //       //       });
          //       //     },
          //       //     onFinish: () async {
          //       //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
          //       //         if (event.snapshot.value.toString() == 'ON') {
          //       //           DonationProvider donationProvider =
          //       //           Provider.of<DonationProvider>(context,
          //       //               listen: false);
          //       //           donationProvider.amountTC.text = "";
          //       //           donationProvider.nameTC.text = "";
          //       //           donationProvider.phoneTC.text = "";
          //       //           donationProvider.kpccAmountController.text = "";
          //       //           donationProvider.onAmountChange('');
          //       //           donationProvider.clearGenderAndAgedata();
          //       //           donationProvider.selectedPanjayathChip = null;
          //       //           donationProvider.chipsetWardList.clear();
          //       //           donationProvider.selectedWard = null;
          //       //           '1';
          //       //
          //       //           callNext(DonatePage(), context);
          //       //         } else {
          //       //           callNext(const NoPaymentGateway(), context);
          //       //         }
          //       //       });
          //       //       setState(() {
          //       //         isFinished = false;
          //       //       });
          //       //     },
          //       //   ),
          //       // )
          //       ///
          //       Container(
          //         height: 50,
          //         width: width * .760,
          //         decoration:  BoxDecoration(
          //           boxShadow:  [
          //             const BoxShadow(
          //               color:cl3655A2,
          //             ),
          //             BoxShadow(
          //               color: cl000000.withOpacity(0.25),
          //               spreadRadius: -5.0,
          //               // blurStyle: BlurStyle.inner,
          //               blurRadius: 20.0,
          //             ),
          //
          //           ],
          //           borderRadius: const BorderRadius.all(Radius.circular(35)),
          //           gradient: const LinearGradient(
          //               begin: Alignment.centerLeft,
          //               end: Alignment.centerRight,
          //               colors: [cl3655A2,cl19A391]),
          //
          //         ),
          //         child: const Center(
          //             child: Text(
          //               "Participate Now",
          //               style: TextStyle(
          //                   fontSize: 18,
          //                   fontFamily: "PoppinsMedium",
          //                   color: myWhite, fontWeight: FontWeight.w500),
          //             )),
          //       ),
          //     ),
          //   )
          //       : const SizedBox();
          // }),
        )
    );
  }

  Widget web(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);

    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        return showExitPopup();
      },
      child: SizedBox(
        height: height,
        width: width,
        // decoration: const BoxDecoration( image: DecorationImage(
        //     image: AssetImage("assets/webApp.jpg",),
        //     fit:BoxFit.fill
        // )
        // ),
        child: Stack(
          children: [
            Center(
              child:queryData.orientation == Orientation.portrait
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    child:  Scaffold(
                      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                      backgroundColor: clFFFFFF,

                      body: SizedBox(
                        height: height,

                        // decoration: const BoxDecoration(
                        //   gradient: LinearGradient(
                        //     begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       colors: [myWhite,myWhite])
                        // ),
                        child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(children: [
                              SizedBox(
                                height: height*.58,
                                // color: Colors.red,
                                // decoration:BoxDecoration(
                                //    color:Colors.red,
                                //   border: Border.all(color: myWhite),
                                // ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      child: Container(
                                        width: width,
                                        // height:340,
                                        height: 0.42*height,
                                        decoration:  const BoxDecoration(
                                          color: Color(0xff616072),
                                          image: DecorationImage(
                                            image: AssetImage("assets/carousel.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 0,
                                      left: 0,
                                      child: InkWell(
                                        onTap: (){
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                          height: 135,
                                          width: width,
                                          decoration:  const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage("assets/homeAmount_bgrnd.png",),
                                                fit: BoxFit.fill
                                            ),

                                          ),
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Image.asset(
                                              //   "assets/splash_text.png",
                                              //   scale: 5.5,
                                              // ),
                                              SizedBox(
                                                height: 0.105*height,
                                                child: Consumer<HomeProvider>(
                                                    builder: (context, value, child) {
                                                      return Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("Collected so far,",
                                                            style: blackPoppinsM12,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.only(left: 0, bottom: 10),
                                                                child: Image.asset(
                                                                  'assets/rs.png',
                                                                  // height:15,
                                                                  scale: 2,
                                                                  color: myWhite,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 5),
                                                                child: Text(
                                                                    getAmount(value.totalCollection),
                                                                    style:  GoogleFonts.akshar(textStyle: whiteGoogle38)
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                    ),

                                    // Positioned(
                                    //   left: 0,
                                    //   bottom: 10,
                                    //   child: Stack(
                                    //     children: [
                                    //       SizedBox(
                                    //         height: 0.251*height,
                                    //         width: width,
                                    //         //color: Colors.purple,
                                    //         // decoration: BoxDecoration(
                                    //         //  //  color: Colors.purple,
                                    //         //   borderRadius: BorderRadius.circular(30),
                                    //         // ),
                                    //         child: CarouselSlider.builder(
                                    //           itemCount: images.length,
                                    //           itemBuilder: (context, index, realIndex) {
                                    //             //final image=value.imgList[index];
                                    //             final image = images[index];
                                    //             return buildImage(image, context);
                                    //           },
                                    //           options: CarouselOptions(
                                    //             clipBehavior: Clip.antiAliasWithSaveLayer,
                                    //            // autoPlayCurve: Curves.linear,
                                    //               height: 0.212*height,
                                    //               viewportFraction: 1,
                                    //               autoPlay: true,
                                    //               //enableInfiniteScroll: false,
                                    //               pageSnapping: true,
                                    //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                                    //               enlargeCenterPage: true,
                                    //               autoPlayInterval: const Duration(seconds: 3),
                                    //               onPageChanged: (index, reason) {
                                    //                 setState(() {
                                    //                   activeIndex = index;
                                    //                 });
                                    //               }),
                                    //         ),
                                    //       ),
                                    //       Positioned(
                                    //           left: 150,
                                    //           bottom: 20,
                                    //           child: buidIndiaCator(images.length, context))
                                    //     ],
                                    //   ),
                                    // ),

                                  ],
                                ),
                              ),
                              // const SizedBox(height: 23,),

                              //     Container(
                              //       decoration:const BoxDecoration(
                              //         color: myWhite,
                              //        // border:Border.all(color: Colors.white,width: 0.2),
                              //         ),
                              //       //  color: myRed,
                              //       //  height: 50,
                              //         child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Padding(
                              //          padding: const EdgeInsets.only(left: 20.0),
                              //         child: Text(
                              //           !Platform.isIOS?"Contribute":"Reports",
                              //           style: b_myContributiontx,
                              //         ),
                              //       ),
                              //       // SizedBox(
                              //       //   width: width * .5,
                              //       // ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: 12.0),
                              //         child: InkWell(
                              //           onTap: (){
                              //             print("1254");
                              //
                              //             alertSupport(context);
                              //
                              //           },
                              //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 38,
                                    width: 163,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(19)
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        alertSupport(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text("Support",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PoppinsMedium",
                                            ),),
                                          Row(
                                            children: [
                                              const Icon(Icons.phone,size: 17,),
                                              const SizedBox(width: 1,),
                                              Image.asset("assets/whatsapp.png",scale:3.6,),
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                  ),


                                  Consumer<HomeProvider>(
                                      builder: (context,value1,child) {
                                        return
                                          value1.iosPaymentButton=='ON'?
                                          InkWell(
                                            onTap: (){
                                              homeProvider.getVideo(context);
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0,right: 2),
                                                  child: Image.asset("assets/youtube.png",scale: 2,),
                                                ),
                                                const Text("How to Pay?",
                                                  style: TextStyle(fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "PoppinsMedium",
                                                  ),),
                                              ],
                                            ),
                                          ):const SizedBox();
                                      }
                                  ),


                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                                child: Container(
                                  height: 100,
                                  width: width,
                                  decoration: const BoxDecoration(
                                      color: clFFFFFF,
                                      boxShadow: [
                                        BoxShadow(
                                            color: cl0x40CACACA,
                                            blurRadius: 16
                                        )

                                      ]

                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:12,bottom: 8,right: 8),
                                        child: Image.asset("assets/todaysTopper.png",scale: 2.8,),
                                      ),
                                      Container(width: 1,color: clD4D4D4,margin: const EdgeInsets.only(top: 12,bottom: 12),),
                                      // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                                      Consumer<DonationProvider>(
                                          builder: (context,value,child) {
                                            return SizedBox(
                                              // color: Colors.yellow,
                                              width: width/1.9,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 2,),
                                                    SizedBox(
                                                      width: width/2,
                                                      // color: Colors.red,
                                                      child: Text(
                                                        value.todayTopperName,
                                                        style: const TextStyle(
                                                            height: 1.3,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: "PoppinsMedium",
                                                            color: clblue),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2,),
                                                    value.todayTopperPlace != ""
                                                        ? Text(
                                                      value.todayTopperPlace,
                                                      style: const TextStyle(
                                                          height: 1.3,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "PoppinsMedium",
                                                          color: cl6B6B6B),
                                                    )
                                                        : const SizedBox(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          value.todayTopperPanchayath,
                                                          style: const TextStyle(
                                                              height: 1.3,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                              fontFamily: "PoppinsMedium",
                                                              color: cl6B6B6B
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: 2),
                                                              child: SizedBox(
                                                                height: 15,
                                                                child: Text(
                                                                  "₹",
                                                                  style: TextStyle(color: clblue,fontSize: 16),
                                                                  // scale: 7,
                                                                  // color: myBlack2,
                                                                ),
                                                              ),
                                                            ),
                                                            AutoSizeText(
                                                              getAmount(value.todayTopperAmount),
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.w700,
                                                                  fontFamily: "PoppinsMedium",
                                                                  fontSize: 18,
                                                                  color: clblue),
                                                            )
                                                          ],
                                                        ),

                                                        // AutoSizeText.rich(
                                                        //   TextSpan(children: [
                                                        //     const TextSpan(
                                                        //         text: "₹ ",
                                                        //         style: TextStyle(fontSize: 14,color: cl323A71)),
                                                        //     TextSpan(
                                                        //       text: getAmount(value.todayTopperAmount),
                                                        //       style: const TextStyle(
                                                        //           fontWeight: FontWeight.w700,
                                                        //           fontFamily: "PoppinsMedium",
                                                        //           fontSize: 18,
                                                        //           color: cl323A71
                                                        //       ),
                                                        //     )
                                                        //   ]),
                                                        //   textAlign: TextAlign.center,
                                                        //   minFontSize: 5,
                                                        //   maxFontSize: 18,
                                                        //   maxLines: 1,
                                                        // ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 40,),

                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              amount.isEmpty
                                  ? const SizedBox()
                                  : Container(
                                height: 125,
                                alignment: Alignment.center,
                                child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 2,
                                        mainAxisExtent: 50),
                                    padding: const EdgeInsets.all(12),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: amount.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          donationProvider.kpccAmountController.text = amount[index].toString();

                                          donationProvider.subCommitteeCT.text = "";
                                          donationProvider.nameTC.text = "";
                                          donationProvider.phoneTC.text = "";
                                          donationProvider.clearGenderAndAgedata();
                                          donationProvider.selectedPanjayathChip = null;
                                          donationProvider.chipsetAssemblyList.clear();
                                          donationProvider.selectedAssembly = null;
                                          donationProvider.minimumbool=false;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DonatePage()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                                          child: Container(
                                              height: 42,
                                              width: 144,
                                              decoration:  const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:  cl0x40CACACA,
                                                        spreadRadius: 2,
                                                        blurRadius: 20
                                                    )
                                                  ],
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  color: clFFFFFF
                                              ),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 0,top: 2.0,bottom: 2),
                                                      child: CircleAvatar(
                                                        backgroundColor: colors[index],
                                                        radius: 33,foregroundImage: const AssetImage("assets/CoinGif.gif",),
                                                        // child: Image.asset("assets/CoinGif.gif",width: 80,),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.only(top: 5.0),
                                                          child: Text(
                                                              "₹ ",
                                                              style: TextStyle(
                                                                  color: myBlack,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500)
                                                          ),
                                                        ),
                                                        Text(
                                                            '${amount[index]}',
                                                            style: const TextStyle(
                                                                fontFamily: "PoppinsMedium",
                                                                color: clblue,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w700)
                                                        ),
                                                        const SizedBox(width: 10,)
                                                        // RichText(textAlign: TextAlign.start,
                                                        //   text: TextSpan(children: [
                                                        //     const TextSpan(
                                                        //         text: "₹ ",
                                                        //         style: TextStyle(
                                                        //             color: myBlack,
                                                        //             fontSize: 12,
                                                        //             fontWeight: FontWeight.w500),),
                                                        //     TextSpan(
                                                        //         text: '${amount[index]}',
                                                        //         style: const TextStyle(
                                                        //             fontFamily: "PoppinsMedium",
                                                        //             color: cl323A71,
                                                        //             fontSize: 20,
                                                        //             fontWeight: FontWeight.w700)),
                                                        //   ]),
                                                        // ),
                                                      ],
                                                    )
                                                  ])),
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                padding: const EdgeInsets.all(0),
                                // color:myWhite,
                                child: GridView.builder(
                                    padding: const EdgeInsets.all(25),
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 0,
                                        crossAxisCount: 4,
                                        mainAxisExtent: 95),
                                    itemCount: contriImg.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Consumer<HomeProvider>(
                                          builder: (context, value2, child) {
                                            return InkWell(
                                              onTap: () async {
                                                if (index == 2) {
                                                  // homeProvider.selectedDistrict = null;
                                                  // homeProvider.selectedPanjayath = null;
                                                  // homeProvider.selectedUnit = null;
                                                  // homeProvider.fetchDropdown('', '');
                                                  // homeProvider.fetchWard();
                                                  // callNext(WardHistory(), context);
                                                } else if (index == 6) {
                                                  if (!kIsWeb) {
                                                    PackageInfo packageInfo =
                                                    await PackageInfo.fromPlatform();
                                                    String packageName = packageInfo.packageName;
                                                    if (packageName != 'com.spine.quaide_millatMonitor' &&
                                                        packageName != 'com.spine.dhotiTv') {
                                                      print("ifconditionwork");
                                                      homeProvider.searchEt.text = "";
                                                      homeProvider.currentLimit = 50;
                                                      homeProvider.fetchReceiptList(50);
                                                      callNext(ReceiptListPage(from: "home", total: '', state: '', district: '', assembly: '', target: '',),
                                                          context);
                                                    } else {
                                                      homeProvider.currentLimit = 50;
                                                      homeProvider.fetchReceiptListForMonitorApp(50);
                                                      callNext( ReceiptListMonitorScreen(), context);

                                                      // homeProvider.fetchPaymentReceiptList();
                                                    }
                                                  } else {
                                                    // homeProvider.searchEt.text = "";
                                                    // homeProvider.currentLimit = 50;
                                                    // homeProvider.fetchReceiptList(50);
                                                    // callNext(ReceiptListPage(from: "home", total: '', state: '', district: '', assembly: '', target: '',),
                                                    //     context);
                                                    homeProvider.currentLimit = 50;
                                                    homeProvider.fetchReceiptListForMonitorApp(50);
                                                    callNext( ReceiptListMonitorScreen(), context);
                                                  }
                                                } else if (index == 7) {
                                                  // homeProvider.fetchHistoryFromFireStore();
                                                  // callNext(PaymentHistory(), context);
                                                } else if (index == 0) {
                                                  // homeProvider.getTopEnrollers();
                                                  // callNext(const TopEnrollersScreen(), context);

                                                } else if (index == 3) {
                                                  // homeProvider.topLeadPayments();
                                                  // callNext(LeadReport(), context);
                                                } else if (index == 1) {
                                                  // homeProvider.fetchDistrictWiseReport();
                                                  // callNext( ToppersHomeScreen(), context);
                                                } else if (index == 4) {
                                                  // print("device click here");
                                                  // HomeProvider homeProvider =
                                                  // Provider.of<HomeProvider>(context, listen: false);
                                                  // await homeProvider.checkEnrollerDeviceID();
                                                  // if (value2.enrollerDeviceID) {
                                                  //   print("deviceid already exixt");
                                                  //   deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                  // } else {
                                                  //   homeProvider.clearEnrollerData();
                                                  //   callNext(BeAnEnroller(), context);
                                                  // }
                                                } else if (index == 5) {
                                                  // print("clikk22334");
                                                  // homeProvider.clearEnrollerDetails();
                                                  // callNext(const EnrollerPaymentsScreen(), context);
                                                }
                                              },
                                              child: Center(
                                                child: Container(
                                                    padding: const EdgeInsets.all(0),
                                                    alignment: Alignment.center,
                                                    width: width * .20,
                                                    // height: 48,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15)),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SizedBox(
                                                          height: 55,
                                                          child: Image.asset(
                                                            contriImg[index],
                                                            scale: 2,
                                                          ),
                                                        ),
                                                        Container(
                                                            alignment: Alignment.center,
                                                            width: width,
                                                            height: 35,
                                                            // color:Colors.yellow,
                                                            child: Text(
                                                              contriText[index],
                                                              textAlign: TextAlign.center,
                                                              style: const TextStyle(
                                                                  fontFamily: "PoppinsMedium",
                                                                  fontSize: 11,
                                                                  fontWeight: FontWeight.w600),
                                                              overflow: TextOverflow.fade,
                                                            )),

                                                      ],
                                                    )),
                                              ),
                                            );
                                          });
                                    }),
                              ),


                              Container(
                                // color: myWhite,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 10, 30,0),
                                  child: SizedBox(

                                    // padding: const EdgeInsets.all(8),
                                      height: 0.15*height,
                                      // color: Colors.yellow,
                                      // decoration: const BoxDecoration(
                                      //     color: clFFFFFF,
                                      //     borderRadius: BorderRadius.all(
                                      //       Radius.circular(25),
                                      //     ),
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         color: Colors.grey,
                                      //         blurRadius: 5.0,
                                      //       ),
                                      //     ]),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: 3,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context, int index) {
                                          return InkWell(
                                            onTap:(){
                                              if(index==1){
                                                alertTermsAndConditions(context);
                                              }else if(index==2){
                                                alertContact(context);
                                              }else if(index==0){
                                                alertTerm(context);

                                              }

                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 12.0,left: 12),
                                              child: Column(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius:30,
                                                      backgroundColor: clF8F8F8,
                                                      // child: Image.asset(
                                                      //   PTCImg[index],
                                                      //   scale: 3,
                                                      // ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      PTCText[index],
                                                      style: const TextStyle(
                                                          color: myBlack,
                                                          fontSize: 11,
                                                          fontFamily: "Lato",
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                  ]),
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                ),
                              ),

                              Consumer<HomeProvider>(builder: (context, value, child) {
                                print("aaaaaaaaaaaaaaaa"+value.buildNumber);
                                return Container(
                                  // color: myWhite,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),)),
                                );
                              }
                              ),
                              Container(
                                // color: myWhite,
                                height: 80,
                              )
                            ])),
                      ),

                      ///old body singlechid ,dont remove it
                      ///

                      ///floating action button
                      floatingActionButton: Consumer<HomeProvider>(builder: (context, value, child) {
                        return ((kIsWeb ||
                            Platform.isAndroid ||
                            value.iosPaymentGateway == 'ON')
                            &&!Platform.isIOS
                        )
                            ? Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 2),
                          child:
                          InkWell(
                            onTap: () {
                              mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                                if (event.snapshot.value.toString() == 'ON') {
                                  DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                  donationProvider.amountTC.text = "";
                                  donationProvider.nameTC.text = "";
                                  donationProvider.subCommitteeCT.text = "";
                                  donationProvider.phoneTC.text = "";
                                  donationProvider.kpccAmountController.text = "";
                                  donationProvider.onAmountChange('');
                                  donationProvider.clearGenderAndAgedata();
                                  donationProvider.selectedPanjayathChip = null;
                                  donationProvider.chipsetAssemblyList.clear();
                                  donationProvider.selectedAssembly = null;'1';
                                  donationProvider.minimumbool=true;

                                  callNext(DonatePage(), context);
                                } else {
                                  callNext(const NoPaymentGateway(), context);
                                }
                              });
                            },
                            child:
                            // SizedBox(
                            //   width: width * .900,
                            //   child: SwipeableButtonView(
                            //
                            //     buttonText: 'Participate Now',
                            //   buttontextstyle: const TextStyle(
                            //     fontSize: 21,
                            //       color: myWhite, fontWeight: FontWeight.bold
                            //   ),
                            //   //  buttonColor: Colors.yellow,
                            //     buttonWidget: Container(
                            //       child: const Icon(
                            //         Icons.arrow_forward_ios_rounded,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                            //
                            //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                            //     disableColor: Colors.purple,
                            //
                            //     isFinished: isFinished,
                            //     onWaitingProcess: () {
                            //       Future.delayed(const Duration(milliseconds: 10), () {
                            //         setState(() {
                            //           isFinished = true;
                            //         });
                            //       });
                            //     },
                            //     onFinish: () async {
                            //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                            //         if (event.snapshot.value.toString() == 'ON') {
                            //           DonationProvider donationProvider =
                            //           Provider.of<DonationProvider>(context,
                            //               listen: false);
                            //           donationProvider.amountTC.text = "";
                            //           donationProvider.nameTC.text = "";
                            //           donationProvider.phoneTC.text = "";
                            //           donationProvider.kpccAmountController.text = "";
                            //           donationProvider.onAmountChange('');
                            //           donationProvider.clearGenderAndAgedata();
                            //           donationProvider.selectedPanjayathChip = null;
                            //           donationProvider.chipsetWardList.clear();
                            //           donationProvider.selectedWard = null;
                            //           '1';
                            //
                            //           callNext(DonatePage(), context);
                            //         } else {
                            //           callNext(const NoPaymentGateway(), context);
                            //         }
                            //       });
                            //       setState(() {
                            //         isFinished = false;
                            //       });
                            //     },
                            //   ),
                            // )
                            ///
                            Container(
                              height: 50,
                              width: width * .760,
                              decoration:  BoxDecoration(
                                boxShadow:  [
                                  const BoxShadow(
                                    color:cl3655A2,
                                  ),
                                  BoxShadow(
                                    color: cl000000.withOpacity(0.25),
                                    spreadRadius: -5.0,
                                    // blurStyle: BlurStyle.inner,
                                    blurRadius: 20.0,
                                  ),

                                ],
                                borderRadius: const BorderRadius.all(Radius.circular(35)),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [cl3655A2,cl19A391]),

                              ),
                              child: const Center(
                                  child: Text(
                                    "Participate Now",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "PoppinsMedium",
                                        color: myWhite, fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ),
                        )
                            : const SizedBox();
                      }),
                    ),
                  ),
                ],
              )
                  : Scaffold(
                backgroundColor: clFFFFFF,
                body: SizedBox(
                  width:width,
                  child: Stack(
                    children: [


                      SizedBox(
                        width:width,
                        // color:Colors.blue,
                        child: Row(
                          children: [
                            Expanded(
                                flex:1,
                                child: Container(
                                  // color:Colors.red,
                                    child:Image.asset("assets/TvLeft4x.png",fit: BoxFit.cover)
                                )),
                            Expanded(
                              flex:1,
                              child: SizedBox(
                                // color:Colors.red,
                                // width:500,
                                height: height,
                                child: SingleChildScrollView(
                                    physics: const ScrollPhysics(),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 445,//height*.58
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                  bottomLeft: Radius.circular(20),
                                                  bottomRight: Radius.circular(20)),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                width: width,
                                                height:380,//380
                                                // height: 0.42*height,
                                                decoration:   BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  image: const DecorationImage(
                                                    image: AssetImage("assets/ksdHomeTpImg.jpeg"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: Container(
                                                  margin: EdgeInsets.only(left:width*.05),
                                                  height:150,
                                                  width:170,
                                                  decoration: const BoxDecoration(
                                                    // color:Colors.red,
                                                      image:DecorationImage(
                                                          image:AssetImage("assets/ksdHomeTope.png")
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),


                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: InkWell(
                                                onTap: (){
                                                  mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                                                    if (event.snapshot.value.toString() == 'ON') {
                                                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                      donationProvider.amountTC.text = "";
                                                      donationProvider.nameTC.text = "";
                                                      donationProvider.phoneTC.text = "";
                                                      donationProvider.subCommitteeCT.text = "";
                                                      donationProvider.kpccAmountController.text = "";
                                                      donationProvider.onAmountChange('');
                                                      donationProvider.clearGenderAndAgedata();
                                                      donationProvider.selectedPanjayathChip = null;
                                                      donationProvider.chipsetAssemblyList.clear();
                                                      donationProvider.selectedAssembly = null;'1';
                                                      donationProvider.minimumbool=true;

                                                      callNext(DonatePage(), context);
                                                    } else {
                                                      callNext(const NoPaymentGateway(), context);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                                  height: 135,
                                                  width: width,
                                                  decoration:  const BoxDecoration(
                                                    // color:Colors.blue,
                                                    image: DecorationImage(
                                                        image: AssetImage("assets/homeAmount_bgrnd.png",),
                                                        fit: BoxFit.fill
                                                    ),

                                                  ),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      // Image.asset(
                                                      //   "assets/splash_text.png",
                                                      //   scale: 5.5,
                                                      // ),
                                                      SizedBox(
                                                        height: 0.105*height,
                                                        child: Consumer<HomeProvider>(
                                                            builder: (context, value, child) {
                                                              return Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text("Collected so far,",
                                                                    style: blackPoppinsM12,),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(left: 0, bottom: 10),
                                                                        child: Image.asset(
                                                                          'assets/rs.png',
                                                                          // height:15,
                                                                          scale: 2,
                                                                          color: myWhite,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(right: 5),
                                                                        child: Text(
                                                                            getAmount(value.totalCollection),
                                                                            style:  GoogleFonts.akshar(textStyle: whiteGoogle38)
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                      ),
                                                    ],
                                                  ),

                                                ),
                                              ),
                                            ),

                                            // Positioned(
                                            //   left: 0,
                                            //   bottom: 10,
                                            //   child: Stack(
                                            //     children: [
                                            //       SizedBox(
                                            //         height: 0.251*height,
                                            //         width: width,
                                            //         //color: Colors.purple,
                                            //         // decoration: BoxDecoration(
                                            //         //  //  color: Colors.purple,
                                            //         //   borderRadius: BorderRadius.circular(30),
                                            //         // ),
                                            //         child: CarouselSlider.builder(
                                            //           itemCount: images.length,
                                            //           itemBuilder: (context, index, realIndex) {
                                            //             //final image=value.imgList[index];
                                            //             final image = images[index];
                                            //             return buildImage(image, context);
                                            //           },
                                            //           options: CarouselOptions(
                                            //             clipBehavior: Clip.antiAliasWithSaveLayer,
                                            //            // autoPlayCurve: Curves.linear,
                                            //               height: 0.212*height,
                                            //               viewportFraction: 1,
                                            //               autoPlay: true,
                                            //               //enableInfiniteScroll: false,
                                            //               pageSnapping: true,
                                            //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                                            //               enlargeCenterPage: true,
                                            //               autoPlayInterval: const Duration(seconds: 3),
                                            //               onPageChanged: (index, reason) {
                                            //                 setState(() {
                                            //                   activeIndex = index;
                                            //                 });
                                            //               }),
                                            //         ),
                                            //       ),
                                            //       Positioned(
                                            //           left: 150,
                                            //           bottom: 20,
                                            //           child: buidIndiaCator(images.length, context))
                                            //     ],
                                            //   ),
                                            // ),

                                          ],
                                        ),
                                      ),

                                      // const SizedBox(height: 23,),

                                      //     Container(
                                      //       decoration:const BoxDecoration(
                                      //         color: myWhite,
                                      //        // border:Border.all(color: Colors.white,width: 0.2),
                                      //         ),
                                      //       //  color: myRed,
                                      //       //  height: 50,
                                      //         child: Row(
                                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //           children: [
                                      //             Padding(
                                      //          padding: const EdgeInsets.only(left: 20.0),
                                      //         child: Text(
                                      //           !Platform.isIOS?"Contribute":"Reports",
                                      //           style: b_myContributiontx,
                                      //         ),
                                      //       ),
                                      //       // SizedBox(
                                      //       //   width: width * .5,
                                      //       // ),
                                      //       Padding(
                                      //         padding: const EdgeInsets.only(right: 12.0),
                                      //         child: InkWell(
                                      //           onTap: (){
                                      //             print("1254");
                                      //
                                      //             alertSupport(context);
                                      //
                                      //           },
                                      //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                      const SizedBox(height: 20,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 38,
                                            width: 163,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow:  [
                                                  BoxShadow(
                                                      color: c_Grey.withOpacity(0.15),
                                                      blurRadius: 2,
                                                      spreadRadius: 2
                                                  )
                                                ],
                                                borderRadius: BorderRadius.circular(19)
                                            ),
                                            child: InkWell(
                                              onTap: (){
                                                alertSupport(context);
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  const Text("Support",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "PoppinsMedium",
                                                      color:cl3655A2,
                                                    ),),
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.phone,size: 17,),
                                                      const SizedBox(width: 10,),
                                                      Image.asset("assets/whatsapp.png",scale:3.6,),
                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),

                                          InkWell(
                                            onTap: (){
                                              homeProvider.getVideo(context);
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0,right: 2),
                                                  child: Image.asset("assets/youtube.png",scale: 2,),
                                                ),
                                                const Text("How to Pay?",
                                                  style: TextStyle(fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "PoppinsMedium",
                                                    color: cl3655A2,
                                                  ),),
                                              ],
                                            ),
                                          ),


                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                                        child: Container(
                                          height: 100,
                                          width: width,
                                          decoration: const BoxDecoration(
                                              color: clFFFFFF,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: cl0x40CACACA,
                                                    blurRadius: 16
                                                )

                                              ]

                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:12,bottom: 8,right: 8),
                                                child: Image.asset("assets/todaysTopper.png",scale: 3.3,),
                                              ),
                                              Container(width: 1,color: clD4D4D4,margin: const EdgeInsets.only(top: 12,bottom: 12),),
                                              // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                                              Flexible(
                                                fit:FlexFit.tight,
                                                child: Consumer<DonationProvider>(
                                                    builder: (context,value,child) {
                                                      return Container(
                                                        // color: Colors.yellow,
                                                        // width: width/1.9,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 2,),
                                                              SizedBox(
                                                                width: width/2,
                                                                // color: Colors.red,
                                                                child: Text(
                                                                  value.todayTopperName,
                                                                  style: const TextStyle(
                                                                      height: 1.3,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: "PoppinsMedium",
                                                                      color: cl3655A2),
                                                                ),
                                                              ),
                                                              const SizedBox(height: 2,),
                                                              value.todayTopperPlace != ""
                                                                  ? Text(
                                                                value.todayTopperPlace,
                                                                style: const TextStyle(
                                                                    height: 1.3,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontFamily: "PoppinsMedium",
                                                                    color: cl6B6B6B),
                                                              )
                                                                  : const SizedBox(),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  value.todayTopperPanchayath=="FAMILY CONTRIBUTION"?const SizedBox():
                                                                  Text(
                                                                    value.todayTopperPanchayath,
                                                                    style: const TextStyle(
                                                                        height: 1.3,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontFamily: "PoppinsMedium",
                                                                        color: cl6B6B6B
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            right: 2),
                                                                        child: SizedBox(
                                                                          height: 15,
                                                                          child: Text(
                                                                            "₹",
                                                                            style: TextStyle(color: clblue,fontSize: 16),
                                                                            // scale: 7,
                                                                            // color: myBlack2,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      AutoSizeText(
                                                                        getAmount(value.todayTopperAmount),
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight.w700,
                                                                            fontFamily: "PoppinsMedium",
                                                                            fontSize: 18,
                                                                            color: clblue),
                                                                      )
                                                                    ],
                                                                  ),

                                                                  // AutoSizeText.rich(
                                                                  //   TextSpan(children: [
                                                                  //     const TextSpan(
                                                                  //         text: "₹ ",
                                                                  //         style: TextStyle(fontSize: 14,color: cl323A71)),
                                                                  //     TextSpan(
                                                                  //       text: getAmount(value.todayTopperAmount),
                                                                  //       style: const TextStyle(
                                                                  //           fontWeight: FontWeight.w700,
                                                                  //           fontFamily: "PoppinsMedium",
                                                                  //           fontSize: 18,
                                                                  //           color: cl323A71
                                                                  //       ),
                                                                  //     )
                                                                  //   ]),
                                                                  //   textAlign: TextAlign.center,
                                                                  //   minFontSize: 5,
                                                                  //   maxFontSize: 18,
                                                                  //   maxLines: 1,
                                                                  // ),
                                                                ],
                                                              ),
                                                              const SizedBox(width: 40,),

                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),

                                      amount.isEmpty
                                          ? const SizedBox()
                                          : Container(
                                        height: 125,
                                        alignment: Alignment.center,
                                        child: GridView.builder(
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 2,
                                                crossAxisSpacing: 8,
                                                crossAxisCount: 2,
                                                mainAxisExtent: 50),
                                            padding: const EdgeInsets.all(12),
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: amount.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () {
                                                  donationProvider.kpccAmountController.text = amount[index].toString();
                                                  donationProvider.subCommitteeCT.text = "";
                                                  donationProvider.nameTC.text = "";
                                                  donationProvider.phoneTC.text = "";
                                                  donationProvider.clearGenderAndAgedata();
                                                  donationProvider.selectedPanjayathChip = null;
                                                  donationProvider.chipsetAssemblyList.clear();
                                                  donationProvider.selectedAssembly = null;
                                                  donationProvider.minimumbool=false;
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => DonatePage()));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                                                  child: Container(
                                                      height: 42,
                                                      width: 144,
                                                      decoration:  const BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:  cl0x40CACACA,
                                                                spreadRadius: 2,
                                                                blurRadius: 20
                                                            )
                                                          ],
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                          color: clFFFFFF
                                                      ),
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 0,top: 2.0,bottom: 2),
                                                              child: CircleAvatar(
                                                                backgroundColor: colors[index],
                                                                radius: 33,
                                                                foregroundImage: const AssetImage("assets/CoinGif.gif",),
                                                                // child: Image.asset("assets/CoinGif.gif",width: 80,),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const Padding(
                                                                  padding: EdgeInsets.only(top: 5.0),
                                                                  child: Text(
                                                                      "₹ ",
                                                                      style: TextStyle(
                                                                          color: cl264186,
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500)
                                                                  ),
                                                                ),
                                                                Text(
                                                                    '${amount[index]}',
                                                                    style: const TextStyle(
                                                                        fontFamily: "PoppinsMedium",
                                                                        color: cl264186,
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.w700)
                                                                ),
                                                                const SizedBox(width: 10,)
                                                                // RichText(textAlign: TextAlign.start,
                                                                //   text: TextSpan(children: [
                                                                //     const TextSpan(
                                                                //         text: "₹ ",
                                                                //         style: TextStyle(
                                                                //             color: myBlack,
                                                                //             fontSize: 12,
                                                                //             fontWeight: FontWeight.w500),),
                                                                //     TextSpan(
                                                                //         text: '${amount[index]}',
                                                                //         style: const TextStyle(
                                                                //             fontFamily: "PoppinsMedium",
                                                                //             color: cl323A71,
                                                                //             fontSize: 20,
                                                                //             fontWeight: FontWeight.w700)),
                                                                //   ]),
                                                                // ),
                                                              ],
                                                            )
                                                          ])),
                                                ),
                                              );
                                            }),
                                      ),

                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        // color:myWhite,
                                        child: GridView.builder(
                                            padding: const EdgeInsets.all(25),
                                            physics: const ScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 2,
                                                crossAxisSpacing: 0,
                                                crossAxisCount: 4,
                                                mainAxisExtent: 95),
                                            itemCount: contriImg.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Consumer<HomeProvider>(
                                                  builder: (context, value2, child) {
                                                    return InkWell(
                                                      onTap: () async {

                                                        if (index == 0) {
                                                          //Transactions
                                                          if (!kIsWeb) {
                                                            PackageInfo packageInfo =
                                                            await PackageInfo.fromPlatform();
                                                            String packageName = packageInfo.packageName;
                                                            if (packageName != 'com.spine.bloodmoneymonitor' &&
                                                                packageName != 'com.spine.dhotiTv') {
                                                              print("ifconditionwork");
                                                              homeProvider.searchEt.text = "";
                                                              homeProvider.currentLimit = 0;
                                                              homeProvider.fetchReceiptList(50);
                                                              callNext(ReceiptListPage(from: "home", total: '', state: '', district: '', assembly: '', target: '',),
                                                                  context);
                                                            } else {
                                                              homeProvider.currentLimit = 50;
                                                              homeProvider.fetchReceiptListForMonitorApp(50);
                                                              callNext( ReceiptListMonitorScreen(), context);

                                                              // homeProvider.fetchPaymentReceiptList();
                                                            }
                                                          } else {
                                                            homeProvider.searchEt.text = "";
                                                            homeProvider.currentLimit = 50;
                                                            homeProvider.fetchReceiptList(50);
                                                            callNext(ReceiptListPage(from: "home", total: '', state: '', district: '', assembly: '', target: '',),
                                                                context);
                                                          }
                                                        }
                                                        else if (index == 1) {
                                                          //My History
                                                          homeProvider.fetchHistoryFromFireStore();
                                                          callNext(PaymentHistory(), context);
                                                        }
                                                        if (index == 2) {
                                                          //Report
                                                          homeProvider.selectedDistrict = null;
                                                          homeProvider.selectedPanjayath = null;
                                                          homeProvider.selectedUnit = null;
                                                          homeProvider.panchayathTarget=0.0;
                                                          homeProvider.panchayathPosterPanchayath="";
                                                          homeProvider.panchayathPosterAssembly="";
                                                          homeProvider.panchayathPosterDistrict="";
                                                          homeProvider.panchayathPosterComplete=false;
                                                          homeProvider.panchayathPosterNotCompleteComplete=false;
                                                          homeProvider.fetchWholeAssemblyTotal();
                                                          homeProvider.fetchReportState();
                                                          callNext(WardHistory(), context);
                                                        }
                                                        else if (index == 3) {
                                                          //Lead
                                                          homeProvider.topLeadPayments();
                                                          callNext(LeadReport(), context);
                                                        }
                                                        else if (index == 4) {
                                                          //Topper's\nClub
                                                          // callNext( DistrictReport(from: '',), context);
                                                          callNext( ToppersHomeScreen(), context);
                                                          // homeProvider.fetchTopWardReport();

                                                        }
                                                        else if (index == 5){
                                                          //Top\nVolunteers
                                                          homeProvider.getTopEnrollers();
                                                          callNext(const TopEnrollersScreen(), context);
                                                        }
                                                        else if (index == 6) {
                                                          //Volunteer\nRegistration
                                                          print("device click here");
                                                          HomeProvider homeProvider =
                                                          Provider.of<HomeProvider>(context, listen: false);
                                                          await homeProvider.checkEnrollerDeviceID();
                                                          if (value2.enrollerDeviceID) {
                                                            print("deviceid already exixt");
                                                            deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                          } else {
                                                            homeProvider.clearEnrollerData();
                                                            callNext(BeAnEnroller(), context);
                                                          }
                                                        }
                                                        else if (index == 7) {
                                                          //Volunteer\nPayments
                                                          print("clikk22334");
                                                          homeProvider.clearEnrollerDetails();
                                                          callNext(const EnrollerPaymentsScreen(), context);
                                                        }
                                                      },
                                                      child: Center(
                                                        child: Container(
                                                            padding: const EdgeInsets.all(0),
                                                            alignment: Alignment.center,
                                                            width: width * .20,
                                                            // height: 48,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(15)),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  decoration: const BoxDecoration(
                                                                    shape:BoxShape.circle,
                                                                    gradient: LinearGradient(
                                                                      begin: Alignment(0.00, -1.00),
                                                                      end: Alignment(0, 1),
                                                                      colors: [cl3655A2, cl264186],
                                                                    ),
                                                                  ),
                                                                  height: 55,
                                                                  child: Image.asset(
                                                                    contriImg[index],
                                                                    scale: 3,
                                                                  ),
                                                                ),
                                                                Container(
                                                                    alignment: Alignment.center,
                                                                    width: width,
                                                                    height: 35,
                                                                    // color:Colors.yellow,
                                                                    child: Text(
                                                                      contriText[index],
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle(
                                                                          fontFamily: "PoppinsMedium",
                                                                          fontSize: 11,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: cl3655A2
                                                                      ),
                                                                      overflow: TextOverflow.fade,
                                                                    )),

                                                              ],
                                                            )),
                                                      ),
                                                    );
                                                  });
                                            }),
                                      ),

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 10, 30,0),
                                            child: SizedBox(
                                                height: 0.15*height,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: 3,
                                                  scrollDirection: Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return InkWell(
                                                      onTap:(){
                                                        if(index==1){
                                                          alertTermsAndConditions(context);
                                                        }else if(index==2){
                                                          alertContact(context);
                                                        }else if(index==0){
                                                          alertTerm(context);
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right: 12.0,left: 12),
                                                        child: Column(
                                                            children: [
                                                              const CircleAvatar(
                                                            radius:30,
                                                            backgroundColor: clF8F8F8,
                                                            // child: Image.asset(
                                                            //   PTCImg[index],
                                                            //   scale: 3,
                                                            //   color: cl3655A2,
                                                            // ),
                                                          ),
                                                          const SizedBox(height: 8),
                                                          Text(
                                                            PTCText[index],
                                                            style: const TextStyle(
                                                                color: myBlack,
                                                                fontSize: 11,
                                                                fontFamily: "Lato",
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          ),
                                                          const SizedBox(height: 5),
                                                        ]),
                                                  ),
                                                );
                                              },
                                            )
                                        ),
                                      ),

                                      Consumer<HomeProvider>(builder: (context, value, child) {
                                        print("aaaaaaaaaaaaaaaa"+value.buildNumber);
                                        return Container(
                                          // color: myWhite,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),)),
                                        );
                                      }
                                      ),
                                      Container(
                                        // color: myWhite,
                                        height: 80,
                                      )
                                    ])),
                              ),
                            ),

                            Expanded(
                                flex:1,
                                child: Container(
                                  // color:Colors.green,
                                    child:Image.asset("assets/TvRight4x.png",fit: BoxFit.cover,)
                                )),
                          ],
                        ),
                      ),

                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return
                              value.isLaunched ?
                              Align(
                                alignment:Alignment.topRight ,
                                child:ConfettiWidget(
                                  gravity: .3,
                                  minBlastForce: 5, maxBlastForce: 800,
                                  numberOfParticles: 500,
                                  confettiController: controllerCenter,
                                  blastDirectionality: BlastDirectionality.explosive,
                                  // don't specify a direction, blast randomly
                                  //blastDirection: BorderSide.strokeAlignOutside,
                                  shouldLoop: true, // start again as soon as the animation is finished
                                  colors: const [
                                    Color(0xFFFFDF00),//Golden yellow
                                    Color(0xFFD4AF37),//Metallic gold
                                    Color(0xFFCFB53B),//Old gold
                                    Color(0xFFC5B358),//Old gold
                                    // Colors.green,
                                    // Colors.blue,
                                    // Colors.pink,
                                    // Colors.orange,
                                    // Colors.purple,
                                    // Colors.red,
                                    // Colors.greenAccent,
                                    // Colors.white,
                                    // Colors.lightGreen,
                                    // Colors.lightGreenAccent
                                  ], // manually specify the colors to be used
                                  createParticlePath: value.drawStar, // define a custom shape/path.
                                ),
                              )
                                  :const SizedBox();
                          }
                      ),

                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.isLaunched
                                ?Align(
                              alignment:Alignment.bottomLeft,
                              child: ConfettiWidget(
                                gravity: .3,
                                minBlastForce: 5, maxBlastForce: 800,
                                numberOfParticles: 500,
                                confettiController: controllerCenter,
                                blastDirectionality: BlastDirectionality.explosive,
                                shouldLoop: true,
                                colors: const [
                                  Color(0xFFFFDF00), //Golden yellow
                                  Color(0xFFD4AF37), //Metallic gold
                                  Color(0xFFCFB53B), //Old gold
                                  Color(0xFFC5B358), //Old gold
                                ], // manually specify the colors to be used
                                createParticlePath:
                                value.drawStar, // define a custom shape/path.
                              ),
                            ):const SizedBox();
                          }
                      ),
                    ],
                  ),
                ),

                ///old body singlechid ,dont remove it
                ///

                ///floating action button
                // floatingActionButton: Consumer<HomeProvider>(builder: (context, value, child) {
                //   return ((kIsWeb ||
                //       Platform.isAndroid
                //       || value.iosPaymentGateway == 'ON')
                //       &&!Platform.isIOS
                //   )
                //       ? Padding(
                //     padding: const EdgeInsets.only(left: 0.0, right: 2),
                //     child:
                //     InkWell(
                //       onTap: () {
                //         // homeProvider.testBase();
                //         mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                //           if (event.snapshot.value.toString() == 'ON') {
                //             DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                //             donationProvider.amountTC.text = "";
                //             donationProvider.nameTC.text = "";
                //             donationProvider.phoneTC.text = "";
                //             donationProvider.subCommitteeCT.text = "";
                //             donationProvider.kpccAmountController.text = "";
                //             donationProvider.onAmountChange('');
                //             donationProvider.clearGenderAndAgedata();
                //             donationProvider.selectedPanjayathChip = null;
                //             donationProvider.chipsetWardList.clear();
                //             donationProvider.selectedWard = null;'1';
                //             donationProvider.minimumbool=true;
                //             callNext(DonatePage(), context);
                //           } else {
                //             callNext(const NoPaymentGateway(), context);
                //           }
                //         });
                //       },
                //       child:
                //       // SizedBox(
                //       //   width: width * .900,
                //       //   child: SwipeableButtonView(
                //       //
                //       //     buttonText: 'Participate Now',
                //       //   buttontextstyle: const TextStyle(
                //       //     fontSize: 21,
                //       //       color: myWhite, fontWeight: FontWeight.bold
                //       //   ),
                //       //   //  buttonColor: Colors.yellow,
                //       //     buttonWidget: Container(
                //       //       child: const Icon(
                //       //         Icons.arrow_forward_ios_rounded,
                //       //         color: Colors.grey,
                //       //       ),
                //       //     ),
                //       //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                //       //
                //       //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                //       //     disableColor: Colors.purple,
                //       //
                //       //     isFinished: isFinished,
                //       //     onWaitingProcess: () {
                //       //       Future.delayed(const Duration(milliseconds: 10), () {
                //       //         setState(() {
                //       //           isFinished = true;
                //       //         });
                //       //       });
                //       //     },
                //       //     onFinish: () async {
                //       //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                //       //         if (event.snapshot.value.toString() == 'ON') {
                //       //           DonationProvider donationProvider =
                //       //           Provider.of<DonationProvider>(context,
                //       //               listen: false);
                //       //           donationProvider.amountTC.text = "";
                //       //           donationProvider.nameTC.text = "";
                //       //           donationProvider.phoneTC.text = "";
                //       //           donationProvider.kpccAmountController.text = "";
                //       //           donationProvider.onAmountChange('');
                //       //           donationProvider.clearGenderAndAgedata();
                //       //           donationProvider.selectedPanjayathChip = null;
                //       //           donationProvider.chipsetWardList.clear();
                //       //           donationProvider.selectedWard = null;
                //       //           '1';
                //       //
                //       //           callNext(DonatePage(), context);
                //       //         } else {
                //       //           callNext(const NoPaymentGateway(), context);
                //       //         }
                //       //       });
                //       //       setState(() {
                //       //         isFinished = false;
                //       //       });
                //       //     },
                //       //   ),
                //       // )
                //       ///
                //       Container(
                //         height: 50,
                //         width: width * .760,
                //         decoration:  BoxDecoration(
                //           boxShadow:  [
                //             const BoxShadow(
                //               color:cl3655A2,
                //             ),
                //             BoxShadow(
                //               color: cl000000.withOpacity(0.25),
                //               spreadRadius: -5.0,
                //               // blurStyle: BlurStyle.inner,
                //               blurRadius: 20.0,
                //             ),
                //
                //           ],
                //           borderRadius: const BorderRadius.all(Radius.circular(35)),
                //           gradient: const LinearGradient(
                //               begin: Alignment.centerLeft,
                //               end: Alignment.centerRight,
                //               colors: [cl3655A2,cl19A391]),
                //
                //         ),
                //         child: const Center(
                //             child: Text(
                //               "Participate Now",
                //               style: TextStyle(
                //                   fontSize: 18,
                //                   fontFamily: "PoppinsMedium",
                //                   color: myWhite, fontWeight: FontWeight.w500),
                //             )),
                //       ),
                //     ),
                //   )
                //       : const SizedBox();
                // }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TpcContainer(double width, String Ctext, String ImgTxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: width,
        decoration: const BoxDecoration(
          color: knmGradient5,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: knmGradient2,
                child: Image.asset(
                  ImgTxt,
                  height: 18,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                Ctext,
                style: const TextStyle(
                    color: knmGradient6,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Heebo"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildImage(var image, context,String type) {
    return Container(
      padding: const EdgeInsets.only(left: 10,right:10),
      //color:Colors.yellow,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child:type=="asset"?Image.asset(image, fit:BoxFit.fill): Image.network(image, fit:BoxFit.fill),
      ),
    );
  }

  buidIndiaCator(int count, BuildContext context) {
    int imgCount = count;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: imgCount,
          effect: const JumpingDotEffect(
              dotWidth: 7,
              dotHeight: 7,
              activeDotColor: myBlack,
              dotColor: Color(0xffaba17c)),
        ),
      ),
    );
  }

  ///exit function
  Future<bool> showExitPopup() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?"),
                  const SizedBox(height: 19),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: clC46F4E),
                          child: const Text("Yes",style: TextStyle(color:myWhite),),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text("No",
                                style: TextStyle(color: Colors.black)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<AlertDialog?> deviceIdAlreadyExistAlert(
      BuildContext context, String id,String name) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // insetPadding: EdgeInsets.symmetric(horizontal: 15),

              backgroundColor: Colors.white,
              // contentPadding: const EdgeInsets.only(
              //   top: 15.0,
              // ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              content: Consumer<HomeProvider>(
                  builder: (context, value, child) {
                return Container(
                    // width: 400,
                    // padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    // decoration: const BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius:
                    //     BorderRadius.vertical(bottom: Radius.circular(25))
                    // ),
                    child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "Already you are a volunteer",
                                      style: TextStyle(color: myBlack,fontFamily: "Poppins",fontSize: 16),
                                    ),
                                    const SizedBox(height: 15,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        //Name
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                "Name            : ",style: TextStyle(fontSize: 15,color: myBlack,)
                                            ),
                                            Flexible(
                                              fit:FlexFit.tight,
                                              child: Text(
                                                name,
                                                maxLines: 3,
                                                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: myBlack),

                                              ),
                                            ),
                                          ] ,
                                        ),

                                        const SizedBox(height: 5,),

                                        //Volunteer Id
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              const SizedBox(
                                                width:100,
                                                child: Text(
                                                    "Volunteer ID :",style: TextStyle(fontSize: 15,color: myBlack,)
                                                ),
                                              ),

                                              Flexible(
                                                fit:FlexFit.tight,
                                                child: InkWell(
                                                  onTap:(){
                                                    Clipboard.setData(new ClipboardData(text: id)).then((_){
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                        backgroundColor: myWhite,
                                                        content: Text("Copied ID !",style: TextStyle(color:myBlack),),
                                                      ));
                                                    });
                                                  },
                                                  child: Text(id,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: myBlack),
                                                  ),
                                                ),
                                              ),

                                              //copy id
                                              InkWell(
                                                onTap: (){
                                                  Clipboard.setData(ClipboardData(text:id)).then((_){
                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                      backgroundColor: myWhite,
                                                      content: Text("Copied ID !",style: TextStyle(color:myBlack),),
                                                    ));
                                                  });

                                                },
                                                child: const Text("CopyID",style: TextStyle(color: Colors.blue,fontSize: 14,decoration: TextDecoration.underline),),
                                                // const Icon(
                                                //   Icons.content_copy,
                                                //   color: myBlack,
                                                //   size: 25,
                                                // ),
                                              ),
                                            ]
                                        ),

                                        // RichText(
                                        //     text: TextSpan(
                                        //       children: [
                                        //         const TextSpan(
                                        //             text:"Volunteer ID : ",style: TextStyle(fontSize: 16,color: myBlack,)
                                        //         ),
                                        //         TextSpan(
                                        //           text:id,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: myBlack),
                                        //           recognizer: new TapGestureRecognizer()..onTap = (){
                                        //             Clipboard.setData(new ClipboardData(text: id)).then((_){
                                        //               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        //                 backgroundColor: myWhite,
                                        //                 content: Text("Copied ID !",style: TextStyle(color:myBlack),),
                                        //               ));
                                        //             });
                                        //           },
                                        //         ),
                                        //       ] ,
                                        //     )),

                                        const SizedBox(height: 5,),



                                      ],
                                    ),
                                  ],
                                ),
                            Consumer<HomeProvider>(
                                builder: (context, value3, child) {
                                  return InkWell(
                                    onTap: () {
                                      finish(context);
                                    },
                                    child: Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(35)),
                                            color: clC46F4E
                                            // gradient: LinearGradient(
                                            //     begin: Alignment.centerLeft,
                                            //     end: Alignment.centerRight,
                                            //     colors: [cl3655A2,cl19A391])
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                  );
                                }),
                          ]),
                        )));
              }));
        });
  }


  OutlineInputBorder border2 = OutlineInputBorder(
      borderSide: BorderSide(color: textfieldTxt.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(10));

}
String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
  formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}