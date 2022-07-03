import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:mrit_managment/utility/widget.dart';
import 'package:mrit_managment/utility/extention.dart';

class SendPost extends StatefulWidget {
  late MainFormContrller _contrller;
  MainForm() {
    _contrller = MainFormContrller();
  }

  SendPost({key});

  @override
  State<SendPost> createState() => _SendPostState();
}

class _SendPostState extends State<SendPost> {
  final contrller = MainFormContrller();

  late bool error, sending, success;
  late String msg;

  String phpurl = "https://imrit.ir/api/write.php";

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(phpurl), body: {
      "title": base64.encode(utf8.encode(contrller.title!.text)),
      "descript": base64.encode(utf8.encode(contrller.descript!.text)),
    });

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        contrller.title!.text = "";
        contrller.descript!.text = "";

        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      child: ListView(
        children: [
          ListTile(leading: appbarname(wi, he, "ارسال مطالب")),
          Container(
            alignment: Alignment.centerRight,

            child: Text(error ? msg : "لطفا فیلد ها را پر کنید"),
            //if there is error then sho msg, other wise show text message
          ),
          Container(
            alignment: Alignment.centerRight,

            child: Text(success
                ? "با موفقیت ارسال شد"
                : "...هرچه در ذهن دارید بریزید بیرون"),
            //is there is success then show "Write Success" else show "send data"
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: textfild(contrller.title, "موضوع", 1)),
          Container(
              padding: EdgeInsets.all(10),
              child: textfild(contrller.descript, "...بنویسید", 6)),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: SizedBox(
                width: context.width * .05,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: wi * .3),
                  child: Container(
                    height: context.height * .25,
                    width: context.width * .5,
                    alignment: Alignment.topCenter,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.grey[400],
                      elevation: 0.0,
                      onPressed: () {
                        setState(() {
                          sending = true;
                        });
                        sendData();
                        mamad();
                      },
                      label: Text(
                        sending ? "کمی صبر کنید..." : "ارسال مطلب",
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    ));
  }

  void mamad() {
    String mamad = base64.encode(utf8.encode("ممد"));
    print(utf8.decode(base64.decode(mamad)));
  }
}

class MainFormContrller {
  TextEditingController? title;
  TextEditingController? descript;

  MainFormContrller() {
    title = TextEditingController();
    descript = TextEditingController();
  }
}
