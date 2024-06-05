import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomBtn({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 0,
            backgroundColor: Theme.of(context).buttonColor,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            minimumSize: Size(mq.width * .4, 50)),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
