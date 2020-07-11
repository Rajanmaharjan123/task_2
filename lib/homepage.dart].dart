import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_2/Apiserviceprovider.dart';
import 'package:task_2/response.dart';
import 'package:task_2/Data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiServiceProvider _apiServiceProvider = new ApiServiceProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("TASK 2",style: TextStyle(fontSize: 18,color: Colors.cyan.shade200,fontWeight: FontWeight.bold),),
        ),
        body: FutureBuilder<Response>(
          future: _apiServiceProvider.getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Data> list = snapshot.data.data;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    Data user = list[index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                        shadowColor: Colors.grey,
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: user.avatar,
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.cover),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center
                                ,
                                children: [
                                  Text(user.firstName + " " + user.lastName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black,),),
                                  Text(user.email,style: TextStyle(color: Colors.grey.shade400),),

                                ],
                              ),

                              Spacer(),
                              IconButton(icon: Icon(Icons.email),
                                onPressed: () {
                                  launch('mailto:${user.email}');
                                },
                                color: Colors.cyan,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

}
