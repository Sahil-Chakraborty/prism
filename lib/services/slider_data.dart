import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prism/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:prism/models/slider_model.dart';
class Sliders {
  List<sliderModel> sliders=[];
  
  
  Future<void> getSlider()async {
    String url="https://newsapi.org/v2/everything?q=India&language=en&pageSize=10&apiKey=97a75cba4f9c49b0acd4a5a7ed59ffe3";

    var response= await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);


    if(jsonData['status'] == 'ok')
    {
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!= null && element['description']!=null)
        {
          sliderModel slidermodel =sliderModel(
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          author: element["author"],
            
          );
          sliders.add(slidermodel);
          
        }
      } );
      sliders = sliders.take(10).toList();
    }
  }
}