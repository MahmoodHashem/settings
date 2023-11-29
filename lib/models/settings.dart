
import 'enums.dart';

class Settings{

  Settings({required this.username,required this.gender,
            required this.programmingLanguage, required this.isEmployed });

    final String username;
    final Gender gender;
    final Set<ProgrammingLanguages> programmingLanguage;
    final bool isEmployed;

}