import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mrit_managment/utility/extention.dart';
import 'package:mrit_managment/utility/widget.dart';
import '../model/postmodel.dart';
import 'package:http/http.dart' as http;

import 'editepost.dart';
import 'sendpost.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late Future<Post> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(children: [
      appbarname(wi, he, "مدیریت مطالب"),
      Container(
          width: double.infinity,
          height: he * .65,
          // color: Colors.amber,
          margin: EdgeInsets.all(15),
          // color: Colors.amber,
          child: FutureBuilder<Post>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.data != null) {
                print(snapshot.data);
                return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      String title = utf8.decode(
                          base64.decode(snapshot.data!.data![index].title!));
                      String descript = utf8.decode(
                          base64.decode(snapshot.data!.data![index].descript!));
                      return Card(
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ListTile(
                                title: Text(title),
                                subtitle: Text(descript),
                                leading: InkWell(
                                    onTap: () => setState(() {
                                          deltrecord(
                                              snapshot.data!.data![index].id!);
                                        }),
                                    child: Container(
                                      child: Icon(Icons.delete),
                                    )),
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        final contrller = MainFormContrller();
                                        late Future<Post> _futureAlbum;

                                        @override
                                        void initState() {
                                          super.initState();
                                          _futureAlbum = fetchAlbum();
                                        }

                                        return AlertDialog(
                                          title: Text("ویرایش پست"),

                                          //content

                                          content: Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: textfild(
                                                        contrller.title,
                                                        "موضوع",
                                                        1)),
                                                Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: textfild(
                                                        contrller.descript,
                                                        "...بنویسید",
                                                        6)),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    child: SizedBox(
                                                      width: context.width * .8,
                                                      child: Container(
                                                          width: context.width *
                                                              1.0,
                                                          // margin:
                                                          //     EdgeInsets.symmetric(horizontal: context.width * .3),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child:
                                                                    FloatingActionButton
                                                                        .extended(
                                                                  backgroundColor:
                                                                      Colors.red[
                                                                          400],
                                                                  elevation:
                                                                      0.0,
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  label: Text(
                                                                      "انصراف"),
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child:
                                                                    FloatingActionButton
                                                                        .extended(
                                                                  backgroundColor:
                                                                      Colors.green[
                                                                          400],
                                                                  elevation:
                                                                      0.0,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      _futureAlbum = updaterecord(
                                                                          title = contrller
                                                                              .title!
                                                                              .text,
                                                                          descript = contrller
                                                                              .descript!
                                                                              .text);
                                                                    });
                                                                  },
                                                                  label: Text(
                                                                      "ویرایش"),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              )));
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const Center(child: Text("پستی وجود نداری :)"));
            },
          ))
    ]));
  }

  Future<Post> fetchAlbum() async {
    final response = await http.get(Uri.parse('https://imrit.ir/api/view.php'));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> deltrecord(String id) async {
    try {
      var res = await http
          .post(Uri.parse('https://imrit.ir/api/delete.php'), body: {"id": id});
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("record delete");
      } else {
        print("some issues");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Post> updaterecord(String descript, String title) async {
    final response = await http.put(
      Uri.parse('https://imrit.ir/api/update.php'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: jsonEncode(<String, String>{
        "title": base64.encode(utf8.encode(title)),
        "descript": base64.encode(utf8.encode(descript)),
      }),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }
}
