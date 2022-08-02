import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCreatePage extends StatefulWidget {
  const QRCreatePage({Key? key}) : super(key: key);

  @override
  State<QRCreatePage> createState() => _QRCreatePageState();
}

class _QRCreatePageState extends State<QRCreatePage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "QR Code Genarator",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  QrImage(
                    data: controller.text,
                    size: 250,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.done),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 3,
                          color: Colors.greenAccent,
                        ), //<-- SEE HERE
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
