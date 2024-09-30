import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/gradientTextClass.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class TopStateReport extends StatelessWidget {
  const TopStateReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget mobile(context) {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return SafeArea(
      child: Scaffold(
          // appBar:  PreferredSize(
          //   preferredSize: const Size.fromHeight(84),
          //   child: AppBar(
          //     automaticallyImplyLeading: false,
          //     backgroundColor: Colors.white,
          //     elevation: 5,
          //     shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
          //     flexibleSpace: Container(
          //       height: height*0.12,
          //       decoration: const BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17))
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.only(top: 18.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             const SizedBox(width: 33,),
          //             InkWell(
          //                 onTap: (){
          //                   callNextReplacement(const HomeScreenNew(), context);
          //                 },
          //                 child: const Icon(Icons.arrow_back_ios_outlined,color: cl264186,size: 20,)),
          //
          //             Padding(
          //               padding: const EdgeInsets.only(left: 22.0),
          //               child: Text('Top 10 State',style: wardAppbarTxt),
          //             ),
          //
          //
          //           ],),
          //       ),
          //     ),
          //
          //   ),
          // ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<HomeProvider>(builder: (context, value, child) {
                  return value.topStateModelList.isNotEmpty?ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.topStateModelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<Color> border = [];
                        border = homeProvider.getcolors(index);
                        var item = value.topStateModelList[index];
                        return
                          Padding(
                          padding: const EdgeInsets.only(left:10,right:10,top: 5,bottom: 5),
                          child: Container(
                            width: double.infinity,
                            height:75,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage('assets/homeAmount_bgrnd.png',),fit: BoxFit.fill,
                              ),
                              // borderRadius: BorderRadius.all(Radius.circular(15)),

                            ),

                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      width:75,
                                      height:75,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      child: Image.asset('assets/leaderBadge.png',scale: .5),
                                    ),
                                    Positioned(
                                        top:23,
                                        left: index+1>=100?24:26,
                                        child: SizedBox(width: 25,
                                            child: Center(child: Text((index+1).toString(),style:
                                            TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:12),)))),
                                  ],
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10,),

                                        SizedBox(
                                          // width:125,
                                          child: Text(
                                            item.state.toString(),
                                            style:  TextStyle(
                                                fontSize: width*0.035,
                                                color: Colors.white,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),




                                        const SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 20.8),
                                    alignment: Alignment.centerRight,
                                    width: width*.26,
                                    // color: Colors.orange,
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          const Text("₹ ",
                                            style: TextStyle(
                                                color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),),
                                          Text(getAmount(double.parse(item.stateAmount.toStringAsFixed(0))),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18,
                                                color: Colors.white,fontFamily: "Poppins"),),
                                        ],
                                      ),
                                    )
                                )
                              ],
                            ),

                          ),
                        );

                      }):Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: Center(child: CircularProgressIndicator()),
                      );
                }),
                // Consumer<HomeProvider>(
                //     builder: (context,value2,child) {
                //       return Visibility(
                //         visible:value2.totalOther>0 ,
                //         child: Padding(
                //           padding: const EdgeInsets.only(
                //               left: 10.0, right: 10, bottom: 10),
                //           child: Container(
                //             alignment: Alignment.center,
                //             height: 65,
                //             decoration: BoxDecoration(
                //                 color: myWhite,
                //                 borderRadius: const BorderRadius.all(Radius.circular(15)),
                //                 border: Border.all(color: c_Grey, width: 0.1)),
                //             child: ListTile(
                //               leading: Container(
                //                 decoration: BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     gradient: LinearGradient(
                //                       colors: [
                //                         Color(0xFF78FFD6),
                //                         Color(0xFFAAEED9)
                //                       ],
                //                       begin: Alignment.topRight,
                //                       end: Alignment.bottomLeft,
                //                     )),
                //                 child: CircleAvatar(
                //                   radius: 18,
                //                   backgroundColor: Colors.transparent,
                //                   child: Image.asset("assets/newAssets/DistrictIcon.png",scale: 4,),
                //                 ),
                //               ),
                //               title: Text(
                //                 "Other",
                //                 style: const TextStyle(
                //                     color: myBlack,
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               trailing: Container(
                //                   alignment: Alignment.centerRight,
                //                   width: width * .30,
                //                   //  color: Colors.blue,
                //                   child: GradientText(
                //                     "₹" +
                //                         value2.totalOther.toStringAsFixed(0).toString(),
                //                     gradient: LinearGradient(
                //                         begin: Alignment.topCenter,
                //                         end: Alignment.bottomCenter,
                //                         colors: [
                //                           Color(0xFF78FFD6),
                //                           Color(0xFFAAEED9)
                //                         ]),
                //                     style: const TextStyle(
                //                         fontFamily: "Montserrat",
                //                         fontSize: 17,
                //                         fontWeight: FontWeight.w700),
                //                   )),
                //             ),
                //           ),
                //         ),
                //       );
                //     }
                // )
              ],
            ),
          )),
    );
  }

  Widget web(context) {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/KPCCWebBackground.jpg",
              ),
              fit: BoxFit.fill)),
      child: Center(
        child: queryData.orientation == Orientation.portrait
            ? Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: width,
                child: SafeArea(
                  child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(height * 0.12),
                        child: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.white,
                          elevation: 0,
                          flexibleSpace: Container(
                            height: height * 0.12,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [cl1177BB,cl264186]),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                InkWell(
                                  onTap: () {
                                    callNextReplacement(HomeScreenNew(), context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.2,
                                ),
                                // Image.asset(
                                //   "assets/District page.png",
                                //   color: myWhite,
                                //   scale: 4,
                                // ),
                                const Text(
                                  ' District Report',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: width * 0.2,
                                ),
                                // Image.asset(
                                //   "assets/help2.png",
                                //   color: myWhite,
                                //   scale: 4,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            Consumer<HomeProvider>(builder: (context, value, child) {
                              return ListView.builder(
                                  padding: const EdgeInsets.only(top: 10),
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: value.districtWiseReportList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    List<Color> border = [];
                                    border = homeProvider.getcolors(index);
                                    var item = value.districtWiseReportList[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10, bottom: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 65,
                                        decoration: BoxDecoration(
                                            color: myWhite,
                                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                                            border: Border.all(color: c_Grey, width: 0.1)),
                                        child: ListTile(
                                          leading: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    border[0],
                                                    border[1],
                                                  ],
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                )),
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: Colors.transparent,
                                              child: Image.asset("assets/newAssets/DistrictIcon.png",scale: 4,),
                                            ),
                                          ),
                                          title: Text(
                                            item.district,
                                            style: const TextStyle(
                                                color: myBlack,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Container(
                                              alignment: Alignment.centerRight,
                                              width: width * .30,
                                              //  color: Colors.blue,
                                              child: GradientText(
                                                "₹" +
                                                    item.districtAmount
                                                        .toStringAsFixed(0)
                                                        .toString(),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      border[0],
                                                      border[1],
                                                    ]),
                                                style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700),
                                              )),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                            Consumer<HomeProvider>(
                                builder: (context,value2,child) {
                                  return Visibility(
                                    visible:value2.totalOther>0 ,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10, bottom: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 65,
                                        decoration: BoxDecoration(
                                            color: myWhite,
                                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                                            border: Border.all(color: c_Grey, width: 0.1)),
                                        child: ListTile(
                                          leading: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF78FFD6),
                                                    Color(0xFFAAEED9)
                                                  ],
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                )),
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: Colors.transparent,
                                              child: Image.asset("assets/newAssets/DistrictIcon.png",scale: 4,),
                                            ),
                                          ),
                                          title: Text(
                                            "Other",
                                            style: const TextStyle(
                                                color: myBlack,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Container(
                                              alignment: Alignment.centerRight,
                                              width: width * .30,
                                              //  color: Colors.blue,
                                              child: GradientText(
                                                "₹" +
                                                    value2.totalOther.toStringAsFixed(0).toString(),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color(0xFF78FFD6),
                                                      Color(0xFFAAEED9)
                                                    ]),
                                                style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700),
                                              )),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            )
                          ],
                        ),
                      )),
                )),
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
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(height * 0.12),
                        child: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.white,
                          elevation: 0,
                          flexibleSpace: Container(
                            height: height * 0.12,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [myDarkBlue, myLightBlue3]),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                    callNextReplacement(HomeScreenNew(), context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.08,
                                ),
                                // Image.asset(
                                //   "assets/District page.png",
                                //   color: myWhite,
                                //   scale: 4,
                                // ),
                                const Text(
                                  ' District Report',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                // Image.asset(
                                //   "assets/help2.png",
                                //   color: myWhite,
                                //   scale: 4,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            Consumer<HomeProvider>(builder: (context, value, child) {
                              return ListView.builder(
                                  padding: const EdgeInsets.only(top: 10),
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: value.districtWiseReportList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    List<Color> border = [];
                                    border = homeProvider.getcolors(index);
                                    var item = value.districtWiseReportList[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10, bottom: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: myWhite,
                                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                                            border: Border.all(color: c_Grey, width: 0.1)),
                                        child: ListTile(
                                          leading: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    border[0],
                                                    border[1],
                                                  ],
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                )),
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: Colors.transparent,
                                              child: Image.asset("assets/newAssets/DistrictIcon.png",scale: 4,),
                                            ),
                                          ),
                                          title: Text(
                                            item.district,
                                            style: const TextStyle(
                                                color: myBlack,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Container(
                                              alignment: Alignment.centerRight,
                                              width: 150,
                                              // color: Colors.blue,
                                              child: GradientText(
                                                "₹" +
                                                    item.districtAmount
                                                        .toStringAsFixed(0)
                                                        .toString(),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      border[0],
                                                      border[1],
                                                    ]),
                                                style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700),
                                              )),
                                        ),
                                      ),
                                    );
                                  });

                              //old design
                              //   Column(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //         GridView.builder(
                              //         padding: const EdgeInsets.all(15),
                              //         physics: const ScrollPhysics(),
                              //         shrinkWrap: true,
                              //         gridDelegate:
                              //         const SliverGridDelegateWithFixedCrossAxisCount(
                              //         mainAxisSpacing: 5,
                              //         crossAxisSpacing: 5,
                              //         childAspectRatio: 1,
                              //         crossAxisCount: 3,
                              //         mainAxisExtent: 130
                              //         ),
                              //         itemCount: value.districtWiseReportList.length,
                              //         itemBuilder:
                              //         (BuildContext context, int index) {
                              //          Color border1=homeProvider.getcolors(index);
                              //           var item = value.districtWiseReportList[index];
                              //           return Stack(
                              //             children: [
                              //               Container(
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.all(3.0),
                              //                   child: Column(
                              //                     children: [
                              //                       SizedBox(height: 20,),
                              //                       InkWell(
                              //                         onTap:(){
                              //                           callNext(WardHistory(), context);
                              //                         },
                              //                         child: Container(
                              //                             height: 100,
                              //                             width: 100,
                              //                             decoration: BoxDecoration(
                              //                               shape: BoxShape.circle,
                              //                               // borderRadius: const BorderRadius.all(
                              //                               //     Radius.circular(50)),
                              //                               border: Border.all(
                              //                                 color: border1,
                              //                                 width: 2,
                              //                               ),
                              //
                              //                               color: myWhite,
                              //                             ),
                              //                             child: Padding(
                              //                               padding: const EdgeInsets.all(10.0),
                              //                               child: Column(
                              //                                   mainAxisAlignment: MainAxisAlignment.center,
                              //                                   crossAxisAlignment: CrossAxisAlignment.center,
                              //                                   children:  [
                              //                                     // Image.asset(
                              //                                     //   'assets/Contribute icon.png',
                              //                                     //   height: 50,
                              //                                     //   width: 50,
                              //                                     // ),
                              //                                     Text(
                              //                                       item.district,
                              //                                       style: const TextStyle(
                              //                                           color: myBlack,
                              //                                           fontSize: 12,
                              //                                           fontWeight: FontWeight.bold),
                              //                                     ),
                              //                                     SizedBox(height: 5,),
                              //                                     Text(
                              //                                       item.districtAmount.toStringAsFixed(0),
                              //                                       style: const TextStyle(
                              //                                           color: myBlack,
                              //                                           fontSize: 20,
                              //                                           fontWeight: FontWeight.bold),
                              //                                     ),
                              //                                     // Text(
                              //                                     //   amountInWords[index],
                              //                                     //   style: const TextStyle(
                              //                                     //       color: gold_b7950e,
                              //                                     //       fontFamily: "Heebo"),
                              //                                     // )
                              //                                   ]),
                              //                             )),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //               Positioned(
                              //                   left: 40,
                              //                   top: 12,
                              //                   child: Image.asset(
                              //                     "assets/District_icon.png",
                              //                     scale: 2.5,
                              //                   )),
                              //             ],
                              //           );
                              //         }),
                              //
                              //   ],
                              // );
                            }),
                            Consumer<HomeProvider>(
                                builder: (context,value2,child) {
                                  return Visibility(
                                    visible:value2.totalOther>0 ,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10, bottom: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 65,
                                        decoration: BoxDecoration(
                                            color: myWhite,
                                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                                            border: Border.all(color: c_Grey, width: 0.1)),
                                        child: ListTile(
                                          leading: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF78FFD6),
                                                    Color(0xFFAAEED9)
                                                  ],
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                )),
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: Colors.transparent,
                                              child: Image.asset("assets/newAssets/DistrictIcon.png",scale: 4,),
                                            ),
                                          ),
                                          title: Text(
                                            "Other",
                                            style: const TextStyle(
                                                color: myBlack,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Container(
                                              alignment: Alignment.centerRight,
                                              width: width * .30,
                                              //  color: Colors.blue,
                                              child: GradientText(
                                                "₹" +
                                                    value2.totalOther.toStringAsFixed(0).toString(),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color(0xFF78FFD6),
                                                      Color(0xFFAAEED9)
                                                    ]),
                                                style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700),
                                              )),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            )
                          ],
                        ),
                      )),
                )),
          ],
        ),
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