import 'package:flutter/foundation.dart';
import 'package:fonepay_flutter/fonepay_flutter.dart';
import 'package:flutter/material.dart';


class FonePayApp extends StatefulWidget {
  const FonePayApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FonePayApp> createState() => _FonePayAppState();
}

class _FonePayAppState extends State<FonePayApp> {
  String refId = '';
  String hasError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Example Use case - 1
            FonePayButton(
              paymentConfig: FonePayConfig.dev(
                amt: 10.0,
                r2: 'https://www.marvel.com/hello',
                ru: 'https://www.marvel.com/hello',
                r1: 'qwq',
                prn: 'PD-2-${FonePayUtils.generateRandomString(len: 2)}',
              ),
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
                  refId = result.uid!;
                });
                if (kDebugMode) {
                  print(result.toJson());
                }
              },
            ),

            /// Example Use case - 2
            TextButton(
              onPressed: () async {
                final result = await FonePay.i.init(
                    context: context,
                    fonePayConfig: FonePayConfig.dev(
                      amt: 10.0,
                      r2: 'https://www.marvel.com/hello',
                      ru: 'https://www.marvel.com/hello',
                      r1: 'qwq',
                      prn: 'PD-2-${FonePayUtils.generateRandomString(len: 2)}',
                    ));
                if (result.hasData) {
                  final response = result.data!;
                  setState(() {
                    hasError = '';
                    refId = response.uid!;
                  });
                  if (kDebugMode) {
                    print(response.toJson());
                  }
                } else {
                  setState(() {
                    refId = '';
                    hasError = result.error!;
                  });
                  if (kDebugMode) {
                    print(result.error);
                  }
                }
              },
              child: const Text('Pay with FonePay'),
            ),
            if (refId.isNotEmpty)
              Center(
                  child: Text('Console: Payment Success, Ref Id: $refId',
                      textAlign: TextAlign.center)),
            if (hasError.isNotEmpty)
              Center(
                  child: Text(
                    'Console: Payment Failed, Message: $hasError',
                    textAlign: TextAlign.center,
                  )),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}