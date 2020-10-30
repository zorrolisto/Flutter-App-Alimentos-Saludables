import 'dart:async';
import 'dart:convert';

import 'package:flutter_app3/entities/ComidaSaludable.dart';
import 'package:flutter_app3/services/serviceRecipe.dart';
import 'package:html/parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

}
class _MyAppState extends State<MyApp> {
  Future<ComidaSaludable> futureComidaSaludable;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    futureComidaSaludable = fetchComidaSaludable();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    num entero = 0;
    return MaterialApp(
      title: 'Instructivo Flutter',
      theme: ThemeData.light(),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            entero++;
            futureComidaSaludable = fetchComidaSaludable();
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                entero,
                duration: const Duration(milliseconds: 400),
                curve: Curves.decelerate,
              );
            }
          },
          child: Icon(Icons.arrow_right),
        ),
        appBar: AppBar(
          title: Text(
              'Recetas Saludables App', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
                Icons.menu
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: PageView.builder(
          physics: new NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemBuilder: (context, position) {
            return FutureBuilder<ComidaSaludable>(
              future: futureComidaSaludable,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      children: [
                        foto(snapshot.data.recipes[0].image),
                        header(snapshot.data),
                        textoGrande(
                            snapshot.data.recipes[0].summary, 'Descripcion'),
                        textoGrande(snapshot.data.recipes[0].summary, 'Receta'),
                      ]
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),

      ),
    );
  }

  Widget header(ComidaSaludable header) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    header.recipes[0].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Fuente ' + header.recipes[0].creditsText.substring(0, 12),
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Icon(
                      Icons.timer,
                      color: Colors.red[500]
                  ),
                  Text(header.recipes[0].readyInMinutes.toString() + ':00'),
                ],
              ),
              Row(
                children: [
                  Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.red[500]
                  ),
                  Text(((header.recipes[0].pricePerServing) / 100 * 3.60)
                      .toString()
                      .substring(0, 5))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  String quitarHTML(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  Widget textoGrande(String text, String title) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Text(
            quitarHTML(text),
            softWrap: true,
          ),
        ],
      ),
    );
  }

  Widget foto(String url) {
    return Image.network(
        url,
        width: 600,
        height: 240,
        fit: BoxFit.cover);
  }

  Widget foto2(String url) {
    return Text(
        url
    );
  }
}