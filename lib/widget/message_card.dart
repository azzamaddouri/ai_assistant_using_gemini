import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const r = Radius.circular(15);
    return message.msgType == MessageType.bot
        ? Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 24,
                ),
              ),
              Container(
                  constraints: BoxConstraints(maxWidth: mq.width * .6),
                  margin: EdgeInsets.only(
                      bottom: mq.height * .02, left: mq.width * .02),
                  padding: EdgeInsets.symmetric(
                      vertical: mq.height * .01, horizontal: mq.width * .02),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).lightTextColor),
                      borderRadius: const BorderRadius.only(
                          topLeft: r, topRight: r, bottomRight: r)),
                  child: message.msg.isEmpty
                      ? const SizedBox(
                          width: 50,
                          child: SpinKitThreeBounce(
                            color: Colors.blueGrey,
                            size: 20.0,
                          ),
                        )
                      : Text(
                          message.msg,
                          textAlign: TextAlign.center,
                        ))
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  constraints: BoxConstraints(maxWidth: mq.width * .6),
                  margin: EdgeInsets.only(
                      bottom: mq.height * .02, right: mq.width * .02),
                  padding: EdgeInsets.symmetric(
                      vertical: mq.height * .01, horizontal: mq.width * .02),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).lightTextColor),
                      borderRadius: const BorderRadius.only(
                          topLeft: r, topRight: r, bottomLeft: r)),
                  child: Text(
                    message.msg,
                    textAlign: TextAlign.center,
                  )),
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
            ],
          );
  }
}
