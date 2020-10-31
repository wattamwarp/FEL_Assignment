
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http  ;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class news extends StatefulWidget {
  @override
  _newsState createState() => _newsState();
}

class _newsState extends State<news> {
   Map data;
  List userData;

  Future getData() async {
    http.Response response = await http.get("https://api2.funedulearn.com/init/demo-mails");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    print('get data');
  }

   RefreshController _refreshController =
   RefreshController(initialRefresh: false);

   void _onRefresh() async{
     // monitor network fetch
     await Future.delayed(Duration(milliseconds: 1000));
     // if failed,use refreshFailed()
     _refreshController.refreshCompleted();
   }

   void _onLoading() async{
     // monitor network fetch
     await Future.delayed(Duration(milliseconds: 1000));
     // if failed,use loadFailed(),if no data return,use LoadNodata()
     if(mounted)
       setState(() {

       });
     getData();
     _refreshController.loadComplete();
   }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child:  SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            itemCount: userData == null ? 0 : userData.length,
            itemBuilder: (context, index) {
              //MailContent mailContent = MailGenerator.getMailContent(position);
              var check = userData[index]["body"]["attachments"];
              String c="true";
              Color white=Colors.black;
              return Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 14.0, right: 14.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        size: 55.0,
                        color: Colors.pinkAccent,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "${userData[index]["from"]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                        fontSize: 17.0),
                                  ),

//                                    Container(
//                                    child: Icon(Icons.attachment_rounded,size: 15,color:white ,),
//                                    ),
                                  Text(
                                    "8:27am",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                        fontSize: 13.5),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          "${userData[index]["subject"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87,
                                            fontSize: 15.5),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.65,
                                        child: Text(
                                          "${userData[index]["body"]["message"]}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                              fontSize: 15.5),
                                        ),
                                      )
                                    ],
                                  ),
                                  Icon(Icons.star_border, size: 25.0),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ]);
            }),
        ),
      ),
    );
  }
}
