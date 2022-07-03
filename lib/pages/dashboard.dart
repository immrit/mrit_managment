import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mrit_managment/utility/widget.dart';
import 'package:mrit_managment/utility/extention.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              child: appbarname(context.width, context.height, "داشبورد")),
          Container(
              child: Text(
            "!خبری نیست",
            style: TextStyle(fontSize: context.height * .05),
          )),
        ],
      ),
    );
  }
}
