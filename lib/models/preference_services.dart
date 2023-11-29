
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:settings/models/settings.dart';
import 'package:settings/models/enums.dart';

class PreferenceService{

  Future saveSetting(Settings setting) async{

      final preference = await SharedPreferences.getInstance();

      preference.setString("username", setting.username);
      preference.setBool("isEmployed", setting.isEmployed);
      preference.setInt("gender", setting.gender.index);
      preference.setStringList('programmingLanguage',
          setting.programmingLanguage.map((lang) => lang.index.toString()).toList());

     debugPrint("Saved Settings");
  }

  Future<Settings> getSettings() async{
    
    final preferences = await SharedPreferences.getInstance(); 
    
    final username = preferences.getString("username"); 
    final isEmployed = preferences.getBool("isEmployed");
    final gender = Gender.values[preferences.getInt('gender')! ?? 0];
    
    final programmingLanguageIndices = preferences.getStringList('programmingLanguage');

    final programmingLanguage = programmingLanguageIndices?.
    map((stringIndex) => ProgrammingLanguages.values[int.parse(stringIndex)]).toSet();


    return Settings(
        username: username!,
        gender: gender,
        programmingLanguage: programmingLanguage!,
        isEmployed: isEmployed!);

  }
  
}
