import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:date_format/date_format.dart';

class Idea {
  int _id;
  String name;
  String description;
  String category;
  List<String> importance;
  DateTime _developed;
  DateTime _period;
  List<String> languages;
  String users;

  Idea(this.name, this.description, this.category, this.users, this.languages) {
    this._developed = DateTime.now();
    this._period = this._developed.add(Duration(days: 14));
  }

  String get developed{
    return formatDate(_developed, [dd, '/', mm, '/', yyyy]);
  }

  String get period{
    return formatDate(_period, [dd, '/', mm, '/', yyyy]);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "users": users,
      "category": category,
      "developed": formatDate(_developed, [yyyy, '-', mm, '-', dd]),
      "period": formatDate(_period, [yyyy, '-', mm, '-', dd])
    };
  }

  Idea.fromMap(Map<String, dynamic> map) {
    _id = map['_id'];
    name = map['name'];
    description = map['description'];
    users = map['users'];
    category = map['category'];
    _developed = DateTime.parse(map['developed']);
    _period = DateTime.parse(map['period']);
  }

  @override
  String toString() =>
      'Ideales $_id name:$name description: $description category: $category users:$users languages: $languages' ;
}

final String tableIdea = 'idea';
final String ideaId = '_id';
final String columnName = 'name';
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

class IdeaProvider {
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    var databasePath = await getDatabasesPath();

    var path = join(databasePath, 'ideas.db');
    print(databasePath);

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      var ideaSql = """
                  CREATE TABLE $tableIdea(
                    $ideaId INTEGER PRIMARY KEY AUTOINCREMENT,
                    $columnName TEXT NOT NULL,
                    $columnDescription TEXT NOT NULL,
                    $columnUsers TEXT NOT NULL,
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

      await db.transaction((action) async {
        await action.execute(ideaSql);
        await action.execute(languageSql);
        await action.execute(importanceSql);
      });
    }, onDowngrade: (Database db, int version, int something) async {
      await deleteDatabase(path);
    });
  }

  Future<Idea> insertIdea(Idea idea) async {
    final db = await database;
    idea._id = await db.insert(tableIdea, idea.toMap());
    
    for (var language in idea.languages) {
      var lang_id = await db.rawInsert(
          "Insert into $tableLanguages($languageForeign, $columnLanguageTitle) VALUES(?,?)",
          [idea._id, language]);
      print("inserted $lang_id");
    }
    return idea;
  }

  Future<List<Idea>> getIdeas() async {
    final db = await database;
    List<Idea> ideas = [];
    List<Map<String, dynamic>> results = await db.query(tableIdea);

    for (var item in results) {
      Idea idea = Idea.fromMap(item);
      List<Map> languages = await db.query(tableLanguages, columns: [columnLanguageTitle], where: "$languageForeign = ?", whereArgs: [idea._id]);
      idea.languages =  languages.map((language)=>language['title'].toString()).toList();
      ideas.add(idea);
    }
    return ideas;
  }

  Future<Idea> getIdea(int id) async {
    final db = await database;
    List<Map> ideas =
        await db.query(tableIdea, where: '$ideaId = ?', whereArgs: [id]);
    if (ideas.length > 0) {
      Idea idea = Idea.fromMap(ideas.first);
      List<Map> languages = await db.query(tableLanguages, columns: [columnLanguageTitle], where: "$languageForeign = ?", whereArgs: [id]);
      idea.languages = languages.map((language)=> language['title']).toList();
      return idea;
    }
    return null;
  }

  Future<int> deleteIdea(int id) async {
    final db = await database;
    return await db.delete(tableIdea, where: '$ideaId = ?', whereArgs: [id]);
  }

  Future<int> updateIdea(Idea idea) async {
    final db = await database;
    return db.update(tableIdea, idea.toMap(),
        where: '$ideaId = ?', whereArgs: [idea._id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}