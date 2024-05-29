class CategoryModel{
  String? id,category;

  CategoryModel({this.id, this.category});

  factory CategoryModel.mapToModel(Map m1){
    return CategoryModel(
      id: m1['id'],
      category: m1['category'],
    );
  }
}