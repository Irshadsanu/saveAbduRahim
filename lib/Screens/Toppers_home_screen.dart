import 'package:bloodmoney/Screens/topMuncipalityReport.dart';
import 'package:bloodmoney/Screens/topWardReport.dart';
import 'package:bloodmoney/Screens/top_assembly_report.dart';
import 'package:bloodmoney/Screens/top_panchayath_report.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/home_provider.dart';

class ToppersHomeScreen extends StatefulWidget {
  ToppersHomeScreen({Key? key}) : super(key: key);

  @override
  State<ToppersHomeScreen> createState() => _ToppersHomeScreenState();
}

class _ToppersHomeScreenState extends State<ToppersHomeScreen>with SingleTickerProviderStateMixin {

  late TabController _tabController;

  List mainScreens = [
    const TopAssemblyReport(),
    const TopDistrictReport(),
    const TopStateReport(),
  ];

  ValueNotifier<int> screenValue = ValueNotifier(0);



  PageController _pageController = PageController();
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _tabController = TabController(length: 3, vsync: this);
      print(_tabController.index.toString()+"dlolold");
    });
  }
  @override
  Widget build (BuildContext context){
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);

    if(kIsWeb){
      return mob(context);
    }else
    {return mob(context);}
  }

  Widget mob(BuildContext context) {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(

          leading: InkWell(
              onTap: () {
                finish(context);
                // callNextReplacement(const HomeScreenNew(), context);
              },
              child: const Center(
                child: Icon(Icons.arrow_back_ios, color: myBlack),
              )
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title:  const Text(
            "Top Reports",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: myBlack,
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: TabBar(
padding: EdgeInsets.only(bottom: 10),
            controller:_tabController,
            // isScrollable: true,
            unselectedLabelColor: clC46F4E,
            // indicatorColor: bxkclr,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment(-1.00, -0.02),
                end: Alignment(1, 0.02),
                colors: [
                  clC46F4E,

                  clC46F4E,
                ],
              ), // Creates border
              // color: Colors.red
            ),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: myWhite,
            onTap: (index) {
              if (index == 2) {
                homeProvider.fetchTopStateWiseReport();
                // homeProvider.onLoader=false;
                screenValue.value = index;
              } else if (index == 1) {
                // homeProvider.onLoader=false;
                screenValue.value = index;
                homeProvider.fetchDistrictWiseReport();
                // screenValue.value = index;
                // homeProvider.fetchTopAssemblyReport();
              }else if(index == 0){
                // homeProvider.onLoader=false;
                screenValue.value = index;
                homeProvider.fetchTopAssemblyReport();
              }
            },
            tabs:  [

    const Tab(
      child: SizedBox(
        // width: 110,
        // width: MediaQuery.sizeOf(context).width*.2 ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ValueListenableBuilder(
            //     valueListenable: screenValue,
            //     builder: (context, int value, child) {
            //       return Container(
            //         // color: Colors.red,
            //         width: 28.63,
            //         height: 26.53,
            //         child: _tabController.index == 0
            //             ? Image.asset("assets/dckAssets/AssemblyImg4x.png",
            //                 color: myWhite)
            //             : Image.asset(
            //                 "assets/dckAssets/AssemblyImg4x.png",
            //                 color: cl01783B,
            //               ),
            //       );
            //     }),
            // const SizedBox(
            //   width: 2,
            // ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Assembly",
                textAlign: TextAlign.center,
                style: TextStyle(
                  // color: myWhite,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  // height: 0.26,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Tab(
      child:
      Container(
        // width: 120,
        // width: 75,
        height: 90,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ValueListenableBuilder(
            //     valueListenable: screenValue,
            //     builder: (context, int value, child) {
            //       return Container(
            //         width: 28.63,
            //         height: 26.53,
            //         child: _tabController.index == 1
            //             ? Image.asset(
            //                 "assets/dckAssets/PanchayathImg4x.png",
            //                 color: myWhite,
            //               )
            //             : Image.asset(
            //                 "assets/dckAssets/PanchayathImg4x.png",
            //                 color: cl01783B,
            //               ),
            //       );
            //     }),
            // const SizedBox(
            //   width: 2,
            // ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "District",
                textAlign: TextAlign.center,
                style: TextStyle(
                  // color: myWhite,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  // height: 0.26,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Tab(
      child:
      Container(
        // width: 90,
        height: 90,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ValueListenableBuilder(
            //     valueListenable: screenValue,
            //     builder: (context, int value, child) {
            //       return SizedBox(
            //         width: 28.63,
            //         height: 26.53,
            //         child: _tabController.index == 2
            //             ? Image.asset(
            //                 "assets/dckAssets/WardImg4x.png",
            //                 color: myWhite,
            //               )
            //             : Image.asset(
            //                 "assets/dckAssets/WardImg4x.png",
            //                 color:   cl01783B,
            //               ),
            //       );
            //     }),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "State",
                textAlign: TextAlign.center,
                style: TextStyle(
                  // color: myWhite,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  // height: 0.26,
                ),
              ),
            ),
          ],
        ),
      ),
    ),


            ],
          ),
        ),

        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,

          // onPageChanged: (index){
          //   if (index == 0) {
          //     screenValue.value = index;
          //     _tabController.index=index;
          //   } else if (index == 1) {
          //     screenValue.value = index;
          //     _tabController.index=index;
          //     homeProvider.fetchTopAssemblyReport();
          //   } else if (index == 2) {
          //     screenValue.value = index;
          //     _tabController.index=index;
          //     homeProvider.fetchTopPanchayathReport();
          //   }
          // },
          children: const [
            TopAssemblyReport(),
             TopDistrictReport(),
             TopStateReport(),
          ],
        )

      // ValueListenableBuilder(
      //     valueListenable: screenValue,
      //     builder: (context, int value, child) {
      //       return mainScreens[value];
      //     }),
    );
  }


  ///yakoob old

  // Widget mob (BuildContext context){
  //   HomeProvider homeProvider =
  //   Provider.of<HomeProvider>(context, listen: false);
  //   return Scaffold(
  //     bottomNavigationBar: Container(
  //       margin: const EdgeInsets.fromLTRB(5, 2, 5, 10),
  //       decoration: const BoxDecoration(
  //           color:Colors.white,
  //           borderRadius: BorderRadius.only(
  //               topRight: Radius.circular(15), topLeft: Radius.circular(15))),
  //       child: ValueListenableBuilder(
  //           valueListenable: screenValue,
  //           builder: (context, int newValue, child) {
  //             return GNav(iconSize: 16,
  //               tabBorderRadius: 12,
  //               // backgroundColor: Colors.red,
  //               // color: Colors.white,
  //               selectedIndex: newValue,
  //               // activeColor: Colors.white,
  //               tabBackgroundColor: clBDFFEF,
  //
  //               // tabShadow: const [
  //               //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
  //               padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               gap: 1,
  //               tabs: [
  //
  //                 GButton(
  //                   // shadow: const [
  //                   //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
  //
  //                   leading: Column(
  //                     children: [
  //                       Container(
  //                           // color: clF9F9F9,
  //                         // height:newValue==0?35:40 ,
  //                         alignment: Alignment.center,
  //                         // width: newValue==0?35:40,
  //                         child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
  //                       ),
  //                       const Center(
  //                         child: Text("Assembly",
  //                           textAlign:TextAlign.center,
  //                           style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
  //                       )
  //                     ],
  //                   ),
  //                   icon: Icons.military_tech,
  //                   iconSize: newValue==0?18:25,
  //                   onPressed: () {
  //                     screenValue.value = 0;
  //                   },
  //                 ),
  //                 GButton(
  //                   // shadow: const [
  //                   //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
  //
  //                   leading: Column(
  //                     children: [
  //                       Container(
  //                           // color: clF9F9F9,
  //                         // height:newValue==0?35:40 ,
  //                         alignment: Alignment.center,
  //                         // width: newValue==0?35:40,
  //                         child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
  //                       ),
  //                       const Center(
  //                         child: Text("District",
  //                           textAlign:TextAlign.center,
  //                           style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
  //                       )
  //                     ],
  //                   ),
  //                   icon: Icons.military_tech,
  //                   iconSize: newValue==0?18:25,
  //                   onPressed: () {
  //                     screenValue.value = 1;
  //
  //                     homeProvider.fetchDistrictWiseReport();
  //                   },
  //                 ),
  //                 GButton(
  //                   // shadow: const [
  //                   //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
  //
  //                   leading: Column(
  //                     children: [
  //                       Container(
  //                           // color: clF9F9F9,
  //                         // height:newValue==0?35:40 ,
  //                         alignment: Alignment.center,
  //                         // width: newValue==0?35:40,
  //                         child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
  //                       ),
  //                       const Center(
  //                         child: Text("State",
  //                           textAlign:TextAlign.center,
  //                           style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
  //                       )
  //                     ],
  //                   ),
  //                   icon: Icons.military_tech,
  //                   iconSize: newValue==0?18:25,
  //                   onPressed: () {
  //                     screenValue.value = 2;
  //
  //                     homeProvider.fetchTopStateWiseReport();
  //
  //                   },
  //                 ),
  //                 // GButton(
  //                 //   // shadow: const [
  //                 //   //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
  //                 //
  //                 //   leading: Column(
  //                 //     children: [
  //                 //       Container(
  //                 //           // color: clF9F9F9,
  //                 //         // height:newValue==0?35:40 ,
  //                 //         alignment: Alignment.center,
  //                 //         // width: newValue==0?35:40,
  //                 //         child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
  //                 //       ),
  //                 //       const Center(
  //                 //         child: Text("Assembly",
  //                 //           textAlign:TextAlign.center,
  //                 //           style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
  //                 //       )
  //                 //     ],
  //                 //   ),
  //                 //   icon: Icons.military_tech,
  //                 //   iconSize: newValue==0?18:25,
  //                 //   onPressed: () {
  //                 //     homeProvider.fetchTopAssemblyReport();
  //                 //     screenValue.value = 3;
  //                 //   },
  //                 // ),
  //                 // GButton(
  //                 //   // shadow: const [
  //                 //   //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
  //                 //
  //                 //   leading: Column(
  //                 //     children: [
  //                 //       Container(
  //                 //           // color: clF9F9F9,
  //                 //         // height:newValue==0?35:40 ,
  //                 //         alignment: Alignment.center,
  //                 //         // width: newValue==0?35:40,
  //                 //         child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
  //                 //       ),
  //                 //       const Center(
  //                 //         child: Text("District",
  //                 //           textAlign:TextAlign.center,
  //                 //           style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
  //                 //       )
  //                 //     ],
  //                 //   ),
  //                 //   icon: Icons.military_tech,
  //                 //   iconSize: newValue==0?18:25,
  //                 //   onPressed: () {
  //                 //     screenValue.value = 4;
  //                 //     homeProvider.fetchDistrictWiseReport();
  //                 //   },
  //                 // ),
  //
  //
  //
  //               ],
  //             );
  //           }),
  //     ),
  //     body: ValueListenableBuilder(
  //         valueListenable: screenValue,
  //         builder: (context, int value, child) {
  //           return mainScreens[value];
  //         }),
  //   );
  // }
}
