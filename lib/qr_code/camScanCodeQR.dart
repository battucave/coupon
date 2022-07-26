import 'dart:convert';
import 'dart:io';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';




class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {


  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: const BuildQrView(),
                ),

              ],
            ),
          ),
        )
      //  ),
    );

  }
}

class BuildQrView extends StatefulWidget {
  const BuildQrView({Key? key}) : super(key: key);

  @override
  _BuildQrViewState createState() => _BuildQrViewState();
}

class _BuildQrViewState extends State<BuildQrView> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');



  void successScan( Barcode? result){
    setState(() {

      showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
          barrierDismissible: true,
          context: context,
          builder: (_) {
            return Dialog(
              // The background color
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                      const Text(
                        "QR data: ",
                        textAlign: TextAlign.center,
                        style:TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),),
                const SizedBox(height: 20,),
                        Text(
                          "${result!.code}",
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          ),),
                    ],)

                  ],
                ),
              ),
            );
          });
    });

  }
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }


  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Widget _buildQr(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 350 ||
        MediaQuery.of(context).size.height < 350)
        ? 120.0
        : 280.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.grey,
          borderRadius: 20,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }




  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      print("test $scanData");
      setState(() {
        result = scanData;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pop(context);
        successScan(scanData);

      });



    });

  }




  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQr(context)),
        ],
      ),
    );
  }
}




