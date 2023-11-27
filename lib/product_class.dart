import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Models/ProductsModel.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  
  Future<ProductsModel> getproductapi() async{
    final response=await http.get(Uri.parse('https://webhook.site/805eed2f-ffe4-4d57-88c8-3f4f7a945e9d'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
        return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product API'),
      centerTitle: true,backgroundColor: Colors.blueGrey,),

      body: Column(
        children: [
               Expanded(
                 child: FutureBuilder<ProductsModel>(future: getproductapi(), builder: (context,snapshot){
                   if(snapshot.hasData){
                     return ListView.builder(
                         itemCount: snapshot.data!.data!.length,
                         itemBuilder: (context,index){
                           return Column(
                             children: [
                               Container(
                                 height: MediaQuery.of(context).size.height *.3,
                                 width: MediaQuery.of(context).size.height *.1,
                                 child: ListView.builder(itemBuilder: (context,index){
                                   return Container(
                                     height: MediaQuery.of(context).size.height *.25,
                                     width: MediaQuery.of(context).size.height *.5,

                                   );
                                 }),
                               )
                             ],
                           );
                         });
                   }
                   else{
                     return Text('Loading');
                   }

                 }),
               )
        ],
      ),
    );
  }
}
