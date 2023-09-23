// Made by The Bengal Studio
// Link: https:thebengalstudio.com
// This app use for demo.

import 'package:demo_payment_esewa/feropay_demo.dart';
import 'package:demo_payment_esewa/khalti_demo.dart';
import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FreeCode(),
    );
  }
}

class FreeCode extends StatefulWidget {
  const FreeCode({super.key});

  @override
  State<FreeCode> createState() => _FreeCodeState();
}

class _FreeCodeState extends State<FreeCode> {
  String refId = '';
  String hasError = "";
  double amount = 0;
  String EsewaPayscd = "";
  String EsewaPaypid = "";
  String EsewaPaysu = "";
  String EsewaPayfu = "";






  late final TextEditingController _mobileController, _pinController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _pinController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: 'amount', labelText: 'amount'),
                  onChanged: (text) {
                    setState(() {
                      amount = double.parse(text);
                    });
                  },
                ),

                TextField(
                  decoration: InputDecoration(hintText: 'scd', labelText: 'both'),
                  onChanged: (text) {
                    setState(() {
                      EsewaPayscd = text;
                    });
                  },
                ),

                TextField(
                  decoration: InputDecoration(hintText: 'pid', labelText: 'both'),
                  onChanged: (text) {
                    setState(() {
                      EsewaPaypid = text;
                    });
                  },
                ),

                TextField(
                  decoration: InputDecoration(hintText: 'su', labelText: 'both'),
                  onChanged: (text) {
                    setState(() {
                      EsewaPaysu = text;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'fu', labelText: 'both'),
                  onChanged: (text) {
                    setState(() {
                      EsewaPayfu = text;
                    });
                  },
                ),

                EsewaPayButton(
                  paymentConfig: ESewaConfig.dev(
                    su: 'https://www.marvel.com/hello',
                    amt: amount,
                    fu: 'https://www.marvel.com/hello',
                    pid: '121ll2',
                    // scd: dotenv.env['ESEWA_SCD']!
                  ),
                  title: "Pay with Esewa Default Button Dev Mode",
                  width: 100,
                  onFailure: (result) async {
                    setState(() {
                      refId = '';
                      hasError = result;
                    });
                    if (kDebugMode) {
                      print(result);
                    }
                  },
                  onSuccess: (result) async {
                    setState(() {
                      hasError = '';
                      refId = result.refId!;
                    });
                    if (kDebugMode) {
                      print(result.toJson());
                    }
                  },
                ),

                /// Example Use case - 1
                TextButton(
                  onPressed: () async {
                    final result = await Esewa.i.init(
                        context: context,
                        eSewaConfig: ESewaConfig.dev(
                          // .live for live
                          su: 'https://www.marvel.com/hello',
                          amt: amount,
                          fu: 'https://www.marvel.com/hello',
                          pid: '1212',
                          // scd: dotenv.env['ESEWA_SCD']!
                        ));
                    // final result = await fakeEsewa();
                    if (result.hasData) {
                      final response = result.data!;
                      if (kDebugMode) {
                        print(response.toJson());
                      }
                    } else {
                      if (kDebugMode) {
                        print(result.error);
                      }
                    }
                  },
                  child: Text('Pay with Esewa Custom Button Dev Mode'),
                ),

                EsewaPayButton(
                  paymentConfig: ESewaConfig.live(
                    amt: amount,
                    scd: EsewaPayscd,
                    pid: EsewaPaypid,
                    su: EsewaPaysu,
                    fu: EsewaPayfu,
                    // scd: dotenv.env['ESEWA_SCD']!
                  ),
                  title: "Pay with Esewa Default Button Live Mode",
                  width: 100,
                  onFailure: (result) async {
                    setState(() {
                      refId = '';
                      hasError = result;
                    });
                    if (kDebugMode) {
                      print(result);
                    }
                  },
                  onSuccess: (result) async {
                    setState(() {
                      hasError = '';
                      refId = result.refId!;
                    });
                    if (kDebugMode) {
                      print(result.toJson());
                    }
                  },
                ),

                TextButton(
                  onPressed: () async {
                    final result = await Esewa.i.init(
                        context: context,
                        eSewaConfig: ESewaConfig.live(
                          amt: amount,
                          scd: EsewaPayscd,
                          pid: EsewaPaypid,
                          su: EsewaPaysu,
                          fu: EsewaPayfu,
                        ));
                    // final result = await fakeEsewa();
                    if (result.hasData) {
                      final response = result.data!;
                      if (kDebugMode) {
                        print(response.toJson());
                      }
                    } else {
                      if (kDebugMode) {
                        print(result.error);
                      }
                    }
                  },
                  child: Text('Pay with Esewa Custom Button Live Mode'),
                ),

                if (refId.isNotEmpty)
                  Text('Console: Payment Success, Ref Id: $refId'),
                if (hasError.isNotEmpty)
                  Text('Console: Payment Failed, Message: $hasError'),


                SizedBox(height: 20,),

                TextButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const KhaltiExampleApp(),
                      ),
                    );
                  },
                  child: Text('Khalti Example App'),
                ),


                SizedBox(height: 20,),

                TextButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const FonePayApp(title: "Fero Pay",),
                      ),
                    );
                  },
                  child: Text('Fero Pay Example App'),
                ),

                SizedBox(height: 200,),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<String?> _showOTPSentDialog() {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String? otp;
        return AlertDialog(
          title: const Text('OTP Sent!'),
          content: TextField(
            decoration: const InputDecoration(
              label: Text('OTP Code'),
            ),
            onChanged: (v) => otp = v,
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context, otp),
            )
          ],
        );
      },
    );
  }
}
