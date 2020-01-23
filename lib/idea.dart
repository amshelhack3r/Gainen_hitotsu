import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
final String ideaId = '_id';
final String columnDescription = 'description';
final String columnUsers = 'users';
final String columnCategory = 'category';
final String columnDeveloped = 'developed';
final String columnPeriod = 'period';

final String tableLanguages = 'languages';
final String languageId = '_id';
final String columnLanguageTitle = 'title';
final String languageForeign = 'idea_id';

final String tableImportance = 'importance';
final String importanceId = '_id';
final String columnImportanceTitle = 'title';
final String importanceForeign = 'idea_id';


class IdeaProvider{
  Database db;

  Future init() async{
    Directory directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'ideas.db');

    db = await openDatabase(path, version: 1, 
          onCreate: (Database db, int version)async{
            var sql = """
                  CREATE TABLE $tableIdea(
                    $ideaId INTEGER PRIMARY KEY AUTOINCREMENT,
                    $columnDescription TEXT NOT NULL,
                    $columnUsers INTEGER NOT NULL,
                    $columnCategory TEXT NOT NULL,
                    $columnDeveloped TEXT NOT NULL,
                    $columnPeriod TEXT NOT NULL
                  ) 
            """;

            var languageSql = """
                  CREATE TABLE $tableLanguages(
                    $languageId INTEGER PRIMARY KEY AUTOINCREMENT,
                    $columnLanguageTitle TEXT NOT NULL,
                    $languageForeign INTEGER NOT NULL,

                    FOREIGN KEY($languageForeign) REFERENCES $tableIdea($ideaId)
                  )""";
            
            
            var importanceSql = """
                  CREATE TABLE $tableImportance(
                    $importanceId INTEGER PRIMARY KEY AUTOINCREMENT,
                    $columnImportanceTitle TEXT NOT NULL,
                    $importanceForeign INTEGER NOT NULL,
                    FOREIGN KEY($importanceForeign) REFERENCES $tableIdea($ideaId)
                  )""";

            

            await db.execute(sql);
            await db.execute(languageSql);
            await db.execute(importanceSql);
          }); 
  }


  Future<Idea> insertIdea(Idea idea) async{}

  Future<List<Idea>> getIdeas() async{}

  Future<Idea> getIdea(int id) async{}

  Future<int> deleteIdea(int id)async{}
}