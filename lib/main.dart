import 'package:flutter/material.dart';
import 'package:mrit_managment/utility/widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sidebarx/sidebarx.dart';

import 'pages/sendpost.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          final _controller = SidebarXController(selectedIndex: 0);

          return desktop_display();
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return desktop_display();
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return mobileDisplay();
        }

        return Container(color: Colors.purple);
      },
    );
  }
}
