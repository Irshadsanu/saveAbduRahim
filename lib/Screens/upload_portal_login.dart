import 'package:bloodmoney/Screens/receiptlist_monitor_screen.dart';
import 'package:bloodmoney/Screens/upload_excel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import '../providers/web_provider.dart';
class UploadLogIn extends StatelessWidget {
   UploadLogIn({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: SizedBox(

          width: 300,
          child: Form(

            key: _formKey ,

            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<WebProvider>(

                  builder: (context,value,child) {
                    return TextFormField(
                      validator: (txt){
                        if(txt!.isEmpty||txt!=value.password){
                          return 'Please Enter Valid Password';
                        }else{
                          return null;
                        }
                      },
                    );
                  }
                ),

                Padding(

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
                        donationProvider.fetchAssembly();
                        callNext(UploadExcel(), context);
                      }
                    },
                    child: Text(
                      'Log in',
                      style: white16,
                    ),
                  ),
                ),
                // Consumer<HomeProvider>(
                //     builder: (context,value,child) {
                //       return Padding(
                //         padding: const EdgeInsets.all(16.0),
                //         child: ElevatedButton(
                //           child: const Text("Live Transactions",),
                //           onPressed: () {
                //             value.currentLimit = 50;
                //             value.fetchReceiptListForMonitorApp(50);
                //             callNext( ReceiptListMonitorScreen(), context);
                //           },
                //         ),
                //       );
                //     }
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
