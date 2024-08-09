import 'package:be_people/controllers/user_controller.dart';
import 'package:be_people/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'fetchusers_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchUsers', () {
    test('fetchUsers return a list of users on success', () async {
      final client = MockClient();

      when(client.get(any)).thenAnswer((_) async => http.Response(
          '{"data": [{"id": 1, "email": "george.bluth@reqres.in", "first_name": "George", "last_name": "Bush", "avatar": "https://reqres.in/img/faces/1-image.jpg"}]}',
          200));

      final userController = UserController(client: client);

      final users = await userController.fetchUsers();

      expect(users, isA<List<User>>());
      expect(users.length, 1);
      expect(users[0].id, 1);
      expect(users[0].email, 'george.bluth@reqres.in');
      expect(users[0].firstName, 'George');
      expect(users[0].lastName, 'Bush');
      expect(users[0].avatar, 'https://reqres.in/img/faces/1-image.jpg');
    });

    test('fetchUsers throws an exception on failure', () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://reqres.in/api/users')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final userController = UserController(client: client);
      expect(userController.fetchUsers(), throwsException);
    });
  });
}
