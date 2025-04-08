
import 'package:prism/models/categoryModel.dart';

List<CategoryModel> getCategories() 
{
  List<CategoryModel> category =[];
  CategoryModel categoryModel= CategoryModel();

  categoryModel.categoryname= "Business";
  categoryModel.image= "images/business.png";
  category.add(categoryModel);
  categoryModel=CategoryModel();

  categoryModel.categoryname= "General";
  categoryModel.image= "images/general.png";
  category.add(categoryModel);
  categoryModel=CategoryModel();

  categoryModel.categoryname= "Sports";
  categoryModel.image= "images/sports.png";
  category.add(categoryModel);
  categoryModel=CategoryModel();

  categoryModel.categoryname= "Entertainment";
  categoryModel.image= "images/party.png";
  category.add(categoryModel);
  categoryModel=CategoryModel();

  categoryModel.categoryname= "Health";
  categoryModel.image= "images/health.png";
  category.add(categoryModel);
  categoryModel=CategoryModel();

  categoryModel.categoryname= "Science";
  categoryModel.image= "images/science.png";
  category.add(categoryModel);
  categoryModel=CategoryModel();


  return category;

}