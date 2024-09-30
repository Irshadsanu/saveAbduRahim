import 'package:bloodmoney/providers/web_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetReport extends StatelessWidget {
  const GetReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Consumer<WebProvider>(
          builder: (context,value,child) {
            return InkWell(
              onTap: (){

                value.fetchExcelFireStoreForReport(context, 1712557800000, 1712521800000);

              },
              child: Container(
                height: 100,
                width: 110,
                color: Colors.red,

                child: Center(child: Text("get report")),
              ),
            );
          }
        ),
      ),

    );
  }
}
