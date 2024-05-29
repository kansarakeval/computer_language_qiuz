class QuizModel{
  String? id,qus,A,B,C,D,category;

  QuizModel({this.id, this.qus, this.A, this.B, this.C, this.D, this.category});

  factory QuizModel.mapToModel(Map m1){
    return QuizModel(
      id: m1['id'],
      qus: m1['qus'],
      A: m1['A'],
      B: m1['B'],
      C: m1['C'],
      D: m1['D'],
      category: m1['category'],
    );
  }

}