import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VeryComplex extends StatefulWidget {
  const VeryComplex({super.key});

  @override
  State<VeryComplex> createState() => _VeryComplexState();
}

class _VeryComplexState extends State<VeryComplex> {

  var data;
  Future<void> getapi() async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode==200){
      data=jsonDecode(response.body.toString());

    }
    else{

    }

  }
  @override



  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Very Complex API'),centerTitle: true,backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
             Expanded(
               child: FutureBuilder(future: getapi(), builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Text('Looding');
                }
                else{
                  return ListView.builder(
                    itemCount: data.length,
                      itemBuilder: (context,index){
                   return Card(
                     color: Colors.blueGrey,
                      child: Column(
                        children: [
                          ReusAbleRow(title: 'name',value: data[index]['name'].toString(),),
                          ReusAbleRow(title: 'Username',value:data[index]['name'].toString(),),
                          ReusAbleRow(title: 'Email',value:data[index]['email'].toString(),),
                          ReusAbleRow(title: 'Address',value:data[index]['address']['suite'].toString(),),
                          ReusAbleRow(title: 'Phone',value:data[index]['phone'].toString(),),
                          ReusAbleRow(title: 'website',value:data[index]['website'].toString(),),

                        ],
                      ),
                   );
                      });
                }
               
               }
               ),
             )
        ],
      ),
    );
  }
}

class ReusAbleRow extends StatelessWidget {
  String title,value;
   ReusAbleRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

