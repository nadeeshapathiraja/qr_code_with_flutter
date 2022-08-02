import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final QRKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barCode;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black45,
        body: Stack(
          alignment: Alignment.center,
          children: [
            BuildQQView(context),
            Positioned(
              bottom: 10,
              child: buildRewsult(),
            ),
            // Positioned(
            //   top: 10,
            //   child: buildControllerButtons(),
            // ),
          ],
        ),
      ),
    );
  }

  Widget BuildQQView(BuildContext context) => QRView(
        key: QRKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      controller = qrViewController;
    });

    controller?.scannedDataStream
        .listen((barCode) => setState(() => this.barCode = barCode));
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  buildRewsult() => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          barCode != null ? "Result ${barCode!.code}" : "Scan a code",
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
}
