import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class LeadReport extends StatelessWidget {
   LeadReport({Key? key}) : super(key: key);


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
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(84),
          child: AppBar(

          leading: InkWell(
          onTap: () {
                finish(context);
                // callNextReplacement(const HomeScreenNew(), context);
              },
              child: const Center(
              child: Icon(Icons.arrow_back_ios, color: myBlack),
              )
              ),
              backgroundColor: Colors.white,
              toolbarHeight: height*0.12,
              elevation: 0,
              centerTitle: true,
              title:   Text(
              "Leader Board",
              textAlign: TextAlign.center,
              style: wardAppbarTxt
              ),),
        ),


        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return SizedBox(
                              child: ListView.builder(
                                  itemCount:value.topLeadlist.length,
                                  // itemCount:15,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    var item = value.topLeadlist[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(left:20,right:20,top: 5,bottom: 5),
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(right: 10),
                                        decoration: const BoxDecoration(
                                          // color: Colors.white,
                                            image: DecorationImage(
                                                image: AssetImage('assets/homeAmount_bgrnd.png'),fit: BoxFit.fill,
                                            ),
                                          borderRadius: BorderRadius.all(Radius.circular(15)),

                                        ),

                                        child: Row(
                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                          Stack(
                                            children: [
                                              SizedBox(
                                                width:80,
                                                height:80,
                                                // color:myLightRedNewUI,
                                                child: Padding(
                                                  padding:  const EdgeInsets.only(bottom: 14.5,top: 5),
                                                  child: SizedBox(
                                                    width: 60,
                                                    child:
                                                        Image.asset('assets/leaderBadge.png',scale: 2,),
                                                  ),
                                                ),
                                              ),

                                              Positioned(
                                                  top:18,
                                                  left: 28.5,
                                                  child: SizedBox(width: 25,
                                                      child: Center(child: Text((index+1).toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:15),)))
                                              ),
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
                                                  Container(width:134,
                                                    // color: Colors.yellow,
                                                    child: item.nameStatus=="NO"?
                                                    Text("Confidential Donor",
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: width*0.035,
                                                          color: Colors.white,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.bold),):Text(
                                                      item.name.toString(),
                                                      maxLines: 2,
                                                      style:  TextStyle(
                                                           fontSize: width*0.033,
                                                          color: Colors.white,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                   SizedBox(
                                                     width:115,
                                                     child: Text(
                                                      item.state,
                                                      style:  TextStyle(
                                                          fontSize: width*0.025,
                                                          color: Colors.white,
                                                          fontFamily: 'PoppinsMedium',
                                                        fontWeight: FontWeight.w500
                                                          ),
                                                  ),
                                                   ),
                                                  SizedBox(
                                                     width:115,
                                                     child: Text(
                                                      item.district,
                                                      style:  TextStyle(
                                                          fontSize: width*0.025,
                                                          color: Colors.white,
                                                          fontFamily: 'PoppinsMedium',
                                                        fontWeight: FontWeight.w500
                                                          ),
                                                  ),
                                                   ),
                                                  SizedBox(
                                                     width:100,
                                                     child: Text(
                                                      item.assembly,
                                                      style:  TextStyle(
                                                          fontSize: width*0.025,
                                                          color: Colors.white,
                                                          fontFamily: 'PoppinsMedium',
                                                        fontWeight: FontWeight.w500
                                                          ),
                                                  ),
                                                   ),
                                                  const SizedBox(height: 10,),
                                                ],
                                              ),
                                      ),
                                         ),

                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: width*.25,
                                             // color: Colors.orange,
                                                child: FittedBox(
                                                  child: Row(
                                                    children: [
                                                      const Text("₹ ",
                                                        style: TextStyle(
                                                            color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),),

                                                      Text(getAmount(double.parse(item.totalAMount.toStringAsFixed(0))),
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 18,
                                                          color: Colors.white,fontFamily: "PoppinsMedium"),),
                                                    ],
                                                  ),
                                                )
                                            )

                                          ],
                                        ),

                                      ),
                                    );

                                  }),
                            );
                          }
                        ),


              ],
            ),
          ),
        ) ,
      ),
    );
  }


  Widget web(context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration( image: DecorationImage(
          image: AssetImage("assets/KPCCWebBackground.jpg",),
          fit:BoxFit.fill
      )),
      child: SafeArea(
        child: Center(
          child: queryData.orientation == Orientation.portrait?
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(height*0.12),
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      toolbarHeight: height*0.13,
                      centerTitle: true,
                      title: Text('Lead',style: wardAppbarTxt,),
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
                      //       const Text("help",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 10))
                      //     ],
                      //   ),
                      //   const SizedBox(width: 15,)
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
                    // AppBar(
                    //   // actions: [Icon(Icons.qr_code)],
                    //   automaticallyImplyLeading: false,
                    //   // leading: Icon(Icons.arrow_back_ios_outlined),
                    //   backgroundColor: Colors.white,
                    //   elevation: 0,
                    //   // title: Center(child: Text('My Contribution')),
                    //   flexibleSpace: Container(
                    //     height: height*0.12,
                    //     decoration: BoxDecoration(
                    //         gradient: LinearGradient(
                    //             begin: Alignment.centerLeft,
                    //             end: Alignment.centerRight,
                    //             colors: [secondary,primary]
                    //         ),
                    //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:  Radius.circular(30))
                    //
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         SizedBox(width: width*0.03,),
                    //         Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
                    //         SizedBox(width: width*0.3,),
                    //         Image.asset( "assets/leadicon.png",scale: 20,),
                    //         SizedBox(width: 5,),
                    //         Column(
                    //           children: [
                    //             SizedBox(height:40,),
                    //             Text('Lead',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                    //           ],
                    //         ),
                    //         SizedBox(width: width*0.3,),
                    //
                    //         Image.asset("assets/help2.png",color: myWhite,scale: 4,
                    //         ),
                    //       ],),
                    //   ),
                    //
                    // ),
                  ),


                  body:SingleChildScrollView(
                    child: Column(
                      children: [

                        Consumer<HomeProvider>(
                            builder: (context,value,child) {
                              return SizedBox(
                                child: ListView.builder(
                                    itemCount:value.topLeadlist.length,
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      var item = value.topLeadlist[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(left:20,right:20,top: 5,bottom: 5),
                                        child: Container(
                                          height: 65,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                                            border: Border.all(
                                              color: secondary,
                                              width:1,
                                            ),
                                          ),
                                          child:  ListTile(
                                              leading:  Stack(
                                                children: [
                                                  Container(
                                                    width:48,
                                                    height:55,

                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/leadicon.png"),
                                                          fit: BoxFit.fill),


                                                    ),
                                                  ),
                                                  Positioned(
                                                      top:25,
                                                      left: 22,

                                                      child: Text((index+1).toString(),style: const TextStyle(color: myBlack,fontWeight: FontWeight.bold),))

                                                ],
                                              ),
                                              title:Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.name.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: myBlack3,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  Text(
                                                    item.district+","+item.assembly,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: myBlack3,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailing:Text("₹"+item.totalAMount.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                                          ),
                                        ),
                                      );

                                    }),
                              );
                            }
                        ),


                      ],
                    ),
                  ) ,
                ),
              ),
            ],
          )
          :Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width/3,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(height*0.12),
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      toolbarHeight: height*0.13,
                      centerTitle: true,
                      title: Text('Lead',style: wardAppbarTxt,),
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
                      //       const Text("help",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 10))
                      //     ],
                      //   ),
                      //   const SizedBox(width: 15,)
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
                    // AppBar(
                    //   // actions: [Icon(Icons.qr_code)],
                    //   automaticallyImplyLeading: false,
                    //   // leading: Icon(Icons.arrow_back_ios_outlined),
                    //   backgroundColor: Colors.white,
                    //   elevation: 0,
                    //   // title: Center(child: Text('My Contribution')),
                    //   flexibleSpace: Container(
                    //     height: height*0.12,
                    //     decoration: BoxDecoration(
                    //         gradient: LinearGradient(
                    //             begin: Alignment.centerLeft,
                    //             end: Alignment.centerRight,
                    //             colors: [secondary,primary]
                    //         ),
                    //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:  Radius.circular(30))
                    //
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         SizedBox(width: width*0.03,),
                    //         Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
                    //         SizedBox(width: width*0.3,),
                    //         Image.asset( "assets/leadicon.png",scale: 20,),
                    //         SizedBox(width: 5,),
                    //         Column(
                    //           children: [
                    //             SizedBox(height:40,),
                    //             Text('Lead',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                    //           ],
                    //         ),
                    //         SizedBox(width: width*0.3,),
                    //
                    //         Image.asset("assets/help2.png",color: myWhite,scale: 4,
                    //         ),
                    //       ],),
                    //   ),
                    //
                    // ),
                  ),


                  body:SingleChildScrollView(
                    child: Column(
                      children: [

                        Consumer<HomeProvider>(
                            builder: (context,value,child) {
                              return SizedBox(
                                child: ListView.builder(
                                    itemCount:value.topLeadlist.length,
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      var item = value.topLeadlist[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(left:20,right:20,top: 5,bottom: 5),
                                        child: Container(
                                          height: 65,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                                            border: Border.all(
                                              color: secondary,
                                              width:1,
                                            ),
                                          ),
                                          child:  ListTile(
                                              leading:  Stack(
                                                children: [
                                                  Container(
                                                    width:48,
                                                    height:55,

                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/leadicon.png"),
                                                          fit: BoxFit.fill),


                                                    ),
                                                  ),
                                                  Positioned(
                                                      top:25,
                                                      left: 22,

                                                      child: Text((index+1).toString(),style: const TextStyle(color: myBlack,fontWeight: FontWeight.bold),))

                                                ],
                                              ),
                                              title:Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.name.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: myBlack3,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  Text(
                                                    item.district+","+item.assembly,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: myBlack3,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailing:Text("₹"+item.totalAMount.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                                          ),
                                        ),
                                      );

                                    }),
                              );
                            }
                        ),


                      ],
                    ),
                  ) ,
                ),
              ),
            ],
          ),
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
