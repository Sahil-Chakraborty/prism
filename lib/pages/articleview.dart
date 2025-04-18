import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  String blogUrl;
  ArticleView({super.key, required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Text("P R I S M ",style: TextStyle(color: Colors.white,fontSize: 27,),),
            Text("news",style: TextStyle(color: Colors.cyanAccent,fontSize: 24,fontWeight: FontWeight.bold),),
          ],
        ),
        
      ),

      body: Container(
      child: WebView(
        initialUrl:widget.blogUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    ),
    );
  }
}