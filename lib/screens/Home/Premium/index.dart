import 'package:flutter/material.dart';
import 'package:vb_app/screens/Home/Premium/v4/index.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<PremiumScreen> {
  // late Map<String, dynamic> _screenEventLog;

  @override
  void initState() {
    super.initState();
    // _screenEventLog = {
    //   "screen": "premium_screen",
    // };
    // GetIt.I<Analytics>().publishMessage("screen_init", _screenEventLog);
  }

  @override
  void dispose() {
    super.dispose();

    // GetIt.I<Analytics>().publishMessage("screen_dispose", _screenEventLog);
  }

  @override
  Widget build(BuildContext context) {
    return PremiumScreenV4();
  }
}
