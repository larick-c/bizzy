import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProfileFeed extends StatefulWidget {
  const ProfileFeed({super.key});

  @override
  State<ProfileFeed> createState() => _ProfileFeedState();
}

class _ProfileFeedState extends State<ProfileFeed> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: const Column(
          children: <Widget>[
            Expanded(
              flex: 15,
              child: Image(
                image: AssetImage('assets/icon/profile.png'),
              ),
            ),
          ],
        ));
  }
}
