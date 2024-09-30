import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloodmoney/Screens/reciept_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Views/panjayath_model.dart';
import '../Views/receipt_list_model.dart';
import '../Views/ward_model.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/home_provider.dart';
import 'home.dart';
import 'home_screen.dart';

class PaymentHistory extends StatelessWidget {
  PaymentHistory({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget body(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:30,right:20,top: 10),
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
            return value.historyList.isNotEmpty
                ? SizedBox(
              // height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: value.historyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = value.historyList[index];
                        return InkWell(
                          onTap: () {
                            if (item.status == "Success") {
                              donationProvider.getDonationDetailsForReceipt(item.id);
                              callNext(ReceiptPage(nameStatus: 'YES',), context);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow:  const [
                                BoxShadow(
                                    color: boarderShadow,
                                    blurRadius: 5,
                                    // offset: const Offset(0, 3),

                                )
                              ],
                            ),
                            margin: const EdgeInsets.only(top: 5, left: 12, right: 12),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 8, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                      child: Text(getDate(item.time),style: receipt_DT,)),
                                  // Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       children: [
                                  //
                                  //         SizedBox(
                                  //             width:
                                  //             MediaQuery.of(context).size.width/8,
                                  //             child: Text("Name", style: pay_his_NDMU,)),
                                  //         SizedBox(
                                  //             width:
                                  //             MediaQuery.of(context).size.width/7.6,
                                  //             child: Text(
                                  //               "District",
                                  //               style: pay_his_NDMU,
                                  //             )),
                                  //         SizedBox(
                                  //             width:
                                  //             MediaQuery.of(context).size.width/5,
                                  //             child: Text(
                                  //               "Assembly",
                                  //               style: pay_his_NDMU,
                                  //             )),
                                  //         SizedBox(
                                  //             width:
                                  //             MediaQuery.of(context).size.width/4.7,
                                  //             child: Text(
                                  //               "Panchayath",
                                  //               style: pay_his_NDMU,
                                  //             )),
                                  //         SizedBox(
                                  //             width:
                                  //             MediaQuery.of(context).size.width/5,
                                  //             child: Text(
                                  //               "Unit",
                                  //               style: pay_his_NDMU,
                                  //             )),
                                  //         // SizedBox(
                                  //         //     width:
                                  //         //     MediaQuery.of(context).size.width/10,
                                  //         //     child: Text(
                                  //         //       "Booth",
                                  //         //       style: pay_his_NDMU,
                                  //         //     )),
                                  //         item.enroller!="NILL"? SizedBox(
                                  //             width:
                                  //             MediaQuery.of(context).size.width/4.6,
                                  //             child: Text(
                                  //               "Volunteer",
                                  //               style: pay_his_NDMU,
                                  //             )):SizedBox(),
                                  //
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(
                                  //             width:
                                  //                 MediaQuery.of(context).size.width / 2,
                                  //             child: Text(
                                  //               ": "+item.name,
                                  //               style: receiptName,
                                  //             )),
                                  //         SizedBox(
                                  //             width:
                                  //                 MediaQuery.of(context).size.width / 2,
                                  //             child: Text(
                                  //               ": "+item.district,
                                  //               style: pay_his_NDMU2,
                                  //             )),
                                  //         SizedBox(
                                  //             width:
                                  //                 MediaQuery.of(context).size.width / 2,
                                  //             child: Text(
                                  //               ": "+item.assembly,
                                  //               style: pay_his_NDMU2,
                                  //             )),
                                  //         SizedBox(
                                  //             width:
                                  //             MediaQuery.of(context).size.width / 2,
                                  //             child: Text(
                                  //               ": "+item.panchayath,
                                  //               style: pay_his_NDMU2,
                                  //             )),
                                  //         // item.status=="Success"?Text('Hadiya Success',style: green16,):Text('Hadiya Failed',style: red16,),
                                  //          SizedBox(
                                  //                 width: MediaQuery.of(context).size.width / 2,
                                  //                 child: Text(": "+'${item.wardName}',
                                  //                   style: pay_his_NDMU2,)),
                                  //
                                  //         const SizedBox(height: 2,),
                                  //         // SizedBox(
                                  //         //     width:
                                  //         //     MediaQuery.of(context).size.width / 2,
                                  //         //     child: Text(
                                  //         //       ": "+item.booth,
                                  //         //       style: pay_his_NDMU2,
                                  //         //     )),
                                  //         item.enroller!="NILL"? SizedBox(
                                  //             width:
                                  //             MediaQuery.of(context).size.width / 2,
                                  //             child: Text(
                                  //               ": "+item.enroller,
                                  //               style: pay_his_NDMU2,
                                  //             )):SizedBox(),
                                  //       ],
                                  //     ),
                                  //
                                  //     item.status == "Success" ? Text.rich(
                                  //
                                  //         TextSpan(
                                  //
                                  //             children: <InlineSpan>[
                                  //
                                  //           const TextSpan(
                                  //               text: '₹',
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.w600,
                                  //                   fontSize: 18,
                                  //                   color: myBlack)),
                                  //           TextSpan(
                                  //               text: item.amount,
                                  //               style: const TextStyle(
                                  //                   fontFamily: 'PoppinsMedium',
                                  //                   fontWeight: FontWeight.w700,
                                  //                   fontSize: 18,
                                  //                   color: cl323A71))
                                  //         ])) : const Text(
                                  //       'Failed',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                                  //
                                  //     ),
                                  //   ],
                                  // ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, ),
                                    child: Row(
                                      children: [

                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('Name',style: receiptNDMU,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child: const Text(':')
                                                    ),
                                                    SizedBox(
                                                      width: width/2.9,
                                                      child: Text(item.name,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptName,),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('State',style: receiptNDMU,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child: const Text(':')
                                                    ),
                                                    SizedBox(
                                                      width: width/2.9,
                                                      child: Text(item.state,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptNDMU2,),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('District',style: receiptNDMU,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child: const Text(':')
                                                    ),
                                                    SizedBox(
                                                      width: width/2.9,
                                                      child: Text(item.district,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptNDMU2,),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('Assembly',style: receiptNDMU,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child: const Text(':')
                                                    ),
                                                    SizedBox(
                                                      width: width/2.9,
                                                      child: Text(item.assembly,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptNDMU2,),
                                                    ),
                                                  ],
                                                ),
                                                // Row(
                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     SizedBox(
                                                //       width: width/4.5,
                                                //       child: Text('Panchayath',style: receiptNDMU,
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //         width: width/25,
                                                //         child: const Text(':')
                                                //     ),
                                                //     SizedBox(
                                                //       width: width/2.9,
                                                //       child: Text(item.panchayath,
                                                //         maxLines: 2,
                                                //         overflow: TextOverflow.ellipsis,
                                                //         style: receiptNDMU2,),
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     SizedBox(
                                                //       width: width/4.5,
                                                //       child: Text('Unit',style: receiptNDMU,
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //         width: width/25,
                                                //         child: const Text(':')
                                                //     ),
                                                //     SizedBox(
                                                //       // color: Colors.red,
                                                //       width: width/2.9,
                                                //       child: Text(item.wardName,
                                                //         maxLines: 2,
                                                //         overflow: TextOverflow.ellipsis,
                                                //         style: receiptNDMU2,),
                                                //     ),
                                                //   ],
                                                // ),
                                                // item.frontOrganization!=""&&item.frontOrganization!='NILL'?
                                                // Row(
                                                //   crossAxisAlignment:
                                                //   CrossAxisAlignment
                                                //       .start,
                                                //   children: [
                                                //     SizedBox(
                                                //       width: width / 4.5,
                                                //       child: Text(
                                                //         'Front Organization',
                                                //         style:
                                                //         receiptNDMU,
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //         width: width / 25,
                                                //         child: const Text(
                                                //             ':')),
                                                //     Flexible(
                                                //       fit:FlexFit.tight,
                                                //       child: Padding(
                                                //         padding: const EdgeInsets.only(top:3.0),                                                        child: SizedBox(
                                                //         // width: width / 2.7,
                                                //         child: Text(
                                                //           item.frontOrganization,
                                                //           maxLines: 2,
                                                //           overflow:
                                                //           TextOverflow
                                                //               .ellipsis,
                                                //           style:
                                                //           receiptNDMU2,
                                                //         ),
                                                //       ),
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ):SizedBox(),
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
                                                item.enroller=="NILL"?SizedBox():Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('Volunteer',style: receiptNDMU,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child: const Text(':')
                                                    ),
                                                    SizedBox(
                                                      width: width/2.9,
                                                      child: Text(item.enroller,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptNDMU2,),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                            )),
                                        // SizedBox(
                                        //   width: width * 0.02,
                                        // ),
                                     Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // color: Colors.yellow,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width / 4.25,
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: AutoSizeText.rich(
                                                TextSpan(
                                                    children: <InlineSpan>[
                                                       TextSpan(
                                                            text: '₹',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 17,
                                                                color: item.status == "Success"?clC46F4E:myRed)),
                                                        TextSpan(
                                                            text: item.amount,
                                                            style:  TextStyle(
                                                                fontFamily: 'Poppins',
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 17,
                                                                color: item.status == "Success"?clC46F4E:myRed))
                                                      ])),
                                          ),
                                          item.status != "Success" ? Row(
                                            children: [
                                              Image.asset("assets/historyFail.png",scale: 22),
                                              const Text(
                                                'Failed',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 11,fontFamily: "Poppins"),
                                              ),
                                            ],
                                          ): Row(
                                            children: [
                                              Image.asset("assets/success.png",scale: 22),
                                              Image.asset("assets/historysuccess.png",scale: 4),
                                            ],
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

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      item.status == 'Success'
                                          ? Consumer<HomeProvider>(
                                          builder: (context, value, child) {
                                            return value.historyPinWard == 'ON'
                                                ? Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  donationProvider.transactionID.text = item.id;
                                                  showPinWardAlert(context, item);
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(15),
                                                      image: const DecorationImage(image: AssetImage("assets/historybgrnd.png"),fit: BoxFit.fill),
                                                      // gradient: const LinearGradient(
                                                      //     begin: Alignment.centerLeft,
                                                      //     end: Alignment.centerRight,
                                                      //     colors: [clC46F4E,clC46F4E]
                                                      // )
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    item.assembly == 'GENERAL'
                                                        ? 'Change Assembly'
                                                        : 'Change Assembly',
                                                    style: whitePoppinsBoldM12,
                                                  ),
                                                ),
                                              ),
                                            )
                                                : const SizedBox();
                                          })
                                          : const SizedBox(),


                                      SizedBox(width: 5,),
                                      item.status == 'Success'&&item.enroller=="NILL"?InkWell(
                                        onTap: (){
                                          homeProvider.addEntrollerPhoneCT.clear();
                                          beAnEnrollerAlert(context,item.amount,item.id);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              image: const DecorationImage(image: AssetImage("assets/historybgrnd.png"),fit: BoxFit.fill),
                                              // gradient: const LinearGradient(
                                              //     begin: Alignment.centerLeft,
                                              //     end: Alignment.centerRight,
                                              //     colors: [clC46F4E,clC46F4E]
                                              // )
                                          ),
                                          alignment: Alignment.center,
                                          child: Text('Map Volunteer',
                                            style: whitePoppinsBoldM12,
                                          ),
                                        ),
                                      ):SizedBox(),

                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
                    Image.asset(
                      "assets/emptybox.png",
                      scale: 1.3,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Sorry!",style: TextStyle(fontFamily: "PoppinsMedium",color: cl353535,fontSize: 16,fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(!kIsWeb
                        ? "You Don't have History data "
                        : 'Only available in mobile app',
                    style: TextStyle(fontFamily: "PoppinsMedium",color: cl353535,fontSize: 14),)
                  ],
                );
          }),
        ],
      ),
    );
  }

  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
    return d12;
  }

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        // HomeProvider homeProvider =
        // Provider.of<HomeProvider>(context, listen: false);
        // homeProvider.streamSubscriptionCancel();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(84),
            child: AppBar(
              backgroundColor: Colors.white,
              // elevation: 5.0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
              toolbarHeight: MediaQuery.of(context).size.height*0.12,
              title: Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Text('My History',style: wardAppbarTxt,),
              ),
              leading:  InkWell(
                onTap: (){
                  callNextReplacement(HomeScreenNew(),context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              // flexibleSpace: Container(
              //   height: MediaQuery.of(context).size.height*0.12,
              //   decoration: const BoxDecoration(
              //    color: Colors.white,
              //     borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(17),
              //         bottomRight: Radius.circular(17)
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 12.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         SizedBox(width: 33,),
              //         InkWell(
              //           onTap: (){
              //             callNextReplacement(HomeScreenNew(),context);
              //           },
              //           child: const Icon(
              //             Icons.arrow_back_ios,
              //             color: cl264186,
              //             size: 20,
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(left: 22.0),
              //           child: Text('My History',style: wardAppbarTxt,),
              //         ),
              //         // Row(
              //         //   children: [
              //         //     Container(
              //         //         width: 25,
              //         //         height: 25,
              //         //         decoration: const BoxDecoration(
              //         //             shape: BoxShape.circle,
              //         //             gradient: LinearGradient(
              //         //                 colors: [
              //         //                   cl14B37D,
              //         //                   cl1177BB
              //         //                 ],
              //         //                 begin: Alignment.bottomLeft,
              //         //                 end: Alignment.topRight
              //         //             )),
              //         //         child: Image.asset("assets/helpline.png",scale: 2,color: Colors.white,)),
              //         //     const SizedBox(width: 4,),
              //         //     const Text("Support",
              //         //       style: TextStyle(
              //         //         fontSize: 12,
              //         //         color: Colors.black,
              //         //         fontWeight: FontWeight.w400,
              //         //         fontFamily: "PoppinsMedium",
              //         //       ),),
              //         //   ],
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
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
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration( image: DecorationImage(
          image: AssetImage("assets/KPCCWebBackground.jpg",),
          fit:BoxFit.fill
      )),
      child: Stack(
        children: [
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
          //             width: width / 3,
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
          // ),
          Center(
            child: queryData.orientation == Orientation.portrait
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width,
                        child:SafeArea(
                          child: Scaffold(
                            //backgroundColor: Colors.yellow,
                            backgroundColor: cl_c8b3e6, //cl_c8b3e6
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              toolbarHeight: height*0.13,
                              centerTitle: true,
                              title:Text('My History',style: wardAppbarTxt,),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 12.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       // Image.asset("assets/History.png",scale: 3 ,),
                              //       // SizedBox(width: width*0.01,),
                              //
                              //     ],
                              //   ),
                              // ),
                              automaticallyImplyLeading: false,
                              leading:  InkWell(
                                onTap: (){
                                  callNextReplacement(HomeScreenNew(),context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              // actions: [
                              //   Column(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Image.asset("assets/help2.png",color: myWhite,scale: 4,),
                              //       Text("help",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 10))
                              //     ],
                              //   ),
                              //   SizedBox(width: 14,)
                              // ],

                              flexibleSpace: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [myDarkBlue,myLightBlue3]
                                  ),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25)
                                  ),
                                ),
                              ),
                            ),

                            body: body(context),
                          ),
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
                        child: SafeArea(
                          child: Scaffold(
                            //backgroundColor: Colors.yellow,
                            backgroundColor: cl_c8b3e6, //cl_c8b3e6
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              toolbarHeight: height*0.13,
                              centerTitle: true,
                              title:Text('My History',style: wardAppbarTxt,),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 12.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       // Image.asset("assets/History.png",scale: 3 ,),
                              //       // SizedBox(width: width*0.01,),
                              //
                              //     ],
                              //   ),
                              // ),
                              automaticallyImplyLeading: false,
                              leading:  InkWell(
                                onTap: (){
                                  callNextReplacement(HomeScreenNew(),context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              // actions: [
                              //   Column(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Image.asset("assets/help2.png",color: myWhite,scale: 4,),
                              //       Text("help",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 10))
                              //     ],
                              //   ),
                              //   SizedBox(width: 14,)
                              // ],

                              flexibleSpace: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [myDarkBlue,myLightBlue3]
                                  ),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25)
                                  ),
                                ),
                              ),
                            ),

                            body: body(context),
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                        'Transaction ID ${value.phonePinWard == 'ON' ? '/Phone No' : ''}',
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
                        // return (value.wards + value.newWards)
                        return (value.allWards)
                        // (value.wards+value.newWards).map((e) => PanjayathModel(e.district, e.panchayath)).toSet().toList())

                            .where((WardModel wardd) =>
                        wardd.wardName.toLowerCase().contains(
                            textEditingValue.text.toLowerCase()) ||
                            wardd.panchayath.toLowerCase().contains(
                                textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (WardModel option) => option.wardName,
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
                              !(value.wards + value.newWards).map((e) => e.wardName).contains(name)
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                            donationProvider.addPinAssembly(context, item.time, item.id, item.amount, item);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [cl1177BB,cl264186]),
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
                      //     MaterialStateProperty.all<Color>(myWhite),
                      //     backgroundColor:
                      //     MaterialStateProperty.all<Color>(myGreen),
                      //     shape:
                      //     MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      //       DonationProvider donationProvider = Provider.of<DonationProvider>(context,
                      //           listen: false);
                      //       donationProvider.addPinWard(item.time,item.id,item.amount,item);
                      //
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
  Future<AlertDialog?> beAnEnrollerAlert(BuildContext context,String amount,String PaymentId) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Center(
                child: Text("*"+"Volunteer details cannot be changed after saving ",
                  style: TextStyle(color: myRed,fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
              backgroundColor: Colors.white,
              contentPadding: const EdgeInsets.only(
                top: 10.0,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              content: Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return Container(
                        width: 400,
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10))),
                        child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical:5),
                                      child: SizedBox(
                                        height: 68,
                                        child: TextFormField(
                                            controller: value.addEntrollerPhoneCT,
                                            maxLength: 10,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: "Volunteer ID",
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 17),
                                              enabledBorder: border2,
                                              focusedBorder: border2,
                                              border: border2,

                                            ),
                                            validator: (text) {
                                              if (text!.isEmpty) {
                                                return 'Volunteer Id cannot be blank';
                                              } else if (text.length != 10) {
                                                return 'Volunteer Id Must be 10 letter';
                                              } else {
                                                return null;
                                              }
                                            }
                                        ),
                                      ),
                                    ),
                                    Consumer<HomeProvider>(
                                        builder: (context,value3,child) {
                                          return InkWell(
                                            onTap: () async {
                                              final FormState? form = _formKey.currentState;
                                              if(form!.validate()) {
                                                HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                                await homeProvider.enrollerExistCheck(value3.addEntrollerPhoneCT.text.toString());
                                                if(value3.checkEnrollerExist==false){

                                                  print("Sorry no Volunteer found");
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text("Volunteer Not Found"),
                                                    duration: Duration(milliseconds: 3000),
                                                  ));

                                                }else{

                                                  confirmationAlert(context, value3.EnrollerName, value3.addEntrollerPhoneCT.text.toString(),amount,PaymentId,value3.EnrollerPlace);

                                                }

                                              }








                                            },
                                            child: Container(
                                                height: 40,
                                                width: MediaQuery.of(context).size.width * 0.3,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(35)),
                                                    gradient: LinearGradient(
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                        colors: [clC46F4E,clC46F4E])),
                                                child: const Center(
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: myWhite,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                )),
                                          );
                                        }
                                    ),
                                  ] ),
                            )
                        )
                    );
                  }
              )
          );
        }
    );
  }
  Future<AlertDialog?> confirmationAlert(BuildContext context,String name,String phone,String amount,String paymnetID,String place) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text("Confirmation",
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.only(
            top: 15.0,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Consumer<HomeProvider>(
              builder: (context,value2,child) {
                return Container(
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 120,
                                child: Text("Volunteer ID ",style: gray12white,)),
                            Text(": ",style: gray12white,),
                            SizedBox(
                                width:width/2.8,
                                child: Text(phone,style: gray16White,)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 120,
                                child: Text("Volunteer Name ",style: gray12white,)),
                            Text(": ",style: gray12white,),
                            SizedBox(
                                width:width/2.8,
                                child: Text(name,style: gray16White,)),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 120,
                                child: Text("Volunteer Place ",style: gray12white,)),
                            Text(": ",style: gray12white,),
                            SizedBox(
                                width:width/2.8,
                                child: Text(place,style: gray16White,)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {


                              finish(context);
                            },
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(35)),
                                    // color: Color(0xff050066),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [clC46F4E,clC46F4E])
                                ),
                                child: const Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap: (){
                              HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                              homeProvider.addToEnrollList(name,phone, amount,paymnetID,place);
                              finish(context);
                              finish(context);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.blue,
                                content: Text("Added Successfully."),
                                duration: Duration(milliseconds: 3000),
                              ));
                              callNextReplacement(const HomeScreenNew(), context);


                            },
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(35)),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [clC46F4E,clC46F4E])
                                ),
                                child: const Center(
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: myWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,)
                    ],
                  ),
                );
              }
          ),
        );
      },
    );
  }
  OutlineInputBorder border2= OutlineInputBorder(
      borderSide: const BorderSide(color: myGray2),
      borderRadius: BorderRadius.circular(10));
  String newString(String oldString, int n) {
    if (oldString.length >= n) {
      return oldString.substring(oldString.length - n);
    } else {
      return '';
      // return whatever you want
    }
  }

}
getDate(String millis) {
  var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

// 12 Hour format:
  var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
  return d12;
}
