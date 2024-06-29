import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage> {
  @override
  List products = [];

  void initState() {
    super.initState();
    getProduct();
  }
  //get product list
Future<void> getProduct()async{
 final response=await http.get(Uri.parse("https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"));
 List<dynamic> jsonData = json.decode(response.body);
    print(jsonData.length);
 if (response.statusCode == 200) {
   //print(response.statusCode);
   products =  jsonData.toList();

   //products = jsonData.map((data) => response.body).toList();
     print(products);
     //print("${products[0]["name"]}");
 } else {
   // If the server did not return a 200 OK response,
   // then throw an exception.
   print("error in api");

   throw Exception('Failed to load product');
 }
}


Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return  Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.menu,size: 20,color: Colors.white,),
        title: Text("MWS",style: TextStyle(color: Colors.white,fontSize: 20),),
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.search,size: 20,color: Colors.white),
          )
          ]

    ),

      
    body: ListView.builder(
    itemCount: products.length,
    itemBuilder: (BuildContext context, int index) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 1000,
        width: 200,
        child: Card(
        child:Column(
          children: [

      // Container(
      // decoration: BoxDecoration(
      // image: DecorationImage(
      // image: NetworkImage('https://d3t32hsnjxo7q6.cloudfront.net/i/991799d3e70b8856686979f8ff6dcfe0_ra,w158,h184_pa,w158,h184.png'),
      // fit: BoxFit.fill,
      // ),
      // ),
      // ),

       Container(height: 200,
           width: 500,
           child: Image.network('${products[index]["image_link"]}')),
 SizedBox(height: 10,),
        Container(
          child:
          Text('${products[index]["name"]}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),

        ),
        SizedBox( height: 15,),
        Container(
          child:
          Text('${products[index]["brand"]}',style: TextStyle(color: Colors.grey,fontSize: 15),),

        ),
            SizedBox( height: 15,),
            Container(
              child:
              Text('rs.${products[index]["price"]}',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),

            ),
            SizedBox( height: 15,),
            Container(
              child:
              Text('${products[index]["rating"]}',style: TextStyle(color: Colors.black,fontSize: 20),),

            ),
            SizedBox( height: 15,),
            Container(
              child:
              Text('${products[index]["description"]}',style: TextStyle(color: Colors.black,fontSize: 15),),

            ),
            Container(height: 100,
                width: 50,
                child: Image.network('${products[index]["product_api_url"]}')),
            SizedBox(height: 10,),
          ],
        ),

        ),
      ),
    );


    }
    )
    );

  }
}
