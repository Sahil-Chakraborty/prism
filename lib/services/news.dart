import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prism/models/article_model.dart';
import 'package:http/http.dart' as http;
class News {
  List<ArticleModel> news=[];
  
  
  Future<void> getNews()async {
    String url="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=97a75cba4f9c49b0acd4a5a7ed59ffe3";

    var response= await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);


    if(jsonData['status'] == 'ok')
    {
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!= null && element['description']!=null)
        {
          ArticleModel articleModel =ArticleModel(
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          author: element["author"],
            
          );
          news.add(articleModel);
          
        }
      } );
    }
  }
}