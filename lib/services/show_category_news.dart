import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prism/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:prism/models/show_category.dart';
import 'package:prism/models/slider_model.dart';
class ShowCategoryNews {
  List<ShowCategoryModel> categories=[];
  
  
  Future<void> getcategorieNews(String category)async {
    String url="https://newsapi.org/v2/everything?q=India+AND+$category&apiKey=97a75cba4f9c49b0acd4a5a7ed59ffe3";

    var response= await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);


    if(jsonData['status'] == 'ok')
    {
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!= null && element['description']!=null)
        {
          ShowCategoryModel categorymodel =ShowCategoryModel(
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          author: element["author"],
            
          );
          categories.add(categorymodel);
          
        }
      } );
    }
  }
}