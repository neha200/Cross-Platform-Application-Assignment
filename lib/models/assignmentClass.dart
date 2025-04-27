import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AssignmentClass {
  String? id;
  String name;
  int age;
  String email;

  AssignmentClass({this.id, required this.name, required this.age, this.email = ''});

  factory AssignmentClass.fromParse(ParseObject object) {
    return AssignmentClass(
      id: object.objectId,
      name: object.get<String>('name') ?? '',
      age: object.get<int>('age') ?? 0,
      email : object.get<String>('email') ?? '',
    );
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('assignmentClass');
    if (id != null) parseObject.objectId = id;
    parseObject.set('name', name);
    parseObject.set('age', age);
    parseObject.set('email', email);
    return parseObject;
  }
}
