import 'package:bloodmoney/providers/web_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/my_colors.dart';
import 'constants/text_style.dart';

class DetailsWithPhone extends StatelessWidget {
  const DetailsWithPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebProvider webProvider =
    Provider.of<WebProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return Scaffold(
      body: Container(
        color: lightBlue,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: myWhite
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back_ios,color: myGradient5,),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 90,
                      width: width/3,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Consumer<WebProvider>(
                            builder: (context, value, child) {
                              return TextField(
                                controller: value.phoneController,
                                decoration: InputDecoration(
                                  fillColor: myWhite,
                                  filled: true,
                                  hintText: 'Transaction ID',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: primary),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: primary),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                ),
                                onChanged: (item) {
                                  // if (item.trim().length==13) {
                                  //   webProvider.getIdDetails(item.trim(),context);
                                  // }
                                  // webProvider.getIdDetails(item.trim(),context);
                                },
                              );
                            }),
                      ),
                    ),
                    Consumer<WebProvider>(
                        builder: (context,value,child) {
                          return InkWell(
                            onTap: () {
                              webProvider.getPhoneNumber(value.phoneController.text.trim(),);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: myWhite
                              ),
                              child: const Center(
                                child: Icon(Icons.search,color: myGradient5,),
                              ),

                            ),
                          );
                        }
                    )
                  ],
                ),
                const SizedBox(height: 20,),

                SingleChildScrollView(
                  child: Column(
                    children: [

                      Consumer<WebProvider>(
                          builder: (context,value,child) {
                            return SizedBox(
                              child: ListView.builder(
                                  itemCount:value.getPhoneNumberList.length,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    var item = value.getPhoneNumberList[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(left:20,right:20,top: 5,bottom: 5),
                                      child: Container(
                                        height: 80,
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
                                                SelectableText(
                                                  item.tid.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: myBlack3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing:Column(
                                              children: [
                                                Text(item.status.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                                Text("₹"+item.amount.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                              ],
                                            )
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
              ],
            ),
          ),
        ),
      ),

    );
  }
}
