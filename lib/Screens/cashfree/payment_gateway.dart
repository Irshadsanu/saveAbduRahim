import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/images.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../bank_payment_page.dart';
import '../district_report.dart';
import '../mindgate_payment_screen.dart';
import '../new_payment_gateway_Screen.dart';
import 'cashfree_upi.dart';

class PaymentGateway extends StatelessWidget {
  PaymentGateway({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    // homeProvider.checkInternet(context);
    DonationProvider donationProvider = Provider.of<DonationProvider>(
        context, listen: false);



    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }
  Widget body(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);

    return SingleChildScrollView(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),

          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Consumer<DonationProvider>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("₹",style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 38,
                              color:clC46F4E),),
                          Text(
                            value.kpccAmountController.text.toString(),
                            style: rupeeBig3,
                          ),
                        ],
                      );
                    }
                ),
              )),
          SizedBox(height:47,),
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 32),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: clF6F6F6),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 25),
                    child: Text(
                      'Select Payment Method',
                      style: black11,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<HomeProvider>(
                        builder: (context,value,child) {
                          return value.intentPaymentOption=="ON"?Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  String amount=donationProvider.kpccAmountController.text.toString();
                                  String name=donationProvider.nameTC.text;
                                  String phone=donationProvider.phoneTC.text;
                                  donationProvider.upiIntent(context, amount, name, phone,"GPay",homeProvider.appVersion.toString());
                                },
                                child: Container(
                                    width: 350,
                                    height: 61,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      border: Border.all(color: cl434343.withOpacity(0.4),width: 0.3)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset('assets/gpay2.png',scale: 12,),
                                        Text("Google Pay",style: black13,),
                                        Icon(Icons.arrow_forward_ios_sharp,color: myBlack,)
                                      ],
                                    )),
                              ),
                              // SizedBox(height: 20,),
                              // InkWell(
                              //   onTap: () {
                              //     String amount=donationProvider.kpccAmountController.text.toString();
                              //     String name=donationProvider.nameTC.text;
                              //     String phone=donationProvider.phoneTC.text;
                              //     donationProvider.upiIntent(context, amount, name, phone,"Paytm",homeProvider.appVersion.toString());
                              //   },
                              //   child:
                              //   Container(
                              //       width: width*.73,
                              //       height: 61,
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(15),
                              //           color: Colors.white
                              //
                              //       ),
                              //       child: Image.asset('assets/paytm.png',scale: 3,)),
                              // ),
                              SizedBox(height: 20,),

                              InkWell(
                                onTap: () {
                                  HomeProvider homeProvider =
                                  Provider.of<HomeProvider>(context, listen: false);
                                  String amount=donationProvider.kpccAmountController.text.toString();
                                  String name=donationProvider.nameTC.text;
                                  String phone=donationProvider.phoneTC.text;
                                  donationProvider.upiIntent(context, amount, name, phone,"BHIM",homeProvider.appVersion.toString());
                                },
                                child:
                                Container(
                                    width: 350,
                                    height: 61,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        border: Border.all(color: cl434343.withOpacity(0.4),width: 0.3)

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset('assets/bhim.png',scale: 3.3,),
                                        Text("Bhim",style: black13,),
                                        Icon(Icons.arrow_forward_ios_sharp,color: myBlack,)
                                      ],
                                    )
                                ),
                              ),

                            ],
                          ):SizedBox();
                        }
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.ccavenueAndroidPaymentOption=="ON"&&Platform.isAndroid?Column(
                              children: [
                                const SizedBox(height: 20,),

                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Choose Other Payment Method",
                                          style: TextStyle(color: Colors.black,fontFamily: "Poppins",fontSize: 15)),
                                    )),

                                const SizedBox(height: 10,),

                                Consumer<DonationProvider>(
                                    builder: (context,value,child) {
                                      return InkWell(
                                        onTap: (){
                                          final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
                                          mRoot.child(".info/connected").onValue.listen((event) {
                                            if (event.snapshot.value.toString() == "true") {
                                              HomeProvider homeProvider =
                                              Provider.of<HomeProvider>(context, listen: false);
                                              String amount=donationProvider.kpccAmountController.text.toString();
                                              // String amount = "1";
                                              String name=donationProvider.nameTC.text;
                                              String phone=donationProvider.phoneTC.text;




                                              donationProvider.apiCallCcavenue(context, donationProvider.transactionID.text, amount, name, phone);
                                              // donationProvider.listenForPayment(
                                              //     donationProvider.transactionID.text.toString(), context);
                                            }else{
                                              final snackBar = SnackBar(
                                                  backgroundColor:Colors.red ,
                                                  elevation:0,
                                                  duration: const Duration(milliseconds: 3000),
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const CupertinoActivityIndicator(color: myWhite,radius: 10,),
                                                      const SizedBox(width: 5,),
                                                      Text("Please Check your Internet...", textAlign: TextAlign.center,softWrap: true,
                                                        style: snackbarStyle,
                                                      ),
                                                    ],
                                                  ));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            }
                                          });





                                        },
                                        child: Card(
                                          margin: EdgeInsets.symmetric(horizontal: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            //set border radius more than 50% of height and width to make circle
                                          ),
                                          elevation: 2,
                                          color: Colors.white,

                                          child: Container(
                                            // height: 50,
                                            alignment: Alignment.center,
                                            decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Image.asset("assets/noun-wallet.png",scale: 18),
                                                      Image.asset("assets/noun-debit-cards.png",scale: 18,),
                                                      Image.asset("assets/noun-online-banking.png",scale: 18,),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      // value.razorPayLoader?CircularProgressIndicator(): Text(
                                                      //   'Other Upi Apps',
                                                      //   style: black16,
                                                      // ),
                                                      const SizedBox(width:10,),
                                                      Image.asset('assets/visa.png',scale: 19,),
                                                      const SizedBox(width:7,),
                                                      Image.asset('assets/Mastercard.png',scale: 100,),
                                                      const SizedBox(width:7,),
                                                      Image.asset('assets/rupay.png',scale: 19,),
                                                      const SizedBox(width:7,),
                                                      Image.asset('assets/gpay.png',scale:4,),
                                                      // const SizedBox(width:7,),
                                                      Image.asset('assets/paytm.png',scale: 4,),
                                                      Image.asset('assets/PhonepayIphone.png',scale: 3,),


                                                    ],
                                                  ),
                                                  SizedBox(height: 4,),
                                                  const Text("Click here",style: TextStyle(fontFamily: "Poppins"),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                ),

                              ],
                            ):const SizedBox();
                          }
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.razorpayAndroidPaymentOption=="ON"&&Platform.isAndroid?Column(
                              children: [
                                const SizedBox(height: 20,),

                                const Align(
                                  alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Choose Other Payment Method",
                                          style: TextStyle(color: Colors.black,fontFamily: "Poppins",fontSize: 15)),
                                    )),

                                const SizedBox(height: 10,),

                                Consumer<DonationProvider>(
                                    builder: (context,value,child) {
                                      return InkWell(
                                        onTap: (){
                                          final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
                                          mRoot.child(".info/connected").onValue.listen((event) {
                                            if (event.snapshot.value.toString() == "true") {
                                              HomeProvider homeProvider =
                                              Provider.of<HomeProvider>(context, listen: false);
                                              String amount=donationProvider.kpccAmountController.text.toString();
                                              // String amount = "1";
                                              String name=donationProvider.nameTC.text;
                                              String phone=donationProvider.phoneTC.text;

                                              donationProvider.razorPayGateway(donationProvider.transactionID.text,num.parse(amount),name,phone,"",context);
                                              // donationProvider.listenForPayment(
                                              //     donationProvider.transactionID.text.toString(), context);
                                            }else{
                                              final snackBar = SnackBar(
                                                  backgroundColor:Colors.red ,
                                                  elevation:0,
                                                  duration: const Duration(milliseconds: 3000),
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const CupertinoActivityIndicator(color: myWhite,radius: 10,),
                                                      const SizedBox(width: 5,),
                                                      Text("Please Check your Internet...", textAlign: TextAlign.center,softWrap: true,
                                                        style: snackbarStyle,
                                                      ),
                                                    ],
                                                  ));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            }
                                          });





                                        },
                                        child: Card(
                                          margin: EdgeInsets.symmetric(horizontal: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            //set border radius more than 50% of height and width to make circle
                                          ),
                                          elevation: 2,
                                          color: Colors.white,

                                          child: Container(
                                            // height: 50,
                                            alignment: Alignment.center,
                                            decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Image.asset("assets/noun-wallet.png",scale: 18),
                                                      Image.asset("assets/noun-debit-cards.png",scale: 18,),
                                                      Image.asset("assets/noun-online-banking.png",scale: 18,),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      // value.razorPayLoader?CircularProgressIndicator(): Text(
                                                      //   'Other Upi Apps',
                                                      //   style: black16,
                                                      // ),
                                                      const SizedBox(width:10,),
                                                      Image.asset('assets/visa.png',scale: 19,),
                                                      const SizedBox(width:7,),
                                                      Image.asset('assets/Mastercard.png',scale: 100,),
                                                      const SizedBox(width:7,),
                                                      Image.asset('assets/rupay.png',scale: 19,),
                                                      const SizedBox(width:7,),
                                                      Image.asset('assets/gpay.png',scale:4,),
                                                      // const SizedBox(width:7,),
                                                      Image.asset('assets/paytm.png',scale: 4,),
                                                      Image.asset('assets/PhonepayIphone.png',scale: 3,),


                                                    ],
                                                  ),
                                                  SizedBox(height: 4,),
                                                  const Text("Click here",style: TextStyle(fontFamily: "Poppins"),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                ),

                              ],
                            ):const SizedBox();
                          }
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.easyPayAndroidPaymentOption=="ON"&&Platform.isAndroid?Column(
                              children: [
                                const SizedBox(height: 20,),

                                const SizedBox(height: 20,),
                                Consumer<DonationProvider>(
                                    builder: (context,value,child) {
                                      return InkWell(
                                        onTap: (){
                                          final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
                                          mRoot.child(".info/connected").onValue.listen((event) {
                                            if (event.snapshot.value.toString() == "true") {
                                              HomeProvider homeProvider =
                                              Provider.of<HomeProvider>(context, listen: false);
                                              String amount=donationProvider.kpccAmountController.text.toString();
                                              // String amount = "1";
                                              String name=donationProvider.nameTC.text;
                                              String phone=donationProvider.phoneTC.text;

                                              donationProvider.eazypayGateway(donationProvider.transactionID.text, amount,"",context);
                                            }else{
                                              final snackBar = SnackBar(
                                                  backgroundColor:Colors.red ,
                                                  elevation:0,
                                                  duration: const Duration(milliseconds: 3000),
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const CupertinoActivityIndicator(color: myWhite,radius: 10,),
                                                      const SizedBox(width: 5,),
                                                      Text("Please Check your Internet...", textAlign: TextAlign.center,softWrap: true,
                                                        style: snackbarStyle,
                                                      ),
                                                    ],
                                                  ));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            }
                                          });





                                        },
                                        child: Card(

                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            //set border radius more than 50% of height and width to make circle
                                          ),
                                          elevation: 2,


                                          child: Container(
                                            height: 50,
                                            alignment: Alignment.center,

                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  value.easyPayLoader?CircularProgressIndicator(): Text(
                                                    'All Upi Apps',
                                                    style: black16,
                                                  ),
                                                  const SizedBox(width:10,),
                                                  Image.asset('assets/phonepay.png',scale: 5,),
                                                  const SizedBox(width:7,),
                                                  Image.asset(gpay,scale: 5),
                                                  const SizedBox(width:7,),
                                                  Image.asset(bhim,scale: 5),


                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                ),

                              ],
                            ):const SizedBox();
                          }
                      ),

                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.easyPayAndroidQrPaymentOption=="ON"&&Platform.isAndroid?Column(
                              children: [
                                const SizedBox(height: 20,),

                                const SizedBox(height: 20,),
                                Consumer<DonationProvider>(
                                    builder: (context,value,child) {
                                      return InkWell(
                                        onTap: (){
                                          final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
                                          mRoot.child(".info/connected").onValue.listen((event) {
                                            if (event.snapshot.value.toString() == "true") {
                                              HomeProvider homeProvider =
                                              Provider.of<HomeProvider>(context, listen: false);
                                              String amount=donationProvider.kpccAmountController.text.toString();
                                              // String amount = "1";
                                              String name=donationProvider.nameTC.text;
                                              String phone=donationProvider.phoneTC.text;

                                              donationProvider.eazypayGateway(donationProvider.transactionID.text, amount,"QR",context);
                                            }else{
                                              final snackBar = SnackBar(
                                                  backgroundColor:Colors.red ,
                                                  elevation:0,
                                                  duration: const Duration(milliseconds: 3000),
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const CupertinoActivityIndicator(color: myWhite,radius: 10,),
                                                      const SizedBox(width: 5,),
                                                      Text("Please Check your Internet...", textAlign: TextAlign.center,softWrap: true,
                                                        style: snackbarStyle,
                                                      ),
                                                    ],
                                                  ));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            }
                                          });






                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            //set border radius more than 50% of height and width to make circle
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [clC46F4F,clC46F4F]),
                                            ),
                                            height: 50,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 12),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // value.easyPayQrLoader?CircularProgressIndicator():Image.asset('assets/icon_qrcode.png'),

                                                  Text(
                                                    'Scan QR & Pay With Other UPI Apps',
                                                    style: black17,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                ),

                              ],
                            ):SizedBox();
                          }
                      ),
                      SizedBox(height: 5,),
                      Container(
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(
                              width: width/1.3,
                              child: Column(
                                children: [
                                  Text("Make payment and wait until you get confirmation.",style: TextStyle(fontSize: width/32.72),),
                                  // Text("പേയ്മെൻ്റ് നടത്തി സ്ഥിരീകരണം ലഭിക്കുന്നതുവരെ കാത്തിരിക്കുക",textAlign: TextAlign.center,style: TextStyle(fontSize: width/32.72, ),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                      width: 10, height: 10, child: CircularProgressIndicator())
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),










                    ],
                  ),
                ),


              ],
            ),
          ),








        ],
      ),
    );
  }
  

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:   PreferredSize(
          preferredSize: Size.fromHeight(84),

          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
            toolbarHeight: height*0.12,
            centerTitle: true,
            leading: InkWell(
              onTap: (){
                finish(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: myBlack,
                size: 20,
              ),
            ),
            title:   Text(
                "Participate Now",
                textAlign: TextAlign.center,
                style: wardAppbarTxt
            ),
            // flexibleSpace: Container(
            //   height: height*0.12,
            //   decoration: const BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(17),bottomRight:  Radius.circular(17))
            //
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 18.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         SizedBox(width: 33,),
            //         InkWell(
            //           onTap: (){
            //             finish(context);
            //           },
            //             child: const Icon(Icons.arrow_back_ios_outlined,color: cl264186)),
            //         // SizedBox(width: width*0.2,),
            //
            //         Padding(
            //           padding: const EdgeInsets.only(left: 22.0),
            //           child:  Text('Participate Now',style:wardAppbarTxt),
            //         ),
            //
            //       ],),
            //   ),
            // ),

          ),
        ),
        body: body(context),
      ),
    );
  }
  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    return Stack(
      children: [
        Row(
          children: [
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/KnmWebBacound1.jpg'),fit: BoxFit.cover
                  )
              ),
              child: Row(
                children: [
                  SizedBox(
                      height: height,
                      width: width / 3,
                      child: Image.asset("assets/Grou 2.png",scale: 4,)),
                  SizedBox(
                    height: height,
                    width: width / 3,
                  ),
                  SizedBox(
                      height: height,
                      width: width / 3,
                      child: Image.asset("assets/Grup 3.png",scale: 6,)),
                ],
              ),
            ),


          ],
        ),
        Center(child: queryData.orientation==Orientation.portrait?  Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: width/3,),
            SizedBox(width: width,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: myGreen,
                  centerTitle: true,
                  title: Text(
                    'Payment Method',
                    style: white18,
                  ),
                ),
                body: body(context),
              ),
            ),
            // SizedBox(width: width/3,),
          ],
        ):
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: width/3,),
            SizedBox(width: width/3,
              child: Scaffold(

                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: myGreen,
                  centerTitle: true,
                  title: Text(
                    'Payment Method',
                    style: white18,
                  ),
                ),
                body: body(context),
              ),
            ),
            // SizedBox(width: width/3,),
          ],
        ),)
      ],
    );
  }


  void showLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
          Center(
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
              ),
            ),
          ),
    );
  }
  Future<void> _launchUrlUPI(BuildContext context, Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    } else {
      // callNext(PaymentGateway(), context);

    }
  }

}