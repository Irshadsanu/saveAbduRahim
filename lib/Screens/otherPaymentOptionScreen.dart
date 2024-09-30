import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
const desktopUserAgent =
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36";
const user_agent =     'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
class OtherPaymentOptionScreen extends StatefulWidget {
  String? apiurl,orderId,from;
  OtherPaymentOptionScreen({Key? key,required this.apiurl,required this.orderId,required this.from}) : super(key: key);

  @override
  State<OtherPaymentOptionScreen> createState() => _OtherPaymentOptionScreenState();

}


class _OtherPaymentOptionScreenState extends State<OtherPaymentOptionScreen> {
  WebViewPlusController? _controller;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);

    print(widget.from.toString()+"dnbjhad");

    // donationProvider.getBankResponseHDFC(context, widget.paymentId!);
    donationProvider.listenForPayment(widget.orderId!,context,);



    final settings = InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          userAgent: desktopUserAgent,/// pass your user agent
          allowFileAccessFromFileURLs: true,
          allowUniversalAccessFromFileURLs: true,
          useOnDownloadStart: true,
          mediaPlaybackRequiresUserGesture: true,
        ));

    final contextMenu = ContextMenu(
      options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
    );


    print("alltime run");

    return WillPopScope(
      onWillPop: () async {
        // _controller!.webViewController.goBack();

        return false;
      },
      child: SafeArea(
          child: Stack(
            children: [

              widget.from=="QR"?InAppWebView(

                initialUrlRequest: URLRequest(url: Uri.parse(widget.apiurl!)),
                initialOptions: settings,
                contextMenu: contextMenu,
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                  setState(() {
                    // print("hereewise111"+widget.apiurl!);
                    isLoading=false;
                    // print("hereewise2222"+widget.apiurl!);
                  });
                },



              ):
              WebViewPlus(
                initialUrl:Uri.parse(widget.apiurl!).toString() ,

                userAgent: 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',

                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (NavigationRequest request)
                {
                  if (true)
                  {
                    print('blocking navigation to $request}');
                    donationProvider.launchUrlUPI(context, Uri.parse(request.url));
                    return NavigationDecision.prevent;
                  }

                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageFinished: (s){
                  setState(() {
                    // print("hereewise111"+widget.apiurl!);
                    isLoading=false;
                    // print("hereewise2222"+widget.apiurl!);
                  });
                },
                debuggingEnabled: false,
                // onWebViewCreated: (controller) {
                //   print("hereewise2222");
                //   print("hereewise2222"+widget.apiurl!);
                //   _controller=controller;
                //   controller.loadUrl(widget.apiurl!);
                //
                // },


              ),
              isLoading ? const Center( child: CircularProgressIndicator(),) : Container(),
            ],
          )
      ),
    );
  }

  exitAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      backgroundColor: Colors.white,
      actions: [
        SizedBox(
          width: 400,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sorry",
                style: black16,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Please Upload Photo First",
                      style: black16,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      finish(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 40,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                        gradient:  const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ clC46F4F, clC46F4F,]
                        ),
                      ),
                      child:  Text(
                        "Cancel",
                        style: white16,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      finish(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 40,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25),
                        // gradient:  const LinearGradient(
                        //     begin: Alignment.centerLeft,
                        //     end: Alignment.centerRight,
                        //     colors: [ cl3B5E2D, cl709449,]
                        // ),
                      ),
                      child:  Text(
                        "Ok",
                        style: white16,
                      ),
                    ),
                  ),

                ],
              )
            ],
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


}
