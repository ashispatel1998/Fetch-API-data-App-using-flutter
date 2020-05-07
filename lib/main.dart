import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main(){
  runApp(MaterialApp(
    home: Homepage(),
    debugShowCheckedModeBanner: false,
  ));
}
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
   Map data;
   List userdata;

  Future getData() async{
    http.Response response= await http.get("https://reqres.in/api/users?page=2");
    // debugPrint(response.body); -->print result in debug
    data=json.decode(response.body); // convert to json data

    setState(() {
      userdata=data["data"];
    });
    //debugPrint(userdata.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("User Profile"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
          itemCount: userdata==null?0:userdata.length,
          itemBuilder: (BuildContext context,int index){
            return Card(
              color: Colors.blueGrey[50],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(userdata[index]["avatar"]),
                      radius: 26.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("${userdata[index]["first_name"]} ${userdata[index]["last_name"]}\n${userdata[index]["email"]}",
                      style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w700,),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}
