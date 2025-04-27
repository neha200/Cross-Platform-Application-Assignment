// /services/parse_service.dart
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/assignmentClass.dart';

class ParseService {
  static Future<bool> signUp(String name, String password, String email) async {
    // Step 1: Sign up user for authentication
    final user = ParseUser.createUser(name, password, email);

    final signUpResponse = await user.signUp();

    if (signUpResponse.success && signUpResponse.result != null) {
      print('User signed up successfully');

      // Get session token
      final sessionToken = (signUpResponse.result as ParseUser).sessionToken;

      if (sessionToken == null) {
        print('Session token is null');
        return false;
      }

      // Step 2: Save to custom assignmentClass
      final customUser = ParseObject('assignmentClass')
        ..set('name', name)
        ..set('email', email)
        ..set('password', password);

      // 👇 Temporarily set sessionId for next request
      ParseCoreData().sessionId = sessionToken;

      final saveResponse = await customUser.save();

      if (saveResponse.success) {
        print('User data saved to assignmentClass successfully!');
        return true;
      } else {
        print('Error saving user data to assignmentClass: ${saveResponse.error?.message}');
        return false;
      }
    } else {
      print('Sign-up failed: ${signUpResponse.error?.message}');
      return false;
    } // Return the user object if saving was successful
  }

  static Future<ParseResponse> login(String name, String password) async {
    final user = ParseUser(name, password, null);
    return await user.login();
  }

  static Future<void> logout() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    await user?.logout();
  }

  static Future<List<AssignmentClass>> getRecords() async {
    final query = QueryBuilder(ParseObject('assignmentClass'));
    final response = await query.query();
    if (response.success && response.results != null) {
      return (response.results as List<ParseObject>)
          .map((e) => AssignmentClass.fromParse(e))
          .toList();
    }
    return [];
  }

  static Future<void> createRecord(String name, int age, String email) async {
    final record = AssignmentClass(name: name, age: age, email: email);
    await record.toParseObject().save();
  }

  static Future<void> updateRecord(String id, String name, int age, String email) async {
    final record = AssignmentClass(id: id, name: name, age: age, email: email);
    await record.toParseObject().save();
  }

  static Future<void> deleteRecord(String id) async {
    final object = ParseObject('assignmentClass')..objectId = id;
    await object.delete();
  }
}
