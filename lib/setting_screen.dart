
import 'package:flutter/material.dart';
import 'package:settings/models/enums.dart';
import 'package:settings/models/settings.dart';
import 'package:settings/models/preference_services.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final PreferenceService _preferenceService = PreferenceService();

  final _username = TextEditingController();
  Gender _selectedGender = Gender.male;
  Set<ProgrammingLanguages> _selectedProgrammingLanguage = {};
  bool _isEmployed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSetting();
  }

  void _getSetting() async {

    final setting = await _preferenceService.getSettings();

    setState(() {
      _username.text = setting.username;
      _selectedGender = setting.gender;
      _selectedProgrammingLanguage = setting.programmingLanguage;
      _isEmployed = setting.isEmployed;

    });

  }

  void _saveSetting(){
      Settings settings = Settings(
          username: _username.text,
          gender: _selectedGender,
          programmingLanguage: _selectedProgrammingLanguage,
          isEmployed: _isEmployed);

      PreferenceService preference = PreferenceService();
      preference.saveSetting(settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextField(
            controller: _username,
            decoration: const InputDecoration(
              labelText: "Username"
            ),
          ),
          const Padding(
            padding:  EdgeInsets.all(8.0),
            child: Text(
              "Select you gender",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RadioListTile(
              title: const Text("Male"),
              value: Gender.male,
              groupValue: _selectedGender,
              onChanged: (newValue){
                setState(() {
                  _selectedGender = newValue!;
                });
              }
          ),
          RadioListTile(
              title: const Text("Female"),
              value: Gender.female,
              groupValue: _selectedGender,
              onChanged: (newValue){
                setState(() {
                  _selectedGender = newValue!;
                });
              }
          ),
          RadioListTile(
              title: const Text("Other"),
              value: Gender.other,
              groupValue: _selectedGender,
              onChanged: (newValue){
                setState(() {
                  _selectedGender = newValue!;
                });
              }
          ),
          CheckboxListTile(
            title: const Text("Java"),
              value: _selectedProgrammingLanguage.contains(ProgrammingLanguages.java),
              onChanged: (_){
                setState(() {
                  _selectedProgrammingLanguage.contains(ProgrammingLanguages.java)?
                      _selectedProgrammingLanguage.remove(ProgrammingLanguages.java):
                      _selectedProgrammingLanguage.add(ProgrammingLanguages.java);
                });
              }),
          CheckboxListTile(
            title: const Text("Dart"),
              value: _selectedProgrammingLanguage.contains(ProgrammingLanguages.dart),
              onChanged: (_){
                setState(() {
                  _selectedProgrammingLanguage.contains(ProgrammingLanguages.dart)?
                      _selectedProgrammingLanguage.remove(ProgrammingLanguages.dart):
                      _selectedProgrammingLanguage.add(ProgrammingLanguages.dart);
                });
              }),
          CheckboxListTile(
            title: const Text("JavaScript"),
              value: _selectedProgrammingLanguage.contains(ProgrammingLanguages.javaScript),
              onChanged: (_){
                setState(() {
                  _selectedProgrammingLanguage.contains(ProgrammingLanguages.javaScript)?
                      _selectedProgrammingLanguage.remove(ProgrammingLanguages.javaScript):
                      _selectedProgrammingLanguage.add(ProgrammingLanguages.javaScript);
                });
              }),
          CheckboxListTile(
            title: const Text("swift"),
              value: _selectedProgrammingLanguage.contains(ProgrammingLanguages.swift),
              onChanged: (_){
                setState(() {
                  _selectedProgrammingLanguage.contains(ProgrammingLanguages.swift)?
                      _selectedProgrammingLanguage.remove(ProgrammingLanguages.swift):
                      _selectedProgrammingLanguage.add(ProgrammingLanguages.swift);
                });
              }),
          SwitchListTile(
            title: const Text("Are you Employed"),
              value: _isEmployed,
              onChanged: (newValue){
                setState(() {
                  _isEmployed = newValue;
                });
              }
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){

              }, child: const Text("Cancel")),
              TextButton(onPressed: _saveSetting, child: const Text("Save Settings")),
            ],
          ),
        ],
      ),
    );
  }
}
