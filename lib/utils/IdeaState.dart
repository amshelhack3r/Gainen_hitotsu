import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class IdeaState with ChangeNotifier {
  IdeaState();

  Map<String, dynamic> _formState = {};
  String _ideaName = WordPair
      .random()
      .asPascalCase;
  String _ideaAbout = 'An App About Birds 🐦';
  String _description = "";
  String _users = "0";
  String _category = 'android';
  Set<String> _selectedLanguages = {};



  String get users => _users;

  String get ideaName => _ideaName;

  String get ideaAbout => _ideaAbout;

  String get description => _description;

  Map<String, dynamic> get formState => _formState;

  String get category => _category;

  Set<String> get selectedLanguages => _selectedLanguages;


  set description(String value) {
    _description = value;
    notifyListeners();
  }

  void mapIdea(key, value) {
    _formState[key] = value;
    notifyListeners();
  }
  set formState(Map<String, dynamic> value) {
    _formState = value;
    notifyListeners();
  }

  set ideaName(String name) {
    _ideaName = name;
    notifyListeners();
  }

  set ideaAbout(String value) {
    _ideaAbout = value;
    notifyListeners();
  }

  set language(String language) {
    _selectedLanguages.add(language);
    notifyListeners();
  }

  set category(String value) {
    _category = value;
  notifyListeners();
  }

  set users(String value) {
    _users = value;
    notifyListeners();
  }

  void removeLanguage(String language){
    _selectedLanguages.remove(language);
    notifyListeners();
  }
}