import 'dart:async';

import 'package:flutter/material.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'JohanneTraiteur',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'JohanneTraiteur App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> products = [];

  Future getProducts() async {

    /// Initialize the API
    WooCommerceAPI wcapi = new WooCommerceAPI(
        "http://fatoudiagne.com",
        "ck_2465c09ebe5bdaf1d989bb57f2fd3cedc8b86dc4",
        "cs_bde8183e7074dac0b2f9e3394607b812e5922d74"
    );
    
    /// Get data using the endpoint
    var p = await wcapi.getAsync("products");
    return p;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (_, s){

          if(s.data == null){
            return Container(
              child: Center(
                child: Text("Loading..."),
              ),
            );
          }

          return ListView.builder(
            itemCount: s.data.length,
            itemBuilder: (_, index){
            
            /// create a list of products
              return ListTile(
                leading: CircleAvatar(
                  child: Image.network(s.data[index]["images"][0]["src"]),
                ),
                title: Text(s.data[index]["name"]),
                subtitle: Text("Buy now for \€ " + s.data[index]["price"]),
              );

            }
          );
        },
      ),
    );
  }
}