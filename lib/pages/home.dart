import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prism/models/article_model.dart';
import 'package:prism/models/categoryModel.dart';
import 'package:prism/models/slider_model.dart';
import 'package:prism/pages/articleview.dart';
import 'package:prism/pages/categoryview.dart';
import 'package:prism/services/data.dart';
import 'package:prism/services/news.dart';
import 'package:prism/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

 List<CategoryModel> categories = [];
 List<sliderModel> sliders =[];
 List<ArticleModel> articles = [];
 bool _loading = true;


 int activeindex=0;
 @override
  void initState() {
    categories= getCategories();
    getSlider();
    getnews();
    super.initState();
  }

  getnews() async{
    News newsclass = News();
    await newsclass.getNews();
    articles=newsclass.news;
    setState(() {
      _loading= false;
    });
  }

  getSlider() async{
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    
  }




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
        centerTitle: true,
        elevation: 0.0,
      ),
      body:_loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: ListView.builder(shrinkWrap: true,scrollDirection: Axis.horizontal,  itemCount: categories.length,itemBuilder: (context, index){
                  return CategoryTile(image: categories[index].image, categoryname: categories[index].categoryname,);
                }),
              ),
              SizedBox(height: 30.0,),
              Container(
                
                child: Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    children: [
                      Text("LATEST ",style: TextStyle(color: Colors.white,fontSize: 22,),),
                      Text("buZZ",style: TextStyle(color: Colors.cyanAccent,fontSize: 19,fontWeight: FontWeight.bold),),
                      
                    ],
                    
                  ),
                ),
                
              ),
              
              SizedBox(height: 20,),
              CarouselSlider.builder(itemCount: sliders.length, itemBuilder:(context,index,realIndex)
              {
                String? res = sliders[index].urlToImage;
                String? res1=sliders[index].title;
                String? res2 = sliders[index].url;
                return buildImage(res!, index, res1!, res2!);
              }, options: CarouselOptions(
                height: 250,
                autoPlay: true,
                
                enlargeCenterPage: true, 
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index,reason){
                  setState(() {
                    activeindex=index;
                  });
                }
                ),
                ),
                SizedBox(height: 16,),
                buildIndicator(),
                SizedBox(height: 25,),
        
                Container(
                
                child: Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    children: [
                      Text("TRENDING ",style: TextStyle(color: Colors.white,fontSize: 22,),),
                      Text("now",style: TextStyle(color: Colors.cyanAccent,fontSize: 19,fontWeight: FontWeight.bold),),
                      
                    ],
                    
                  ),
                ),
                
                
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Material( elevation: 3.0,borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                            
                      
                             
                      
                              
                            
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),


              

              
              SizedBox(height: 10.0,),
              Container(
                child: ListView.builder(shrinkWrap: true, physics: ClampingScrollPhysics(), itemCount: articles.length, itemBuilder: (context, index){
                  return BlogTitle( url: articles[index].url!,desc: articles[index].description!, imageUrl: articles[index].urlToImage!, title: articles[index].title!);
                }),
              )



            ],
            
            
          ),
        
          
        ),
      ),          
    );
  }
  Widget buildImage(String image,int index,String name,String url)=>GestureDetector(
    onTap:() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url),));
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
         ClipRRect(
          
          borderRadius: BorderRadius.circular(20),
          
          child: CachedNetworkImage(imageUrl: image,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
          ),
          
            Container(
              height: 300,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(top: 130),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.black45,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
              child: Text(name,maxLines: 3,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
            ),
          
      ],
      ),
      
    ),
  );
  Widget buildIndicator()=>AnimatedSmoothIndicator(activeIndex: activeindex, count: sliders.length,effect: ExpandingDotsEffect(dotHeight: 10,dotWidth: 10,activeDotColor: Colors.cyanAccent),);
}






class CategoryTile extends StatelessWidget {
  final image, categoryname;
  
   const CategoryTile({super.key, this.categoryname, this.image});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(name: categoryname),));
      },
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 16),
       child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(image,width:120,height: 60,fit: BoxFit.cover,)
            ),
            Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black26),
              
              child: Center(
                child: Text(categoryname,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
              ),
            )
        ],
       ),
      ),
    );
  }


  
}
class BlogTitle extends StatelessWidget {
  String imageUrl,title,desc,url;
  BlogTitle({super.key, required this.desc, required this.imageUrl, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(blogUrl:url ),));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Material( elevation: 3.0,borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [ 
                              
                        
                               Container( 
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(imageUrl:imageUrl,height: 150,width: 150, fit: BoxFit.cover,)),
                                ),
                                SizedBox(width: 15,),
                                Column(
                                  
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.8,
                                      child: Text(title,maxLines: 2, style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(height: 10,),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.7,
                                      child: Text(desc,maxLines: 3, style: TextStyle(color: Colors.white60,fontSize: 16,fontWeight: FontWeight.w500),),
                                    ),
                        
                                  
                                    
                                  ],
                                ),
                        
                                
                              
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
  }
}