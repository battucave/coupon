
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'camScanCodeQR.dart';




class GenerateQrScreen extends StatefulWidget {
  const GenerateQrScreen({Key? key}) : super(key: key);

  @override
  _GenerateQrScreenState createState() => _GenerateQrScreenState();
}

class _GenerateQrScreenState extends State<GenerateQrScreen> {

  String codeQrInformation = "BOL: Coupns information Here";



  showQRCode(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            content: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(1)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: const Text(
                              'Coupon QRCode',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    QrImage(
                                      data: codeQrInformation,
                                      version: QrVersions.auto,
                                      size: 200.0,
                                    ),
                                  ],
                                )
                              ]),
                          Container(
                            //child: Image.asset('assets/png/qrCode.png', height: 180,),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                        ],
                      ),
                    ),
                  ),
                ])),
          ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, bottom: 20, top: 70),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      showQRCode(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Colors.green,
                      ),
                      padding: const EdgeInsets.all(12),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.28,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.43,
                      child: const Center(
                        child: Text(
                          "TAP TO GENERATE QRCODE",
                          textAlign: TextAlign.center,
                          style:TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                          ),


                        ),
                      ),


                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScanScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.28,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.43,
                        child: const Center(
                          child: Text(
                            "TAP TO SCAN \nQRCODE",
                            textAlign: TextAlign.center,
                            style:TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),


                          ),
                        ),

                      )
                  )
                ],
              ),
            ),


          ],
        )

    );
  }
}




