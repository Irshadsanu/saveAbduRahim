import 'package:bloodmoney/Screens/poster_page.dart';
import 'package:bloodmoney/Screens/quotaCompletedScreen.dart';
import 'package:bloodmoney/Screens/reciept_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/panjayath_model.dart';
import '../Views/receipt_list_model.dart';
import '../Views/ward_model.dart';
import 'home.dart';
import 'home_screen.dart';
import 'organizations_collected_report.dart';

class ReceiptListPage extends StatelessWidget {
  String from;
  String total;
  String state;
  String district;
  String assembly;
  String target;
  ReceiptListPage(
      {Key? key,
      required this.from,
      required this.total,
      required this.state,
      required this.district,
      required this.assembly,
      required this.target})
      : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    print(from+' DJND');
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    // homeProvider.checkInternet(context);
    Future.delayed(Duration.zero, () async {
      SharedPreferences userPreference = await SharedPreferences.getInstance();
      if (userPreference.getString("AlertShowed") == null) {
        aboutReceiptAlert(context);
      }
      userPreference.setString("AlertShowed", "AlertShowed");
    });
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
      // return mobile(context);
    }
  }

  Widget body(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    var height = queryData.size.height;
    var width = queryData.size.width;
    homeProvider.checkStarRating();

    return SizedBox(
      height: double.maxFinite,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          from == 'home'
              ? SizedBox(
                  height: 65,
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: clD4D4D4, width: 0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Consumer<HomeProvider>(
                        builder: (context, value, child) {
                      return TextField(
                        controller: value.searchEt,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 13, fontFamily: "Poppins"),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Search Mobile/Transaction ID',
                          hintStyle: const TextStyle(
                              fontSize: 11, fontFamily: "Poppins"),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: clD4D4D4, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: clD4D4D4, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: InkWell(
                              onTap: () {
                                homeProvider.searchPayments(
                                    value.searchEt.text, context);
                              },
                              child: const Icon(
                                Icons.search,
                                color: clC46F4E,
                              )),
                        ),
                        onChanged: (item) {
                          if (item.isEmpty) {
                            if (from == "home") {
                              homeProvider.currentLimit = 50;
                              homeProvider.fetchReceiptList(50);
                            }
                          }
                        },
                      );
                    }),
                  ),
                )
              : Column(
                  children: [
                    // Consumer<HomeProvider>(builder: (context, value, child) {
                    //   // print(num.parse(target).toString() +
                    //   //     value.wardTotal.toString() +
                    //   //     "sdfuhbds");
                    //   return Column(
                    //     children: [
                    //       SizedBox(
                    //         width: MediaQuery.of(context).size.width,
                    //         child: Consumer<HomeProvider>(
                    //             builder: (context, value2, child) {
                    //           return Column(
                    //             children: [
                    //
                    //               const SizedBox(height: 15),
                    //               district == "FAMILY CONTRIBUTION"
                    //                   ? const SizedBox()
                    //                   : Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       children: [
                    //                         const Text(
                    //                           "Ward Quota :",
                    //                           style: TextStyle(
                    //                               fontSize: 19,
                    //                               fontWeight: FontWeight.w500,
                    //                               color: Color(0xff5C5C5C)),
                    //                         ),
                    //                         const SizedBox(
                    //                           width: 7,
                    //                         ),
                    //                         Text(
                    //                           "₹ " + target,
                    //                           style: const TextStyle(
                    //                               fontSize: 19,
                    //                               fontWeight: FontWeight.w600,
                    //                               color: myBlack),
                    //                         )
                    //                       ],
                    //                     ),
                    //
                    //               /// 2024 asif commented
                    //
                    //               district!="FAMILY CONTRIBUTION" && value2.wardTotal>=num.parse(target) ?
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   Image.asset(
                    //                     "assets/image 1.png",
                    //                     height: 22,
                    //                     width: 22,
                    //                   ),
                    //                   const SizedBox(
                    //                     width: 6,
                    //                   ),
                    //                   const Padding(
                    //                     padding: EdgeInsets.only(
                    //                       top: 5,
                    //                     ),
                    //                     child: Text(
                    //                       "Quota Completed !!",
                    //                       style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    //                     ),
                    //                   ),
                    //                   const SizedBox(width: 15),
                    //                   ElevatedButton(
                    //                       onPressed: () {
                    //                         DonationProvider donationProvider =
                    //                         Provider.of<DonationProvider>(context, listen: false);
                    //                         donationProvider.whatsappStatus =
                    //                         null;
                    //                         // callNext(
                    //                         //     QuotaCompletedScreen(
                    //                         //
                    //                         //       district: district,
                    //                         //       panchayath: panchayath,
                    //                         //       ward: ward,
                    //                         //     ),
                    //                         //     context);
                    //
                    //                       },
                    //                       style: ElevatedButton.styleFrom(
                    //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), backgroundColor: Colors.transparent,
                    //                         // backgroundColor:  Color(0xff02A710),
                    //                         disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                    //                         shadowColor: Colors.transparent,
                    //                         minimumSize: const Size(136, 30),
                    //                       ),
                    //                       child: const Text(
                    //                         "Download Poster",
                    //                         style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    //                       ))
                    //                 ],
                    //               ):
                    //               district!="FAMILY CONTRIBUTION"?const Padding(
                    //                 padding: EdgeInsets.only(top: 8.0),
                    //                 child: Text("Quota not Completed yet"),
                    //               ):const SizedBox()
                    //
                    //               /// 2024 asif commented
                    //             ],
                    //           );
                    //         }),
                    //       ),
                    //       // SizedBox(height: 15,),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           /// 2024 asif commented
                    //
                    //           value.wardTotal >= 100000 && district!="FAMILY CONTRIBUTION"&&district!="OTHER"
                    //               ? Padding(
                    //             padding:
                    //             const EdgeInsets.only(right: 12.0,top: 10),
                    //             child: InkWell(
                    //               onTap: () {
                    //                 DonationProvider donationProvider =
                    //                 Provider.of<DonationProvider>(
                    //                     context,
                    //                     listen: false);
                    //                 donationProvider.whatsappStatus =
                    //                 null;
                    //                 // callNext(
                    //                 //     PosterPageScreen(
                    //                 //       amount: value.wardTotal,
                    //                 //       district: district,
                    //                 //       panchayath: panchayath,
                    //                 //       ward: ward,
                    //                 //     ),
                    //                 //     context);
                    //               },
                    //               child: Container(
                    //                 height: 30,
                    //                 width: 120,
                    //                 decoration: BoxDecoration(
                    //                   boxShadow: [
                    //                     const BoxShadow(
                    //                       color: cl323A71,
                    //                     ),
                    //                     BoxShadow(
                    //                       color:
                    //                       cl000000.withOpacity(0.25),
                    //                       spreadRadius: -5.0,
                    //                       blurRadius: 20.0,
                    //                     ),
                    //                   ],
                    //                   borderRadius:
                    //                   const BorderRadius.all(
                    //                       Radius.circular(35)),
                    //                   gradient: const LinearGradient(
                    //                       begin: Alignment.centerLeft,
                    //                       end: Alignment.centerRight,
                    //                       colors: [cl323A71, cl1177BB]),
                    //                 ),
                    //                 child: const Center(
                    //                     child: Text(
                    //                       'Get Poster',
                    //                       style:
                    //                       TextStyle(color: Colors.white),
                    //                     )),
                    //               ),
                    //             ),
                    //           )
                    //               : const SizedBox(),
                    //
                    //           /// 2024 asif commented
                    //         ],
                    //       ),
                    //       const SizedBox(
                    //         height: 15,
                    //       ),
                    //     ],
                    //   );
                    // }),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 84,
                        width: 345,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 22),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/homeAmount_bgrnd.png"),
                                fit: BoxFit.fill)),
                        // elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount :  ',
                                    style: green16,
                                  ),
                                  // Image.asset(
                                  //   "assets/rs.png",
                                  //   scale: 5,
                                  //   color: myGreen,
                                  // ),
                                  const SizedBox(width: 15),
                                  Consumer<HomeProvider>(
                                      builder: (context, value, child) {
                                    return Text(
                                      value.assemblyReceiptTotal.toStringAsFixed(2),
                                      style: green16,
                                    );
                                  }),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Transactions :  ',
                                    style: green16,
                                  ),
                                  const SizedBox(width: 3),
                                  Consumer<HomeProvider>(
                                      builder: (context, value, child) {
                                    return Text(
                                      value.assemblyTotalTransactionsCount
                                          .toStringAsFixed(0),
                                      style: green16,
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

          Expanded(
            child: Container(
              // color: Colors.red,
              //elevation: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
              borderRadius:   BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Consumer<DonationProvider>(
                    //     builder: (context,value,child) {
                    //       return ListView.builder(
                    //           shrinkWrap: true,
                    //           itemCount: value.organizationCollected.length,
                    //           physics: const NeverScrollableScrollPhysics(),
                    //           itemBuilder: (BuildContext context, int index) {
                    //             var item = value.organizationCollected[index];
                    //             return Padding(
                    //               padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                    //               child: Container(
                    //                 padding: EdgeInsets.symmetric(horizontal: 10),
                    //                 height: 50,width: width,
                    //                 decoration: BoxDecoration(
                    //                   color: myWhite,
                    //                   borderRadius: BorderRadius.circular(15),
                    //                   boxShadow: const [
                    //                     BoxShadow(
                    //                       color: c_Grey,
                    //                       blurRadius: 1, // soften the shadow
                    //                     )
                    //                   ],
                    //                 ),
                    //                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Text(item.name,style: TextStyle(
                    //                         color: cl264186,
                    //                         fontSize: 15,
                    //                         fontWeight: FontWeight.w700,
                    //                         fontFamily: "PoppinsMedium"
                    //                     ),),
                    //                     Text(item.collected,style: TextStyle(
                    //                       color:myBlack,
                    //                       fontSize:15,
                    //                         fontWeight: FontWeight.w700,
                    //                         fontFamily: "PoppinsMedium"
                    //                     ),),
                    //                   ],
                    //                 ),
                    //               ),
                    //             );
                    //           });
                    //     }
                    // ),

                   from=='WardPage'?
                    Consumer<DonationProvider>(
                        builder: (context, value, child) {
                      return GridView.builder(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.organizationCollected.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 50,
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            var item = value.organizationCollected[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              width: width,
                              decoration: BoxDecoration(
                                // color: c_Grey.withOpacity(0.30),
                                color: myWhite,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow:  [
                                  BoxShadow(
                                    color: c_Grey.withOpacity(0.10),
                                    spreadRadius: 2,
                                    blurRadius: 0.2, // soften the shadow
                                  )
                                ],
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                      color: Color(0xff5C5C5C),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "PoppinsMedium"),
                                ),
                                Text(
                                  item.collected,
                                  style: const TextStyle(
                                      color: cl264186,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "PoppinsMedium"),
                                ),
                              ]),
                            );
                          });
                    }):const SizedBox(),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Text(
                                'Details',
                                style: receipt_AmountDetailse,
                              )),
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Text(
                                    'Amount',
                                    style: receipt_AmountDetailse,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),

                    Consumer<HomeProvider>(builder: (context, value, child) {
                      return queryData.orientation == Orientation.portrait
                          ? ListView.builder(
                              itemCount: value.paymentDetailsList.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var item = value.paymentDetailsList[index];

                                return Visibility(
                                  visible:item.status == "Success" ,
                                  child: Padding(
                                    padding:  const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: item.status == "Success"
                                            ? clFFFFFF
                                            : myfailed,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:clE6E6E6,width: 0.2),
                                        boxShadow:  [
                                          BoxShadow(
                                            color: cl000000.withOpacity(0.05),
                                            blurRadius: 4,
                                            offset: const Offset(0, 3),
                                            spreadRadius: 0// soften the shadow
                                          )
                                        ],
                                      ),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 8,),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: width / 4.5,
                                                              child: Text(
                                                                'Name',
                                                                style:receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width / 25,
                                                                child: const Text(
                                                                    ':')),
                                                            SizedBox(
                                                              width: width / 2.7,
                                                              child:
                                                                  item.nameStatus ==
                                                                          "NO"
                                                                      ? Text(
                                                                          "Confidential Donor",
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              receiptName,
                                                                        )
                                                                      : Text(
                                                                          item.name,
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              receiptName,
                                                                        ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: width / 4.5,
                                                              child: Text(
                                                                'State',
                                                                style:
                                                                    receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width / 25,
                                                                child: const Text(
                                                                    ':')),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3.0),
                                                              child: SizedBox(
                                                                width:
                                                                    width / 2.7,
                                                                child: Text(
                                                                  item.state,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style:
                                                                      receiptNDMU2,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: width / 4.5,
                                                              child: Text(
                                                                'District',
                                                                style:
                                                                    receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width / 25,
                                                                child: const Text(
                                                                    ':')),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3.0),
                                                              child: SizedBox(
                                                                width:
                                                                    width / 2.7,
                                                                child: Text(
                                                                  item.district,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      receiptNDMU2,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: width / 4.5,
                                                              child: Text(
                                                                'Assembly',
                                                                style:
                                                                    receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width / 25,
                                                                child: const Text(
                                                                    ':')),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3.0),
                                                              child: SizedBox(
                                                                width:
                                                                    width / 2.7,
                                                                child: Text(
                                                                  item.assembly,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      receiptNDMU2,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   crossAxisAlignment:
                                                        //       CrossAxisAlignment
                                                        //           .start,
                                                        //   children: [
                                                        //     SizedBox(
                                                        //       width: width / 4.5,
                                                        //       child: Text(
                                                        //         'Panchayath',
                                                        //         style:
                                                        //             receiptNDMU,
                                                        //       ),
                                                        //     ),
                                                        //     SizedBox(
                                                        //         width: width / 25,
                                                        //         child: const Text(
                                                        //             ':')),
                                                        //     Padding(
                                                        //       padding:
                                                        //           const EdgeInsets
                                                        //                   .only(
                                                        //               top: 3.0),
                                                        //       child: SizedBox(
                                                        //         width:
                                                        //             width / 2.7,
                                                        //         child: Text(
                                                        //           item.panchayath,
                                                        //           maxLines: 2,
                                                        //           overflow:
                                                        //               TextOverflow
                                                        //                   .ellipsis,
                                                        //           style:
                                                        //               receiptNDMU2,
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        // Row(
                                                        //   crossAxisAlignment:
                                                        //       CrossAxisAlignment
                                                        //           .start,
                                                        //   children: [
                                                        //     SizedBox(
                                                        //       width: width / 4.5,
                                                        //       child: Text(
                                                        //         'Unit',
                                                        //         style:
                                                        //             receiptNDMU,
                                                        //       ),
                                                        //     ),
                                                        //     SizedBox(
                                                        //         width: width / 25,
                                                        //         child: const Text(
                                                        //             ':')),
                                                        //     Padding(
                                                        //       padding:
                                                        //           const EdgeInsets
                                                        //                   .only(
                                                        //               top: 3.0),
                                                        //       child: SizedBox(
                                                        //         width:
                                                        //             width / 2.7,
                                                        //         child: Text(
                                                        //           item.wardName,
                                                        //           maxLines: 2,
                                                        //           overflow:
                                                        //               TextOverflow
                                                        //                   .ellipsis,
                                                        //           style:
                                                        //               receiptNDMU2,
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),

                                                        // Row(
                                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                                        //   children: [
                                                        //     SizedBox(
                                                        //       width: width/4.9,
                                                        //       child: Text('Booth',style: receiptNDMU,
                                                        //       ),
                                                        //     ),
                                                        //     SizedBox(
                                                        //         width: width/25,
                                                        //         child: const Text(':')
                                                        //     ),
                                                        //     SizedBox(
                                                        //       width: width/2.7,
                                                        //       child: Text(item.booth,
                                                        //         maxLines: 2,
                                                        //         overflow: TextOverflow.ellipsis,
                                                        //         style: receiptNDMU2,),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        item.enroller == "NILL"
                                                            ? const SizedBox()
                                                            : Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: width /
                                                                        4.5,
                                                                    child: Text(
                                                                      'Volunteer',
                                                                      style:
                                                                          receiptNDMU,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          width /
                                                                              25,
                                                                      child:
                                                                          const Text(
                                                                              ':')),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 3.0),
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          width /
                                                                              2.7,
                                                                      child: Text(
                                                                        item.enroller,
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style:
                                                                            receiptNDMU2,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    )),
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "₹",
                                                        style: TextStyle(
                                                            color: clC46F4E,
                                                            fontSize: 18),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          "${item.amount.split(".").first}",
                                                          style: black141,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  flex: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  getDate(item.time),
                                                  style: receipt_DT,
                                                ),

                                                Row(
                                                  children: [
                                                    if (from == "home")
                                                      item.status == "Success"
                                                          ? Padding(
                                                        padding: const EdgeInsets.only(bottom: 10),
                                                        // value.receiptPinWard == 'ON'
                                                        //     ? InkWell(
                                                        //   onTap: () {
                                                        //     DonationProvider
                                                        //     donationProvider =
                                                        //     Provider.of<DonationProvider>(context, listen: false);
                                                        //     donationProvider.transactionID.clear();
                                                        //     showPinWardAlert(context, item);
                                                        //   },
                                                        //   child: Container(
                                                        //       alignment: Alignment.center,
                                                        //       width: width * .320,
                                                        //       height: 30,
                                                        //       decoration: const BoxDecoration(
                                                        //         color:clC46F4E,
                                                        //         image: DecorationImage(image: AssetImage("assets/historybgrnd.png"),fit: BoxFit.fill),
                                                        //         borderRadius: BorderRadius.all(
                                                        //           Radius.circular(15),
                                                        //         ),
                                                        //       ),
                                                        //       child: Text(
                                                        //         'Change Assembly',
                                                        //         style: changeCG,
                                                        //       )),
                                                        // )
                                                        //     : SizedBox(
                                                        //   width:
                                                        //   width * .385,
                                                        // ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            DonationProvider
                                                            donationProvider =
                                                            Provider.of<DonationProvider>(context, listen: false);
                                                            donationProvider.getSharedPrefName();
                                                            if (item.paymentApp ==
                                                                'Bank' &&
                                                                item.name ==
                                                                    'No Name') {
                                                              showReceiptAlert(
                                                                  context, item);
                                                            } else {
                                                              print(
                                                                  "receipt click here");
                                                              DonationProvider
                                                              donationProvider =
                                                              Provider.of<
                                                                  DonationProvider>(
                                                                  context,
                                                                  listen:
                                                                  false);
                                                              donationProvider
                                                                  .getDonationDetailsForReceipt(
                                                                  item.id);
                                                              // donationProvider.fetchDonationDetails(item.id);
                                                              // donationProvider.receiptSuccessStatus(item.id);

                                                              callNext(
                                                                  ReceiptPage(
                                                                    nameStatus: item.nameStatus == 'YES' ? "YES" : "NO",
                                                                  ),
                                                                  context);
                                                            }
                                                          },
                                                          child: Container(
                                                              alignment: Alignment.center,
                                                              width: width * .320,
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                image: const DecorationImage(image: AssetImage("assets/historybgrnd.png"),fit: BoxFit.fill),
                                                                borderRadius: BorderRadius.circular(15),
                                                                color:clC46F4E,
                                                              ),
                                                              child: Text(
                                                                'Receipt',
                                                                style: receiptCG,
                                                              )),
                                                        ),
                                                      )
                                                          : const SizedBox()
                                                    else
                                                      const SizedBox(),
                                                    homeProvider.kpccMonitor
                                                        ? Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            launch(
                                                              "tel://${item.phoneNumber}",);
                                                          },
                                                          child: Container(
                                                              alignment:
                                                              Alignment.center,
                                                              width: width * .385,
                                                              height: 35,
                                                              decoration: const BoxDecoration(
                                                                  color: myDarkBlue,
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                      bottomLeft:
                                                                      Radius.circular(
                                                                          10))),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  const Icon(
                                                                    Icons.call,
                                                                    color: myWhite,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    'Call',
                                                                    style: knmTerms3,
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            launch(
                                                                "whatsapp://send?phone=${"+91" + item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                          },
                                                          child: Container(
                                                              alignment:
                                                              Alignment.center,
                                                              width: width * .385,
                                                              height: 35,
                                                              decoration: const BoxDecoration(
                                                                  color: myDarkBlue,
                                                                  borderRadius:
                                                                  BorderRadius.only(
                                                                      bottomRight:
                                                                      Radius.circular(
                                                                          10))),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  const Icon(
                                                                    Icons.phone,
                                                                    color: myWhite,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    'WhatsApp',
                                                                    style: knmTerms3,
                                                                  ),
                                                                ],
                                                              )
                                                            // child: Text('WhatsApp',style: knmTerms3,)
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                        : const SizedBox(),
                                                  ],
                                                )

                                              ],
                                            ),
                                          )

                                          // Container(
                                          //     alignment: Alignment.center,
                                          //     width: width,
                                          //     height: 6,
                                          // color: myWhite,)
                                          //  const SizedBox(height: 10)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : SizedBox(
                              width: width * .30,
                              // color:Colors.yellow,
                              child: ListView.builder(
                                  itemCount: value.paymentDetailsList.length,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var item = value.paymentDetailsList[index];
                                    print(item.status+"wisesssq");
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 5),
                                      child: Container(
                                        height: height * 0.25,
                                        decoration: BoxDecoration(
                                          color: item.status == "Success"
                                              ? myWhite
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius:
                                                  3, // soften the shadow
                                            )
                                          ],
                                        ),
                                        // color: const Color(0xffF2EADD),

                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0, top: 4),
                                              child: Text(
                                                getDate(item.time),
                                                style: receipt_DT,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // from != "home"
                                                  //     ? SizedBox(
                                                  //         child: Text(
                                                  //           (index + 1).toString(),
                                                  //           style: black14,
                                                  //         ),
                                                  //         width: 40,
                                                  //       )
                                                  //     : const SizedBox(),

                                                  Expanded(
                                                      flex: 3,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    width / 17,
                                                                child: Text(
                                                                  'Name',
                                                                  style:
                                                                      receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width /
                                                                      25,
                                                                  child:
                                                                      const Text(
                                                                          ':')),
                                                              SizedBox(
                                                                width:
                                                                    width / 12,
                                                                child: Text(
                                                                  item.name,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      receiptNDMU2,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    width / 17,
                                                                child: Text(
                                                                  'District',
                                                                  style:
                                                                      receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width /
                                                                      25,
                                                                  child:
                                                                      const Text(
                                                                          ':')),
                                                              SizedBox(
                                                                width:
                                                                    width / 12,
                                                                child: Text(
                                                                  item.district,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      receiptNDMU2,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    width / 17,
                                                                child: Text(
                                                                  'Assembly',
                                                                  style:
                                                                      receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width /
                                                                      25,
                                                                  child:
                                                                      const Text(
                                                                          ':')),
                                                              SizedBox(
                                                                width:
                                                                    width / 12,
                                                                child: Text(
                                                                  item.assembly,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      receiptNDMU2,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // Row(
                                                          //   crossAxisAlignment:
                                                          //       CrossAxisAlignment
                                                          //           .start,
                                                          //   children: [
                                                          //     SizedBox(
                                                          //       width:
                                                          //           width / 17,
                                                          //       child: Text(
                                                          //         'Panchayath',
                                                          //         style:
                                                          //             receiptNDMU,
                                                          //       ),
                                                          //     ),
                                                          //     SizedBox(
                                                          //         width: width /
                                                          //             25,
                                                          //         child:
                                                          //             const Text(
                                                          //                 ':')),
                                                          //     SizedBox(
                                                          //       width:
                                                          //           width / 12,
                                                          //       child: Text(
                                                          //         item.panchayath,
                                                          //         maxLines: 2,
                                                          //         overflow:
                                                          //             TextOverflow
                                                          //                 .ellipsis,
                                                          //         style:
                                                          //             receiptNDMU2,
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          // Row(
                                                          //   crossAxisAlignment:
                                                          //       CrossAxisAlignment
                                                          //           .start,
                                                          //   children: [
                                                          //     SizedBox(
                                                          //       width:
                                                          //           width / 17,
                                                          //       child: Text(
                                                          //         'Unit',
                                                          //         style:
                                                          //             receiptNDMU,
                                                          //       ),
                                                          //     ),
                                                          //     SizedBox(
                                                          //         width: width /
                                                          //             25,
                                                          //         child:
                                                          //             const Text(
                                                          //                 ':')),
                                                          //     SizedBox(
                                                          //       width:
                                                          //           width / 12,
                                                          //       child: Text(
                                                          //         item.wardName,
                                                          //         maxLines: 2,
                                                          //         overflow:
                                                          //             TextOverflow
                                                          //                 .ellipsis,
                                                          //         style:
                                                          //             receiptNDMU2,
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),

                                                          // Text(
                                                          //   value.historyList
                                                          //           .map(
                                                          //               (item) => item.id)
                                                          //           .contains(item.id)
                                                          //       ? item.id
                                                          //       : getName(item),
                                                          //   style: black14,
                                                          // ),
                                                          // Text(
                                                          //   '${item.ward},${item.panchayath}\n${item.district}',
                                                          //   style: black14,
                                                          // ),
                                                          // Text(
                                                          //   getDate(item.time),
                                                          //   style: green14N,
                                                          // ),
                                                        ],
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                      )),
                                                  SizedBox(
                                                    width: width * 0.02,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      //item.name,
                                                      " ₹ ${item.amount.split(".").first}",
                                                      style: black141,
                                                    ),
                                                    flex: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),

                                            if (from == "home")
                                              item.status == "Success"
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        value.receiptPinWard ==
                                                                'ON'
                                                            ? InkWell(
                                                                onTap: () {
                                                                  DonationProvider
                                                                      donationProvider =
                                                                      Provider.of<
                                                                              DonationProvider>(
                                                                          context,
                                                                          listen:
                                                                              false);
                                                                  donationProvider
                                                                      .transactionID
                                                                      .clear();
                                                                  showPinWardAlert(
                                                                      context,
                                                                      item);
                                                                },
                                                                child:
                                                                    Container(
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        width: width *
                                                                            .12,
                                                                        height:
                                                                            30,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                40),
                                                                            gradient:
                                                                                const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                                                              secondary,
                                                                              primary
                                                                            ])),
                                                                        child:
                                                                            Text(
                                                                          'Change Unit',
                                                                          style:
                                                                              receiptCG,
                                                                        )),
                                                              )
                                                            : SizedBox(
                                                                width: width *
                                                                    .385,
                                                              ),

                                                        InkWell(
                                                          onTap: () {
                                                            DonationProvider
                                                                donationProvider =
                                                                Provider.of<
                                                                        DonationProvider>(
                                                                    context,
                                                                    listen:
                                                                        false);
                                                            donationProvider
                                                                .getSharedPrefName();
                                                            if (item.paymentApp ==
                                                                    'Bank' &&
                                                                item.name ==
                                                                    'No Name') {
                                                              showReceiptAlert(
                                                                  context,
                                                                  item);
                                                            } else {
                                                              DonationProvider
                                                                  donationProvider =
                                                                  Provider.of<
                                                                          DonationProvider>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              donationProvider
                                                                  .getDonationDetailsForReceipt(
                                                                      item.id);
                                                              donationProvider
                                                                  .receiptSuccessStatus(
                                                                      item.id);

                                                              callNext(
                                                                  ReceiptPage(
                                                                    nameStatus: item.nameStatus ==
                                                                            'YES'
                                                                        ? "YES"
                                                                        : "NO",
                                                                  ),
                                                                  context);
                                                            }
                                                          },
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width:
                                                                  width * .12,
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              40),
                                                                  gradient: const LinearGradient(
                                                                      begin: Alignment
                                                                          .centerLeft,
                                                                      end: Alignment.centerRight,
                                                                      colors: [
                                                                        secondary,
                                                                        primary
                                                                      ])),
                                                              child: Text(
                                                                'Receipt',
                                                                style:
                                                                    receiptCG,
                                                              )),
                                                        ),

                                                        //get reciept

                                                        // InkWell(
                                                        //   onTap: () {
                                                        //     DonationProvider
                                                        //         donationProvider =
                                                        //         Provider.of<
                                                        //                 DonationProvider>(
                                                        //             context,
                                                        //             listen: false);
                                                        //     donationProvider
                                                        //         .getSharedPrefName();
                                                        //     if (item.paymentApp ==
                                                        //             'Bank' &&
                                                        //         item.name ==
                                                        //             'No Name') {
                                                        //       showReceiptAlert(
                                                        //           context, item);
                                                        //     } else {
                                                        //       DonationProvider
                                                        //           donationProvider =
                                                        //           Provider.of<
                                                        //                   DonationProvider>(
                                                        //               context,
                                                        //               listen: false);
                                                        //       donationProvider
                                                        //           .fetchDonationDetails(
                                                        //               item.id);
                                                        //       donationProvider.receiptSuccessStatus(item.id);
                                                        //
                                                        //       callNext(ReceiptPage(),
                                                        //           context);
                                                        //     }
                                                        //   },
                                                        //   child: Container(
                                                        //     decoration: BoxDecoration(
                                                        //       gradient: const LinearGradient(
                                                        //           begin: Alignment
                                                        //               .topLeft,
                                                        //           end: Alignment
                                                        //               .bottomRight,
                                                        //           colors: [
                                                        //             myGradient1,
                                                        //             myGradient2
                                                        //           ]),
                                                        //       borderRadius:
                                                        //           BorderRadius
                                                        //               .circular(5),
                                                        //     ),
                                                        //     width: 110,
                                                        //     height: 45,
                                                        //     alignment:
                                                        //         Alignment.center,
                                                        //     child: Text(
                                                        //       'Get Receipt',
                                                        //       style: whitePoppinsBoldM15,
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        // const SizedBox(
                                                        //   width: 5,
                                                        // ),
                                                        // value.receiptPinWard=='ON'
                                                        //     ?InkWell(
                                                        //   onTap: () {
                                                        //     showPinWardAlert(
                                                        //         context, item);
                                                        //   },
                                                        //   child: Container(
                                                        //     decoration: BoxDecoration(
                                                        //       gradient: const LinearGradient(
                                                        //           begin: Alignment
                                                        //               .topLeft,
                                                        //           end: Alignment
                                                        //               .bottomRight,
                                                        //           colors: [
                                                        //             myGradient1,
                                                        //             myGradient2
                                                        //           ]),
                                                        //       borderRadius:
                                                        //           BorderRadius
                                                        //               .circular(5),
                                                        //     ),
                                                        //     width: 110,
                                                        //     height: 45,
                                                        //     alignment:
                                                        //         Alignment.center,
                                                        //     child: Text(
                                                        //       'Pin Ward',
                                                        //       style: whitePoppinsBoldM15,
                                                        //     ),
                                                        //   ),
                                                        // )
                                                        //     :const SizedBox(),
                                                        // const SizedBox(
                                                        //   width: 5,
                                                        // ),
                                                      ],
                                                    )
                                                  : const SizedBox()
                                            else
                                              const SizedBox(),
                                            homeProvider.kpccMonitor
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          launch(
                                                              "tel://${item.phoneNumber}");
                                                        },
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: width * .385,
                                                            height: 35,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green
                                                                    .withOpacity(
                                                                        0.7),
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10))),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const Icon(
                                                                  Icons.call,
                                                                  color:
                                                                      myWhite,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'Call',
                                                                  style:
                                                                      knmTerms3,
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          launch(
                                                              "whatsapp://send?phone=${"+91" + item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                        },
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: width * .485,
                                                            height: 35,
                                                            decoration: const BoxDecoration(
                                                                color:
                                                                    cl_3CB249,
                                                                borderRadius: BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10))),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const Icon(
                                                                  Icons.phone,
                                                                  color:
                                                                      myWhite,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'WhatsApp',
                                                                  style:
                                                                      knmTerms3,
                                                                ),
                                                              ],
                                                            )
                                                            // child: Text('WhatsApp',style: knmTerms3,)
                                                            ),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            // Container(
                                            //     alignment: Alignment.center,
                                            //     width: width,
                                            //     height: 6,
                                            // color: myWhite,)
                                            //  const SizedBox(height: 10)
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              // ListView.builder(
                              //     itemCount: value.paymentDetailsList.length,
                              //     shrinkWrap: true,
                              //     physics: const ScrollPhysics(),
                              //     itemBuilder: (BuildContext context, int index) {
                              //       var item = value.paymentDetailsList[index];
                              //       return Padding(
                              //         padding: const EdgeInsets.only(bottom: 5),
                              //         child: Container(
                              //           // color: const Color(0xffF2EADD),
                              //           color: item.status == "Success"
                              //               ? const Color(0xffF2EADD)
                              //               // : lightPink,
                              //               : Colors.red.withOpacity(0.3),
                              //           child: Column(
                              //             crossAxisAlignment: CrossAxisAlignment.end,
                              //             children: [
                              //               Padding(
                              //                 padding: const EdgeInsets.only(right: 11.0,top: 7),
                              //                 child: Text(getDate(item.time),style:
                              //                 receipt_DT
                              //                   ,)
                              //                 ,
                              //               ),
                              //               Container(
                              //                 padding: const EdgeInsets.symmetric(
                              //                     vertical: 10, horizontal: 10),
                              //                 child: Row(
                              //                   // crossAxisAlignment: CrossAxisAlignment.start,
                              //                   children: [
                              //                     // from != "home"
                              //                     //     ? SizedBox(
                              //                     //         child: Text(
                              //                     //           (index + 1).toString(),
                              //                     //           style: black14,
                              //                     //         ),
                              //                     //         width: 40,
                              //                     //       )
                              //                     //     : const SizedBox(),
                              //                     Expanded(
                              //                       child: Text(
                              //                         //item.name,
                              //                         " ₹ ${item.amount.split(".").first}",
                              //                         style: black141,
                              //                       ),
                              //                     ),
                              //                     Expanded(
                              //                         flex: 3,
                              //                         child: Column(
                              //                           children: [
                              //                             Row(
                              //                               crossAxisAlignment: CrossAxisAlignment.start,
                              //                               children: [
                              //                                 SizedBox(
                              //                                   width: width*.05,
                              //                                   child: Text('Name',style: receiptNDMU,
                              //                                   ),
                              //                                 ),
                              //                                 SizedBox(
                              //                                  // color:Colors.blue,
                              //                                     width: width*.01,
                              //                                     child: const Text(':')
                              //                                 ),
                              //                                 SizedBox(
                              //                                  //color: Colors.yellow,
                              //                                   width: width*.11,
                              //                                   child: Text(item.name,
                              //                                     maxLines: 2,
                              //                                     overflow: TextOverflow.ellipsis,
                              //                                     style: receiptNDMU2,),
                              //                                 ),
                              //                               ],
                              //                             ),
                              //                             Row(
                              //                               crossAxisAlignment: CrossAxisAlignment.start,
                              //                               children: [
                              //                                 SizedBox(
                              //                                   width: width*.05,
                              //                                   child: Text('District',style: receiptNDMU,
                              //                                   ),
                              //                                 ),
                              //                                 SizedBox(
                              //                                     width: width*.01,
                              //                                     child: const Text(':')
                              //                                 ),
                              //                                 SizedBox(
                              //                                   width: width*.11,
                              //                                   child: Text(item.district,
                              //                                     maxLines: 2,
                              //                                     overflow: TextOverflow.ellipsis,
                              //                                     style: receiptNDMU2,),
                              //                                 ),
                              //                               ],
                              //                             ),
                              //                             Row(
                              //                               crossAxisAlignment: CrossAxisAlignment.start,
                              //                               children: [
                              //                                 SizedBox(
                              //                                   width: width*.05,
                              //                                   child: Text('Mandalam',style: receiptNDMU,
                              //                                   ),
                              //                                 ),
                              //                                 SizedBox(
                              //                                     width: width*.01,
                              //                                     child: const Text(':')
                              //                                 ),
                              //                                 SizedBox(
                              //                                   width: width*.11,
                              //                                   child: Text(item.panchayath,
                              //                                     maxLines: 2,
                              //                                     overflow: TextOverflow.ellipsis,
                              //                                     style: receiptNDMU2,),
                              //                                 ),
                              //                               ],
                              //                             ),
                              //                             Row(
                              //                               crossAxisAlignment: CrossAxisAlignment.start,
                              //                               children: [
                              //                                 SizedBox(
                              //                                   width: width*.05,
                              //                                   child: Text('Unit',style: receiptNDMU,
                              //                                   ),
                              //                                 ),
                              //                                 SizedBox(
                              //                                     width: width*.01,
                              //                                     child: const Text(':')
                              //                                 ),
                              //                                 SizedBox(
                              //                                   width: width*.11,
                              //                                   child: Text(item.ward,
                              //                                     maxLines: 2,
                              //                                     overflow: TextOverflow.ellipsis,
                              //                                     style: receiptNDMU2,),
                              //                                 ),
                              //                               ],
                              //                             ),
                              //
                              //                             // Text(
                              //                             //   value.historyList
                              //                             //           .map(
                              //                             //               (item) => item.id)
                              //                             //           .contains(item.id)
                              //                             //       ? item.id
                              //                             //       : getName(item),
                              //                             //   style: black14,
                              //                             // ),
                              //                             // Text(
                              //                             //   '${item.ward},${item.panchayath}\n${item.district}',
                              //                             //   style: black14,
                              //                             // ),
                              //                             // Text(
                              //                             //   getDate(item.time),
                              //                             //   style: green14N,
                              //                             // ),
                              //                           ],
                              //                           crossAxisAlignment:
                              //                           CrossAxisAlignment.start,
                              //                         )),
                              //                     // Expanded(
                              //                     //     flex: 1,
                              //                     //     child: Container(
                              //                     //       color:Colors.yellow,
                              //                     //       child: Column(
                              //                     //         crossAxisAlignment:
                              //                     //             CrossAxisAlignment.start,
                              //                     //         mainAxisAlignment:
                              //                     //             MainAxisAlignment
                              //                     //                 .spaceBetween,
                              //                     //         children: const [
                              //                     //           Text('ad;slff'),
                              //                     //           // Text(
                              //                     //           //   '₹ ${item.amount}',
                              //                     //           //   style: black14,
                              //                     //           // ),
                              //                     //           SizedBox(
                              //                     //             height: 20,
                              //                     //           ),
                              //                     //           // Row(
                              //                     //           //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //                     //           //   children: [
                              //                     //           //    // Image.asset("assets/dhothi_icon.png", scale: 2,),
                              //                     //           //    //  Text(((double.parse(item.amount)/600).floor()).toString(),
                              //                     //           //    //    style: black14,
                              //                     //           //    //  ),
                              //                     //           //   ],
                              //                     //           // ),
                              //                     //         ],
                              //                     //       ),
                              //                     //     )),
                              //                   ],
                              //                 ),
                              //               ),
                              //
                              //               if (from == "home")
                              //                 item.status == "Success"
                              //                     ?  Row(
                              //                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     value.receiptPinWard=='ON'
                              //                         ?
                              //                     InkWell(
                              //                       onTap: () {
                              //                         showPinWardAlert(
                              //                             context, item);
                              //                       },
                              //                       child: Container(
                              //                           alignment: Alignment.center,
                              //                           width: width * .146,
                              //                           height: 35,
                              //                           decoration: const BoxDecoration(
                              //                               color: Color(0xffEDE2CF),
                              //                               borderRadius:
                              //                               BorderRadius.only(
                              //                                   bottomLeft: Radius
                              //                                       .circular(10))),
                              //                           child: Text('Change Booth',
                              //                             style:receiptCG,
                              //                           )),
                              //                     )
                              //                         : SizedBox(
                              //                       width: width * .146,
                              //                     ),
                              //
                              //                     const SizedBox(width: 06,),
                              //
                              //                     InkWell(
                              //
                              //                       onTap: () {
                              //                         DonationProvider
                              //                         donationProvider =
                              //                         Provider.of<
                              //                             DonationProvider>(
                              //                             context,
                              //                             listen: false);
                              //                         donationProvider
                              //                             .getSharedPrefName();
                              //                         if (item.paymentApp ==
                              //                             'Bank' &&
                              //                             item.name ==
                              //                                 'No Name') {
                              //                           showReceiptAlert(
                              //                               context, item);
                              //                         } else {
                              //                           DonationProvider
                              //                           donationProvider =
                              //                           Provider.of<
                              //                               DonationProvider>(
                              //                               context,
                              //                               listen: false);
                              //                           donationProvider
                              //                               .fetchDonationDetails(
                              //                               item.id);
                              //                           donationProvider.receiptSuccessStatus(item.id);
                              //
                              //                           callNext(ReceiptPage(),
                              //                               context);
                              //                         }
                              //                       },
                              //
                              //                       child: Container(
                              //                           alignment: Alignment.center,
                              //                           width: width * .146,
                              //                           height: 35,
                              //                           decoration: const BoxDecoration(
                              //                               color:  Color(0xffEDE2CF),
                              //                               borderRadius:
                              //                               BorderRadius.only(
                              //                                   bottomRight:
                              //                                   Radius.circular(
                              //                                       10))),
                              //                           child: Text('Receipt',style: receiptCG,)),
                              //                     ),
                              //
                              //                     //get reciept
                              //
                              //                     // InkWell(
                              //                     //   onTap: () {
                              //                     //     DonationProvider
                              //                     //         donationProvider =
                              //                     //         Provider.of<
                              //                     //                 DonationProvider>(
                              //                     //             context,
                              //                     //             listen: false);
                              //                     //     donationProvider
                              //                     //         .getSharedPrefName();
                              //                     //     if (item.paymentApp ==
                              //                     //             'Bank' &&
                              //                     //         item.name ==
                              //                     //             'No Name') {
                              //                     //       showReceiptAlert(
                              //                     //           context, item);
                              //                     //     } else {
                              //                     //       DonationProvider
                              //                     //           donationProvider =
                              //                     //           Provider.of<
                              //                     //                   DonationProvider>(
                              //                     //               context,
                              //                     //               listen: false);
                              //                     //       donationProvider
                              //                     //           .fetchDonationDetails(
                              //                     //               item.id);
                              //                     //       donationProvider.receiptSuccessStatus(item.id);
                              //                     //
                              //                     //       callNext(ReceiptPage(),
                              //                     //           context);
                              //                     //     }
                              //                     //   },
                              //                     //   child: Container(
                              //                     //     decoration: BoxDecoration(
                              //                     //       gradient: const LinearGradient(
                              //                     //           begin: Alignment
                              //                     //               .topLeft,
                              //                     //           end: Alignment
                              //                     //               .bottomRight,
                              //                     //           colors: [
                              //                     //             myGradient1,
                              //                     //             myGradient2
                              //                     //           ]),
                              //                     //       borderRadius:
                              //                     //           BorderRadius
                              //                     //               .circular(5),
                              //                     //     ),
                              //                     //     width: 110,
                              //                     //     height: 45,
                              //                     //     alignment:
                              //                     //         Alignment.center,
                              //                     //     child: Text(
                              //                     //       'Get Receipt',
                              //                     //       style: whitePoppinsBoldM15,
                              //                     //     ),
                              //                     //   ),
                              //                     // ),
                              //                     // const SizedBox(
                              //                     //   width: 5,
                              //                     // ),
                              //                     // value.receiptPinWard=='ON'
                              //                     //     ?InkWell(
                              //                     //   onTap: () {
                              //                     //     showPinWardAlert(
                              //                     //         context, item);
                              //                     //   },
                              //                     //   child: Container(
                              //
                              //                     //     decoration: BoxDecoration(
                              //                     //       gradient: const LinearGradient(
                              //                     //           begin: Alignment
                              //                     //               .topLeft,
                              //                     //           end: Alignment
                              //                     //               .bottomRight,
                              //                     //           colors: [
                              //                     //             myGradient1,
                              //                     //             myGradient2
                              //                     //           ]),
                              //                     //       borderRadius:
                              //                     //           BorderRadius
                              //                     //               .circular(5),
                              //                     //     ),
                              //                     //     width: 110,
                              //                     //     height: 45,
                              //                     //     alignment:
                              //                     //         Alignment.center,
                              //                     //     child: Text(
                              //                     //       'Pin Ward',
                              //                     //       style: whitePoppinsBoldM15,
                              //                     //     ),
                              //                     //   ),
                              //                     // )
                              //                     //     :const SizedBox(),
                              //                     // const SizedBox(
                              //                     //   width: 5,
                              //                     // ),
                              //                   ],
                              //                 )
                              //                     :const SizedBox()
                              //               else
                              //                 const SizedBox(),
                              //               homeProvider.knmMonitor
                              //               ?Row(
                              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                 children: [
                              //
                              //
                              //                   InkWell(
                              //                     onTap: () {
                              //                       launch("tel://${item.phoneNumber}");
                              //                     },
                              //                     child: Container(
                              //                         alignment: Alignment.center,
                              //                         width: width * .146,
                              //                         height: 35,
                              //                         decoration:  BoxDecoration(
                              //                             color: Colors.green.withOpacity(0.7),
                              //                             borderRadius:
                              //                             const BorderRadius.only(
                              //                                 bottomLeft: Radius
                              //                                     .circular(10))),
                              //                         child: Row(
                              //                           mainAxisAlignment: MainAxisAlignment.center,
                              //                           children: [
                              //                             const Icon(Icons.call,color: myWhite,),
                              //                             const SizedBox(width: 10,),
                              //                             Text('Call',
                              //                               style:knmTerms3,
                              //                             ),
                              //                           ],
                              //                         )
                              //                     ),
                              //                   ),
                              //
                              //                   InkWell(
                              //
                              //                     onTap: () {
                              //                       launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                              //                     },
                              //
                              //                     child: Container(
                              //                         alignment: Alignment.center,
                              //                         width: width * .146,
                              //                         height: 35,
                              //                         decoration: const BoxDecoration(
                              //                             color:  cl_3CB249,
                              //                             borderRadius:
                              //                             BorderRadius.only(
                              //                                 bottomRight:
                              //                                 Radius.circular(
                              //                                     10))),
                              //                         child: Row(
                              //                           mainAxisAlignment: MainAxisAlignment.center,
                              //                           children: [
                              //                             const Icon(Icons.phone,color: myWhite,),
                              //                             const SizedBox(width: 10,),
                              //                             Text('WhatsApp',
                              //                               style:knmTerms3,
                              //                             ),
                              //                           ],
                              //                         )
                              //                       // child: Text('WhatsApp',style: knmTerms3,)
                              //                     ),
                              //                   ),
                              //
                              //                 ],
                              //               )
                              //                   :const SizedBox(),
                              //               //  const SizedBox(height: 10)
                              //             ],
                              //           ),
                              //         ),
                              //       );
                              //     }),
                              );
                    }),

                    Consumer<HomeProvider>(builder: (context, value, child) {
                      return (value.currentLimit == value.paymentDetailsList.length ||
                                  value.currentAssemblyLimit ==
                                      value.paymentDetailsList.length)
                          ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                            clC46F4E),
                                    foregroundColor: MaterialStateProperty.all<Color>(clC46F4E),
                                    overlayColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.red),
                                    animationDuration:
                                        const Duration(microseconds: 500)),
                                onPressed: () async {
                                  PackageInfo packageInfo =
                                      await PackageInfo.fromPlatform();
                                  String packageName = packageInfo.packageName;
                                  if (packageName == 'com.spine.knmMonitor') {
                                    HomeProvider homeProvider =
                                        Provider.of<HomeProvider>(context,
                                            listen: false);
                                    homeProvider.currentLimit = 50;
                                    homeProvider
                                        .fetchReceiptListForMonitorApp(50);
                                    homeProvider.checkStarRating();
                                  } else {
                                    if (from == "WardPage") {
                                      value.currentAssemblyLimit =
                                          value.currentAssemblyLimit + 20;
                                      homeProvider.assemblyReceiptList(
                                          value.fromReportAssembly!,
                                          value.currentAssemblyLimit);
                                    } else if (from == "home") {
                                      value.currentLimit = value.currentLimit + 20;
                                      homeProvider
                                          .fetchReceiptList(value.currentLimit);
                                    }
                                  }
                                },
                                child:  SizedBox(
                                  width: double.infinity,
                                  child: Center(child: Text('Load More',style:blackPoppinsBlackR14 ,)),
                                )),
                          )
                          : SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const Divider(
                                    thickness: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      value.paymentDetailsList.isNotEmpty
                                          ? 'No More Payments'
                                          : 'No Payments',
                                      style: black16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                    })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget mobile(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return true;
          //  if(from=="home"){
          //    return false;
          //  }else{
          //    return true;
          //  }
        },
        child: Scaffold(
          backgroundColor: Colors.white, //cl_c8b3e6
          resizeToAvoidBottomInset: false,
          appBar:  PreferredSize(
            preferredSize: Size.fromHeight(84),
            child: AppBar(
                actions: [
                  from == "WardPage"
                      ? Consumer<HomeProvider>(builder: (context, value, child) {
                          return Padding(
                              padding:
                                  const EdgeInsets.only(right: 12),
                              child: InkWell(
                                onTap: () {
                                  value.refreshAssembly(value.modelUnit!, context);
                                },
                                child: Container(
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.refresh,
                                        color: clC46F4E,
                                      ),
                                      Text(
                                        "Refresh",
                                        style: TextStyle(color: clC46F4E),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        })
                      : const SizedBox(),
                ],
                automaticallyImplyLeading: false,
              toolbarHeight: MediaQuery.of(context).size.height*0.12,
              backgroundColor: Colors.white,
              leading: InkWell(
                  onTap: () {
                    callNextReplacement(const HomeScreenNew(), context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: cl000000,
                    size: 20,
                  ),
                ),
                title:   Text(
                  "Transactions",
                  style: wardAppbarTxt
                ),
                centerTitle: true,
              ),
          ),
          body: body(context),
        ),
      ),
    );
  }

  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    var height = queryData.size.height;
    var width = queryData.size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/KPCCWebBackground.jpg",
              ),
              fit: BoxFit.fill)),
      child: Stack(
        children: [
          // from == 'WardPage'
          //     ?
          // Row(
          //   children: [
          //     Container(
          //       height: height,
          //       width: width,
          //       decoration: const BoxDecoration(
          //           image: DecorationImage(
          //               image: AssetImage('assets/KnmWebBackground1.jpg'),fit: BoxFit.cover
          //           )
          //       ),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //               height: height,
          //               width: width / 3,
          //               child: Image.asset("assets/Group 2.png",scale: 4,)),
          //           SizedBox(
          //             height: height,
          //             width: width / 3.2,
          //           ),
          //           SizedBox(
          //               height: height,
          //               width: width / 3,
          //               child: Image.asset("assets/Group 3.png",scale: 6,)),
          //         ],
          //       ),
          //     ),
          //
          //
          //   ],
          // )
          //     :const SizedBox(),
          Center(
              child: queryData.orientation == Orientation.portrait
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width,
                          child: Scaffold(
                            // backgroundColor: cl_c8b3e6, //cl_c8b3e6
                            resizeToAvoidBottomInset: false,
                            appBar: AppBar(
                              actions: [
                                from == "WardPage"
                                    ? Consumer<HomeProvider>(
                                        builder: (context, value, child) {
                                        return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                value.refreshAssembly(
                                                    value.modelUnit!, context);
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(Icons.refresh),
                                                  Text("Refresh")
                                                ],
                                              ),
                                            ));
                                      })
                                    : const SizedBox(),
                              ],
                              automaticallyImplyLeading: false,
                              // leading: InkWell(
                              //   onTap: () {
                              //     Navigator.pop(context);
                              //   },
                              //   child: const Icon(
                              //     Icons.arrow_back_ios,
                              //     color: Colors.white,
                              //     size: 20,
                              //   ),
                              // ),
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              toolbarHeight:
                                  MediaQuery.of(context).size.height * 0.13,
                              flexibleSpace: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25)),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [myDarkBlue, myLightBlue])),
                              ),
                              // backgroundColor: LinearGradient(colors: []),
                              // centerTitle: true,
                              leading: InkWell(
                                onTap: () {
                                  callNextReplacement(const HomeScreenNew(), context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              centerTitle: true,
                              title: Text(
                                "Transactions",
                                style: wardAppbarTxt,
                              ),
                            ),
                            body: body(context),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 3,
                          child: Scaffold(
                            // backgroundColor: cl_c8b3e6, //cl_c8b3e6
                            resizeToAvoidBottomInset: false,
                            appBar: AppBar(
                              actions: [
                                from == "WardPage"
                                    ? Consumer<HomeProvider>(
                                        builder: (context, value, child) {
                                        return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                value.refreshAssembly(
                                                    value.modelUnit!, context);
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(Icons.refresh),
                                                  Text("Refresh")
                                                ],
                                              ),
                                            ));
                                      })
                                    : const SizedBox(),
                              ],
                              automaticallyImplyLeading: false,
                              // leading: InkWell(
                              //   onTap: () {
                              //     Navigator.pop(context);
                              //   },
                              //   child: const Icon(
                              //     Icons.arrow_back_ios,
                              //     color: Colors.white,
                              //     size: 20,
                              //   ),
                              // ),
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              toolbarHeight:
                                  MediaQuery.of(context).size.height * 0.13,
                              flexibleSpace: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25)),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [myDarkBlue, myLightBlue])),
                              ),
                              // backgroundColor: LinearGradient(colors: []),
                              // centerTitle: true,
                              leading: InkWell(
                                onTap: () {
                                  callNextReplacement(const HomeScreenNew(), context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              centerTitle: true,
                              title: Text(
                                "Transactions",
                                style: wardAppbarTxt,
                              ),
                            ),
                            body: body(context),
                          ),
                        ),
                      ],
                    ))
        ],
      ),
    );
  }

  showReceiptAlert(
    BuildContext context,
    PaymentDetails item,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Name',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.name,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: myGray2,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (name) =>
                          name == '' ? 'Please Enter Valid Name' : null,
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Transaction ID(last 4 digit)/ Phone Number',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.transactionID,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: myGray2,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (name) => name == '' ||
                              name!.toLowerCase() != item.id.toLowerCase() &&
                                  name.toLowerCase() !=
                                      item.upiId.toLowerCase() &&
                                  name.toLowerCase() !=
                                      item.refNo.toLowerCase() &&
                                  name.toLowerCase() !=
                                      item.phoneNumber.toLowerCase() &&
                                  name.toLowerCase() !=
                                      newString(item.id.toLowerCase(), 4)
                          ? 'Please Enter Valid Transaction ID'
                          : null,
                    );
                  }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(myWhite),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(myGreen),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                color: myGreen,
                                width: 2.0,
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30)),
                        ),
                        onPressed: () async {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            finish(context);
                            DonationProvider donationProvider =
                                Provider.of<DonationProvider>(context,
                                    listen: false);
                            donationProvider.receiptStatus(item.id);
                            donationProvider
                                .getDonationDetailsForReceipt(item.id);
                            SharedPreferences userPreference =
                                await SharedPreferences.getInstance();
                            userPreference.setString(
                                "ReceiptName", donationProvider.name.text);
                            userPreference.setString("ReceiptID",
                                donationProvider.transactionID.text);
                            callNext(
                                ReceiptPage(
                                  nameStatus:
                                      item.nameStatus == 'YES' ? "YES" : "NO",
                                ),
                                context);
                          }
                        },
                        child: Text(
                          'Get Receipt',
                          style: white16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showPinWardAlert(
    BuildContext context,
    PaymentDetails item,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Consumer<DonationProvider>(
                        builder: (context, value, child) {
                      return Text(
                        'Transaction ID (4 digit)${value.phonePinWard == 'ON' ? '/Phone No' : ''}',
                        style: const TextStyle(fontSize: 14),
                      );
                    }),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.transactionID,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: myGray2,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (name) => name != '' &&
                              (name!.toLowerCase() == item.id.toLowerCase() ||
                                  name.toLowerCase() ==
                                      newString(item.id.toLowerCase(), 4) ||
                                  (value.phonePinWard == 'ON' &&
                                      name.toLowerCase() ==
                                          item.phoneNumber.toLowerCase()))
                          ? null
                          : 'Please Enter Valid Transaction ID',
                    );
                  }),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 5),
                  //   child: Text(
                  //     'Booth',
                  //     style: TextStyle(fontSize: 14),
                  //   ),
                  // ),
                  // Consumer<DonationProvider>(builder: (context, value, child) {
                  //   return Autocomplete<WardModel>(
                  //     optionsBuilder: (TextEditingValue textEditingValue) {
                  //       return (value.wards + value.newWards)
                  //           .where((WardModel wardd) =>
                  //               wardd.booth.toLowerCase().contains(
                  //                   textEditingValue.text.toLowerCase()) ||
                  //               wardd.mandalam.toLowerCase().contains(
                  //                   textEditingValue.text.toLowerCase()))
                  //           .toList();
                  //     },
                  //     displayStringForOption: (WardModel option) =>
                  //         option.booth,
                  //     fieldViewBuilder: (BuildContext context,
                  //         TextEditingController fieldTextEditingController,
                  //         FocusNode fieldFocusNode,
                  //         VoidCallback onFieldSubmitted) {
                  //       return TextFormField(
                  //         decoration: InputDecoration(
                  //           contentPadding:
                  //               const EdgeInsets.symmetric(horizontal: 10),
                  //           hintText: 'Select Booth',
                  //           suffixIcon: const Icon(Icons.arrow_drop_down),
                  //           hintStyle: blackPoppinsR12,
                  //           filled: true,
                  //           fillColor: myLightWhiteNewUI,
                  //           border: OutlineInputBorder(
                  //             borderSide: const BorderSide(color: myGray2),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderSide: const BorderSide(color: myGray2),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide: const BorderSide(color: myGray2),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //         validator: (name) => name == '' ||
                  //                 !(value.wards + value.newWards)
                  //                     .map((e) => e.booth)
                  //                     .contains(name)
                  //             ? 'Please Enter Valid Booth Name'
                  //             : null,
                  //         controller: fieldTextEditingController,
                  //         focusNode: fieldFocusNode,
                  //         style: const TextStyle(fontWeight: FontWeight.bold),
                  //       );
                  //     },
                  //     onSelected: (WardModel selection) {
                  //       value.selectPinWard(selection);
                  //     },
                  //     optionsViewBuilder: (BuildContext context,
                  //         AutocompleteOnSelected<WardModel> onSelected,
                  //         Iterable<WardModel> options) {
                  //       return Align(
                  //         alignment: Alignment.topLeft,
                  //         child: Material(
                  //           child: Container(
                  //             width: MediaQuery.of(context).size.width / 1.5,
                  //             height: 200,
                  //             color: Colors.white,
                  //             child: ListView.builder(
                  //               padding: const EdgeInsets.all(10.0),
                  //               itemCount: options.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 final WardModel option =
                  //                     options.elementAt(index);
                  //
                  //                 return GestureDetector(
                  //                   onTap: () {
                  //                     onSelected(option);
                  //                   },
                  //                   child: SizedBox(
                  //                     height: 50,
                  //                     child: Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text(option.booth,
                  //                               style: const TextStyle(
                  //                                   fontWeight:
                  //                                       FontWeight.bold)),
                  //                           Text(option.mandalam),
                  //                           const SizedBox(height: 10)
                  //                         ]),
                  //                   ),
                  //                 );
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   );
                  // }),

                  // const Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 5),
                  //   child: Text(
                  //     'Select Assembly',
                  //     style: TextStyle(fontSize: 14),
                  //   ),
                  // ),
                  // Consumer<DonationProvider>(builder: (context, value, child) {
                  //   return Autocomplete<AssemblyModel>(
                  //     optionsBuilder: (TextEditingValue textEditingValue) {
                  //       return (value.assemblyList)
                  //       // (value.wards+value.newWards).map((e) => PanjayathModel(e.district, e.panchayath)).toSet().toList())
                  //
                  //           .where((AssemblyModel wardd) => wardd.assembly.toLowerCase()
                  //           .contains(textEditingValue.text.toLowerCase()))
                  //           .toList();
                  //     },
                  //     displayStringForOption: (AssemblyModel option) =>
                  //     option.assembly,
                  //     fieldViewBuilder: (BuildContext context,
                  //         TextEditingController fieldTextEditingController,
                  //         FocusNode fieldFocusNode,
                  //         VoidCallback onFieldSubmitted) {
                  //       return TextFormField(
                  //         decoration: InputDecoration(
                  //           contentPadding:
                  //           const EdgeInsets.symmetric(horizontal: 10),
                  //           hintText: 'Select Assembly',
                  //           suffixIcon: const Icon(Icons.arrow_drop_down),
                  //           hintStyle: blackPoppinsR12,
                  //           filled: true,
                  //           fillColor: myLightWhiteNewUI,
                  //           border: OutlineInputBorder(
                  //             borderSide: const BorderSide(color: myGray2),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderSide: const BorderSide(color: myGray2),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide: const BorderSide(color: myGray2),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //         validator: (value2) {
                  //           if (value2!.trim().isEmpty || !value.assemblyList.map((item) => item.assembly).contains(value2)) {
                  //             return "Please Select Valid Assembly";
                  //           } else {
                  //             return null;
                  //           }
                  //         },
                  //         controller: fieldTextEditingController,
                  //         focusNode: fieldFocusNode,
                  //         style: const TextStyle(fontWeight: FontWeight.bold),
                  //       );
                  //     },
                  //     onSelected: (AssemblyModel selection) {
                  //       // value.selectPinWard(selection);
                  //       // value.fetchBoothChipset(selection,context);
                  //     },
                  //     optionsViewBuilder: (BuildContext context,
                  //         AutocompleteOnSelected<AssemblyModel> onSelected,
                  //         Iterable<AssemblyModel> options) {
                  //       return Align(
                  //         alignment: Alignment.topLeft,
                  //         child: Material(
                  //           child: Container(
                  //             width: MediaQuery.of(context).size.width / 1.5,
                  //             height: 200,
                  //             color: Colors.white,
                  //             child: ListView.builder(
                  //               padding: const EdgeInsets.all(10.0),
                  //               itemCount: options.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 final AssemblyModel option =
                  //                 options.elementAt(index);
                  //
                  //                 return GestureDetector(
                  //                   onTap: () {
                  //                     onSelected(option);
                  //                   },
                  //                   child: SizedBox(
                  //                     height: 50,
                  //                     child: Column(
                  //                         crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text(option.assembly,
                  //                               style: const TextStyle(
                  //                                   fontWeight:
                  //                                   FontWeight.bold)),
                  //                           Text(option.district),
                  //                           const SizedBox(height: 10)
                  //                         ]),
                  //                   ),
                  //                 );
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   );
                  // }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Select Unit',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),

                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return Autocomplete<WardModel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return (value.wards + value.newWards)
                            // (value.wards+value.newWards).map((e) => PanjayathModel(e.district, e.panchayath)).toSet().toList())

                            .where((WardModel wardd) =>
                                wardd.wardName.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase()) ||
                                wardd.panchayath.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (WardModel option) =>
                          option.wardName,
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select Unit  ',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            hintStyle: blackPoppinsR12,
                            filled: true,
                            fillColor: myLightWhiteNewUI,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (name) => name == '' ||
                                  !(value.wards + value.newWards)
                                      .map((e) => e.wardName)
                                      .contains(name)
                              ? 'Please Enter Valid Unit Name'
                              : null,
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (WardModel selection) {
                        value.selectPinWard(selection);
                        // value.onSelectWard(selection);
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<WardModel> onSelected,
                          Iterable<WardModel> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 200,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final WardModel option =
                                      options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Container(
                                      height: 60,
                                      color: Colors.white,
                                      // width: MediaQuery.of(context).size.width / 1.5,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(option.wardName,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(option.panchayath),
                                            const SizedBox(height: 10)
                                          ]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () async {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            finish(context);
                            DonationProvider donationProvider =
                                Provider.of<DonationProvider>(context,
                                    listen: false);
                            donationProvider.addPinAssembly(
                                context, item.time, item.id, item.amount, item);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [cl1177BB, cl264186]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 130,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'Change Unit',
                            style: whitePoppinsBoldM15,
                          ),
                        ),
                      ),
                      // TextButton(
                      //   style: ButtonStyle(
                      //     foregroundColor:
                      //         MaterialStateProperty.all<Color>(myWhite),
                      //     backgroundColor:
                      //         MaterialStateProperty.all<Color>(myGreen),
                      //     shape:
                      //         MaterialStateProperty.all<RoundedRectangleBorder>(
                      //       RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //         side: const BorderSide(
                      //           color: myGreen,
                      //           width: 2.0,
                      //         ),
                      //       ),
                      //     ),
                      //     padding: MaterialStateProperty.all(
                      //         const EdgeInsets.symmetric(
                      //             vertical: 15, horizontal: 30)),
                      //   ),
                      //   onPressed: () async {
                      //     final FormState? form = _formKey.currentState;
                      //     if (form!.validate()) {
                      //       finish(context);
                      //       DonationProvider donationProvider =
                      //           Provider.of<DonationProvider>(context,
                      //               listen: false);
                      //       donationProvider.addPinWard(
                      //           item.time, item.id, item.amount, item);
                      //     }
                      //   },
                      //   child: Text(
                      //     'Pin Ward',
                      //     style: white16,
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
    return d12;
  }

  String getName(PaymentDetails item) {
    String trId = '';
    trId = item.id.substring(0, item.id.length - 4) + getStar(4);

    return trId;
  }

  String getStar(int length) {
    String star = '';
    for (int i = 0; i < length; i++) {
      star = star + '*';
    }
    return star;
  }

  aboutReceiptAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      backgroundColor: Colors.white,
      actions: [
        SizedBox(
          width: 400,
          // height: 220,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  "How to print Receipt",
                  style: black16,
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "In a transaction, it is possible to print a receipt and change the unit using either the phone number or the Transaction ID.",
                      style: black14,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                        // flex: 1,
                        child: InkWell(
                      onTap: () {
                        finish(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 40,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: clC46F4E,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Text(
                          "OK",
                          style: white16,
                        ),
                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String newString(String oldString, int n) {
    if (oldString.length >= n) {
      return oldString.substring(oldString.length - n);
    } else {
      return '';
      // return whatever you want
    }
  }
}

String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
      formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}
