class Idea{
  String description;
  List<String> category;
  List<String> importance;
  DateTime developed;
  DateTime period;
  List<String> languages;
  int users;


  Idea(this.description, this.users){
    this.developed = DateTime.now();
    this.period = this.developed.add(Duration(days:60));
    this.languages = List();
    this.category= List.from(["android application", "web application", "static website", "scraper"], growable: true );
    this.users = 1;
    
  }

}

final String tableIdea = 'idea';
final String columnId = '_id';
final String columnDescription = 'description';
final int columnUsers = 'users';
final String columnCategory = 'category';
final String columnDeveloped = 'developed';
final String columnPeriod = 'period';