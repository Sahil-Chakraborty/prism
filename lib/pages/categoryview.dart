import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prism/models/categoryModel.dart';
import 'package:prism/models/show_category.dart';
import 'package:prism/pages/articleview.dart';
import 'package:prism/services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories =[];
  bool _loading= true;
  @override
  void initState() {
    
    super.initState();
    getnews();
  }
  

 getnews() async{
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getcategorieNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading= false;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: 
          
          
           
            
            Text(widget.name,style: TextStyle(color: Colors.cyanAccent,fontSize: 24,fontWeight: FontWeight.bold),),
          
        
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(shrinkWrap: true, physics: ClampingScrollPhysics(), itemCount: categories.length, itemBuilder: (context, index){
                  return ShowCategory( Image: categories[index].urlToImage!,desc: categories[index].description!,title: categories[index].title!,url: categories[index].url!,);
                }),
              )
      );
    
  }
}
class ShowCategory extends StatelessWidget {
  String Image,desc,title,url;
  ShowCategory({super.key, required this.Image, required this.title, required this.desc,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url),));
      },
      child: Container(
        margin: EdgeInsets.symmetric(),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(imageUrl:Image, width: MediaQuery.of(context).size.width,height: 200,fit: BoxFit.cover, )),
              SizedBox(height: 5,),
            Text(title,maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            Text(desc,maxLines: 3,),
            SizedBox(height: 18,)
          ],
        ),
      ),
    );
  }
}