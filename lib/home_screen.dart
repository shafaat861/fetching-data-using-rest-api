import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/postman.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<ModelName> postList=[];
  Future<List<ModelName>> getPostApi () async{

    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
   var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      postList.clear();

      for (Map<String, dynamic> i in data) {
        postList.add(ModelName.fromJson(i));
      }

    
    return postList;

    }
    else{
      return postList;

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fetching Free API'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getPostApi(),
                builder: (context,snapshort) {
                  if (!snapshort.hasData) {
                   return Text('looding data');
                  }
                  else {
                    return ListView.builder(
                      itemCount: postList.length,
                        itemBuilder: (context,index)
                        {
                          return Card(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Title',style: TextStyle(fontSize: 15,color: Colors.red,fontWeight: FontWeight.bold),),
                              Text(postList[index].title.toString(),style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold)),
                                  Text('Description',style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.bold),),
                                  Text(postList[index].body.toString(),style: TextStyle(fontSize: 10,color: Colors.greenAccent,fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          );
                        }
                    );
            
                  }
                }
            ),
          )

        ],
      ),
    );
  }
}
