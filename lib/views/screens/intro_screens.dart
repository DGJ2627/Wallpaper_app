import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class intro_screens extends StatefulWidget {
  const intro_screens({super.key});

  @override
  State<intro_screens> createState() => _intro_screensState();
}

class _intro_screensState extends State<intro_screens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
      ),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            image: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCXFDu1FjrH6GOWOMoXc-2OvLkLRKYr8VZFg&usqp=CAU",),
            title: "Goku",
            body: "MUI",
          ),
          PageViewModel(
            image: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_SIByO2HF_d2WxDtEHVBbg4bt_usSYG2pkw&usqp=CAU"),
            title: "Vegita ",
            body: "Sayain Prince 👑",
          ),
          PageViewModel(
            image: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnvfHVL43S27B4mVrJKKeUXDJS6_A3V2H46A&usqp=CAU"),
            title: "😈 Black Goku 🖤",
            body: "",
          ),
        ],
        showBackButton: false,
        showNextButton: true,
        back: const Icon(CupertinoIcons.back),
        overrideNext: const Text(""),
        done: const Text("Done"),
        onDone: () async {
          Navigator.of(context).pushNamed('homepage');
          SharedPreferences pref = await SharedPreferences.getInstance();

          pref.setBool("intro_completed", true);
        },
      ),
    );
  }
}
