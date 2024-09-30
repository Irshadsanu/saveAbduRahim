import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloodmoney/providers/donation_provider.dart';
import 'package:bloodmoney/providers/web_provider.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:whatsapp_share/whatsapp_share.dart';




import 'constants/my_colors.dart';

class TestPage extends StatefulWidget {
   TestPage({Key? key}) ;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myLightOrangeNewUI,
      body: Center(
        child: Column(
          children: [
            Screenshot(
              controller: _screenshotController,
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  InkWell(
                    onTap: () async {



                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      color: Colors.pink,
                      child: const Center(child: Text("Click here to loop",style: TextStyle(color: Colors.white,fontSize: 15),)),
                    ),
                  ),

                  InkWell(
                    onTap: () async {




                    },
                    child: Container(

                      height: 100,
                      width: 100,
                      color: Colors.green,
                      child: Text("aesss"),
                    ),
                  )
                ],
              ),
            ),

            InkWell(
              onTap: () async {
                setState(() async {
                  Directory? directory;
                  if (Platform.isAndroid) {
                    directory = await getExternalStorageDirectory();
                  } else {
                    directory = await getApplicationDocumentsDirectory();
                  }
                  final String? localPath = '${directory?.path}/${DateTime.now().millisecondsSinceEpoch}.png';

                  await _screenshotController.captureAndSave(localPath!);

                  await Future.delayed(const Duration(seconds: 2));

                  await WhatsappShare.shareFile(
                    phone: '9539039327',
                    filePath: [localPath],
                  );

                });







              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.yellow,
                child: Text("shree"),
              ),
            )
          ],
        ),
      ),
    );
  }

   Future<void> launchUrlUPI(BuildContext context, Uri _url) async {
     if (!await launchUrl(_url)) {
       throw 'Could not launch $_url';
     } else {


     }
   }
}

