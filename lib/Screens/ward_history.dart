import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloodmoney/Screens/reciept_list_page.dart';
import 'package:bloodmoney/Views/reportModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../Views/panjayath_model.dart';
import '../Views/unit_model.dart';
import '../Views/ward_model.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import 'home.dart';
import 'home_screen.dart';

class WardHistory extends StatefulWidget {
  WardHistory({Key? key}) : super(key: key);

  @override
  State<WardHistory> createState() => _WardHistoryState();
}

class _WardHistoryState extends State<WardHistory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();


  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget body(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    if(kIsWeb&&queryData.orientation != Orientation.portrait){
      width=width/3;
    }
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    DonationProvider donationProvider=Provider.of<DonationProvider>(context,listen: false);
    return Consumer<HomeProvider>(builder: (context, value, child) {
      return SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 22,),

                    // SizedBox(
                    //   width: double.infinity,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal:22),
                    //     child: Autocomplete<String>(
                    //       optionsBuilder: (TextEditingValue textEditingValue) {
                    //         return (value.districtList)
                    //             .where((String wardd) => wardd.toLowerCase()
                    //             .contains(textEditingValue.text.toLowerCase())).toList();
                    //       },
                    //       displayStringForOption: (String option) => option,
                    //       fieldViewBuilder: (
                    //           BuildContext context,
                    //           TextEditingController fieldTextEditingController,
                    //           FocusNode fieldFocusNode,
                    //           VoidCallback onFieldSubmitted
                    //           ) {
                    //
                    //         return TextField(
                    //           textAlign: TextAlign.center,
                    //           decoration:  InputDecoration(
                    //             contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    //             hintStyle: grayB12,
                    //             hintText:'Select District',
                    //             focusedBorder: border,
                    //             enabledBorder: border,
                    //             errorBorder: border,
                    //             disabledBorder:border,
                    //           ),
                    //           controller: fieldTextEditingController,
                    //           focusNode: fieldFocusNode,
                    //           style: const TextStyle(fontWeight: FontWeight.bold),
                    //         );
                    //       },
                    //       onSelected: (String selection) {
                    //         homeProvider.fetchDropdown('District', selection);
                    //       },
                    //       optionsViewBuilder: (
                    //           BuildContext context,
                    //           AutocompleteOnSelected<String> onSelected,
                    //           Iterable<String> options
                    //           ) {
                    //         return Align(
                    //           alignment: Alignment.topLeft,
                    //           child: Material(
                    //             child: Container(
                    //               width: width-30,
                    //               height: 200,
                    //               color: Colors.white,
                    //               child: ListView.builder(
                    //                 padding: const EdgeInsets.all(10.0),
                    //                 itemCount: options.length,
                    //                 itemBuilder: (BuildContext context, int index) {
                    //                   final String option = options.elementAt(index);
                    //
                    //                   return GestureDetector(
                    //                     onTap: () {
                    //                       onSelected(option);
                    //                     },
                    //                     child:  Container(
                    //                       color: Colors.white,
                    //                       height: 50,
                    //                       width: width-30,
                    //                       child: Column(
                    //                           crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                           children: [
                    //                             Text(option,
                    //                                 style: const TextStyle(
                    //                                     fontWeight: FontWeight.bold)),
                    //                             const SizedBox(height: 10)
                    //                           ]),
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //
                    //   ),
                    // ),
                    // SizedBox(height: 18,),

                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:22),
                        child: Autocomplete<String>(
                          optionsBuilder:
                              (TextEditingValue textEditingValue) {
                            return (value.stateList)
                                .where((String wardd) => wardd
                                .toLowerCase()
                                .startsWith(
                                textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (String option) => option,
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController
                              fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                hintStyle: grayB12,
                                hintText: "Select State",
                                focusedBorder: border,
                                enabledBorder: border,
                                errorBorder: border,
                                disabledBorder: border,
                              ),
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,fontSize: 15,fontFamily: "Poppins"),
                            );
                          },
                          onSelected: (String selection) {

                            print("dzfjh");
                            // homeProvider.fetchDropdown('State', selection);
                            homeProvider.fetchReportDistrict(selection);

                          },
                          optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: width - 30,
                                  height: 200,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final String option =
                                      options.elementAt(index);

                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: width - 30,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(option,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold)),
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
                        ),
                        // Autocomplete<AssemblyModel>(
                        //   optionsBuilder: (TextEditingValue textEditingValue) {
                        //     return (value.stateList)
                        //         .where((AssemblyModel wardd) => wardd.assembly.toLowerCase()
                        //         .contains(textEditingValue.text.toLowerCase()))
                        //         .toList();
                        //   },
                        //   displayStringForOption: (AssemblyModel option) => option.assembly,
                        //   fieldViewBuilder: (
                        //       BuildContext context,
                        //       TextEditingController fieldTextEditingController,
                        //       FocusNode fieldFocusNode,
                        //       VoidCallback onFieldSubmitted
                        //       ) {
                        //     WidgetsBinding.instance.addPostFrameCallback((_) {
                        //       if( value.selectedAssembly==null&&value.assemblyTc.text==''){
                        //         var initialValue = '';
                        //
                        //         fieldTextEditingController.text = initialValue;
                        //       }
                        //
                        //     });
                        //     return TextField(
                        //       textAlign: TextAlign.center,
                        //       decoration:  InputDecoration(
                        //         contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        //         hintStyle: grayB12,
                        //         hintText:'Select State',
                        //         focusedBorder: border,
                        //         enabledBorder: border,
                        //         errorBorder: border,
                        //         disabledBorder: border,
                        //       ),
                        //       onChanged: (value){
                        //         // homeProvider.onTextChanged(value,'Assembly');
                        //       },
                        //       controller: fieldTextEditingController,
                        //       focusNode: fieldFocusNode,
                        //       style: const TextStyle(fontWeight: FontWeight.bold),
                        //     );
                        //   },
                        //   onSelected: (AssemblyModel selection) {
                        //     homeProvider.fetchDropdown('Assembly', selection);
                        //   },
                        //   optionsViewBuilder: (
                        //       BuildContext context,
                        //       AutocompleteOnSelected<AssemblyModel> onSelected,
                        //       Iterable<AssemblyModel> options
                        //       ) {
                        //     return Align(
                        //       alignment: Alignment.topLeft,
                        //       child: Material(
                        //         child: Container(
                        //           width: width-30,
                        //           height: 200,
                        //           color: Colors.white,
                        //           child: ListView.builder(
                        //             padding: const EdgeInsets.all(10.0),
                        //             itemCount: options.length,
                        //             itemBuilder: (BuildContext context, int index) {
                        //               final AssemblyModel option = options.elementAt(index);
                        //
                        //               return GestureDetector(
                        //                 onTap: () {
                        //                   onSelected(option);
                        //                 },
                        //                 child:  Container(
                        //                   color: Colors.white,
                        //                   height: 50,
                        //                   width: width-30,
                        //                   child: Column(
                        //                       crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                       children: [
                        //
                        //                         Text(option.assembly, style: const TextStyle(fontWeight: FontWeight.bold)),
                        //                         const SizedBox(height: 10)
                        //
                        //                       ]),
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),

                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:22,vertical: 18),
                        child:
                        Autocomplete<DistrictDropListModel>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return (value.districtList)
                                .where((DistrictDropListModel dist) => dist.district.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (DistrictDropListModel option) => option.district,
                          fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted
                              ) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (value.selectedDistrict == null) {
                                var initialValue = '';
                                fieldTextEditingController.text =
                                    initialValue;
                              }

                            });
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration:  InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                hintStyle: grayB12,
                                hintText:'Select District',
                                focusedBorder: border,
                                enabledBorder: border,
                                errorBorder: border,
                                disabledBorder: border,
                              ),
                              onChanged: (value){
                                // homeProvider.onTextChanged(value,'Panjayath');
                              },
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,fontSize: 15,fontFamily: "Poppins"),
                            );
                          },
                          onSelected: (DistrictDropListModel selection) {
                            // homeProvider.fetchDropdown('Panjayath', selection);
                            homeProvider.fetchReportAssembly(selection);

                          },
                          optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<DistrictDropListModel> onSelected,
                              Iterable<DistrictDropListModel> options
                              ) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: width-30,
                                  height: 200,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final DistrictDropListModel option = options.elementAt(index);
                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child:  Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: width-30,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [

                                                Text(option.district, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        ),

                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:22),
                        child: Autocomplete<AssemblyDropListModel>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return (value.assemblyDropList)
                                .where((AssemblyDropListModel assem) => assem.assembly.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (AssemblyDropListModel option) => option.assembly,
                          fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted
                              ) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (value.selectedAssembly == null) {
                                var initialValue = '';
                                fieldTextEditingController.text =
                                    initialValue;
                              }

                            });
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration:  InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                hintStyle: grayB12,
                                hintText:'Select Assembly',
                                focusedBorder: border,
                                enabledBorder: border,
                                errorBorder: border,
                                disabledBorder:border,
                              ),
                              onChanged: (value){



                              },
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,fontSize: 15,fontFamily: "Poppins"),
                            );
                          },
                          onSelected: (AssemblyDropListModel selection) {
                            homeProvider.fetchDropdown(selection);
                          },
                          optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<AssemblyDropListModel> onSelected,
                              Iterable<AssemblyDropListModel> options
                              ) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: width-30,
                                  height: 200,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final AssemblyDropListModel option = options.elementAt(index);

                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child:  Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: width-30,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(option.assembly, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        ),


                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 10,),

            Consumer<HomeProvider>(
                builder: (context,value22,child) {

                  return Container(
                    width: 345,
                    height: 100,
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    decoration:  BoxDecoration(
                      image: const DecorationImage(image: AssetImage("assets/homeAmount_bgrnd.png"),fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Total: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/indian_rupee.png",
                                  scale: 45,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 3),
                                SizedBox(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 100.0,
                                      maxWidth: 200.0,
                                      minHeight: 30.0,
                                      maxHeight: 30.0,
                                    ),
                                    child: AutoSizeText(
                                      value.filter ? getAmount(double.parse(value.filterCollection.toStringAsFixed(0))) : getAmount(double.parse(value.totalCollection.toStringAsFixed(0))),
                                      style: greenB16,
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ],
                        ),



                        ///2024 asif commented

                        // Consumer<HomeProvider>(
                        //     builder: (context,val,child) {
                        //       return  val.panchayathPosterComplete?ElevatedButton(
                        //           onPressed: () {
                        //             DonationProvider donationProvider =
                        //             Provider.of<DonationProvider>(
                        //                 context,
                        //                 listen: false);
                        //             donationProvider.whatsappStatus =
                        //             null;
                        //
                        //             callNextReplacement(PanchayathPosterPageScreen(district: val.panchayathPosterDistrict, assembly: val.panchayathPosterAssembly, panchayath: val.panchayathPosterPanchayath), context);
                        //
                        //
                        //
                        //
                        //           },
                        //           style: ElevatedButton.styleFrom(
                        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        //             backgroundColor: const Color(0xff02A710),
                        //             primary: Colors.transparent,
                        //             onSurface: Colors.transparent,
                        //             shadowColor: Colors.transparent,
                        //             minimumSize: const Size(136, 30),
                        //           ),
                        //           child: const Text(
                        //             "Download Panchayath Quota Poster",
                        //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        //           )):val.panchayathPosterNotCompleteComplete?ElevatedButton(
                        //           onPressed: () {
                        //
                        //           },
                        //           style: ElevatedButton.styleFrom(
                        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        //             backgroundColor: Colors.red,
                        //             primary: Colors.transparent,
                        //             onSurface: Colors.transparent,
                        //             shadowColor: Colors.transparent,
                        //             minimumSize: const Size(136, 30),
                        //           ),
                        //           child: const Text(
                        //             "Panchayath Quota not Completed yet",
                        //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        //           )):SizedBox();
                        //     }
                        // )





                        ///2024 asif commented

                      ],
                    ),
                  );
                }
            ),

            ListView.builder(
                shrinkWrap: true,
                itemCount: value.assemblyTotalList.length,

                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var item = value.assemblyTotalList[index];
                  return InkWell(
                    onTap: (){
                      if( item.assembly.isNotEmpty) {
                        print("click hhhheee");
                        value.paymentDetailsList.clear();
                        value.currentAssemblyLimit = 50;
                        value.fromReportAssembly = item;

                        homeProvider.assemblyReceiptList(item, 50);
                        homeProvider.assemblyReceiptListWithoutLimit(item);
                        // donationProvider.fetchOrganiznCollectedCount(item.panchayath,item.wardname);
                        callNext(ReceiptListPage(from: "WardPage",total: item.amount.toString(),state: item.state,district: item.district,assembly: item.assembly,target: '', ), context);

                      }else{
                        final snackBar = SnackBar(
                            backgroundColor:Colors.blue ,
                            duration: const Duration(milliseconds: 3000),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 5,),
                                Text("Please pick a valid Unit", textAlign: TextAlign.center,softWrap: true,
                                  style: snackbarStyle,
                                ),
                              ],
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 5),
                      elevation: 3,
                      child: Container(
                        // height: 107,
                        // margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              fit:FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.assembly,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 13,
                                          color:clC46F4E,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    Text(
                                      item.district,
                                      style: black12,
                                    ),
                                    Text(
                                      item.state,
                                      style: black12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SizedBox(
                                  height: 28,
                                  // width: 120,
                                  // color: Colors.red,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '₹',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        style: black55,
                                      ),
                      
                                      SizedBox(
                                        height: 27,
                                        // width: 95,
                                        //color: Colors.black,
                                        child: Row(
                                          children: [
                                            Text(
                                              getAmount(item.amount),
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18,
                                                  color:clC46F4E,
                                                  fontWeight: FontWeight.w700
                                              ),
                                            ),
                                            // item.amount>=num.parse(item.target)?SizedBox(width: 5,):SizedBox(),
                                            // item.amount>=num.parse(item.target)?Image.asset(
                                            //   "assets/image 1.png",
                                            //   height: 18,
                                            //   width: 18,
                                            // ):SizedBox(),
                                          ],
                                        ),
                                      ),
                      
                                    ],
                                  )
                      
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      );
    });
  }

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          // backgroundColor:myWhite,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(84),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
               leading: InkWell(
              onTap: (){
                callNextReplacement(HomeScreenNew(),context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: myBlack,
                size: 20,
              ),
            ),
              shape: const RoundedRectangleBorder(
                  borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
              toolbarHeight: height*0.12,
              title:   Text(
                  "Report",
                  textAlign: TextAlign.center,
                  style: wardAppbarTxt
              ),
              // flexibleSpace: Container(
              //   height: MediaQuery.of(context).size.height*0.12,
              //   decoration: const BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(17),
              //         bottomRight: Radius.circular(17)
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 8.0),
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
              //           child: Text(
              //             "Report",
              //             style: wardAppbarTxt,
              //           ),
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
              //
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
                  // SizedBox(width: width/3,),
                  SizedBox(
                    width: width,
                    child: SafeArea(
                      child: Scaffold(
                        backgroundColor:myWhite,
                        appBar: AppBar(
                          // backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          toolbarHeight: height*0.13,
                          centerTitle: true,
                          title:Text('Report',style: wardAppbarTxt,),
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
                  // SizedBox(width: width/3,),
                ],
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: width/3,),
                  SizedBox(
                    width: width / 3,
                    child: SafeArea(
                      child: Scaffold(
                        backgroundColor:myWhite,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          toolbarHeight: height*0.13,
                          centerTitle: true,
                          title:Text('Report',style: wardAppbarTxt,),
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
                  // SizedBox(width: width/3,),
                ],
              ))
        ],
      ),
    );
  }
}
String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
  formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}

final OutlineInputBorder border=OutlineInputBorder(
  borderSide: const BorderSide(
      color:clD4D4D4 , width: 1.0),
  borderRadius: BorderRadius.circular(28),
);