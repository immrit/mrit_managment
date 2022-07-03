import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mrit_managment/pages/posts.dart';
import 'package:mrit_managment/pages/sendpost.dart';
import 'package:sidebarx/sidebarx.dart';

import '../pages/dashboard.dart';

Widget desktop_display() {
  final _controller = SidebarXController(selectedIndex: 0);

  return Scaffold(
    body: Row(
      children: [
        //
        Expanded(
          child: Center(
            child: _ScreensExample(controller: _controller),
          ),
        ),
        SidebarX(
          controller: _controller,
          theme: SidebarXTheme(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: canvasColor,
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: const TextStyle(color: Colors.white),
            selectedTextStyle: const TextStyle(color: Colors.white),
            itemTextPadding: const EdgeInsets.only(left: 30),
            selectedItemTextPadding: const EdgeInsets.only(left: 30),
            itemDecoration: BoxDecoration(
              border: Border.all(color: canvasColor),
            ),
            selectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: actionColor.withOpacity(0.37),
              ),
              gradient: const LinearGradient(
                colors: [accentCanvasColor, canvasColor],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.28),
                  blurRadius: 30,
                )
              ],
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 20,
            ),
          ),
          extendedTheme: const SidebarXTheme(
            width: 200,
            decoration: BoxDecoration(
              color: canvasColor,
            ),
            margin: EdgeInsets.only(right: 10),
          ),
          footerDivider: divider,
          headerBuilder: (context, extended) {
            return SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("سلام خوش آمدید"),
              ),
            );
          },
          items: [
            SidebarXItem(
              icon: Icons.home,
              label: 'داشبورد',
              onTap: () {
                debugPrint('Hello');
              },
            ),
            const SidebarXItem(
              icon: Icons.add,
              label: 'ارسال پست',
            ),
            const SidebarXItem(
              icon: Icons.dashboard,
              label: 'پست ها',
            ),
          ],
          showToggleButton: true,
        ),
      ],
    ),
  );
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return Dashboard();
          case 1:
            return SendPost();

          case 2:
            return BlogPage();
          default:
            return Text(
              'Not found page',
              style: theme.textTheme.headline5,
            );
        }
      },
    );
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);

final divider = Divider(color: white.withOpacity(0.3), height: 1);

class mobileDisplay extends StatefulWidget {
  const mobileDisplay({Key? key}) : super(key: key);

  @override
  State<mobileDisplay> createState() => _mobileDisplayState();
}

class _mobileDisplayState extends State<mobileDisplay> {
  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    SendPost(),
    BlogPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'داشبورد',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'ارسال پست',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'مدیریت مطالب',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}

Widget appbarname(wi, he, String text) {
  return Container(
    width: wi * .9,
    height: he * .2,
    alignment: Alignment.centerRight,
    // color: Colors.amber,
    child: Text(text,
        style: TextStyle(
          fontSize: he * .03,
          fontWeight: FontWeight.bold,
        )),
  );
}

Widget textfild(
        TextEditingController? controller, String? labelText, int mxlin) =>
    ListTile(
      title: TextField(
        maxLines: mxlin,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
