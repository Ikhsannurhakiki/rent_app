import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:rent_app/data/models/unit_detail_model.dart';
import 'package:rent_app/data/models/unit_model.dart';

import '../../common/exception.dart';
import '../models/owner_detail_model.dart';
import '../models/unit_type_model.dart';
import '../models/user_model.dart';
import '../response/unit_detail_response.dart';

abstract class RemoteDataSource {
  Future<List<UnitTypeModel>> getUnitTypes();

  Future<List<UnitModel>> getUnit({required String apiKey});

  Future<UnitDetailModel> getUnitDetail({
    required int unitId,
    required String apiKey,
  });

  Future<double> getRoadDistanceInKm(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
    String apiKey,
  );

  Future<UserCredential> registerInFirebase(String email, String password);

  Future<UserModel> registerInBackend({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  });

  Future<void> logout();

  Future<UserModel> getSqlUser({required String uid});

  Future<OwnerDetailModel> getOwnerDetail({
    required int ownerId,
    required String apiKey,
  });
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static const BASE_URL = 'https://rentapp.cyou';

  final http.Client client;
  final FirebaseAuth auth;

  RemoteDataSourceImpl({required this.client, required this.auth});

  @override
  Future<List<UnitTypeModel>> getUnitTypes() async {
    final response = await client.get(
      Uri.parse('https://rentapp.cyou/unittype.php'),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        final List data = jsonBody['data'];
        return data.map((json) => UnitTypeModel.fromJson(json)).toList();
      } else {
        throw ServerException(jsonBody['message'] ?? 'Unknown server error');
      }
    } else {
      final error = json.decode(response.body);
      throw ServerException(error['message'] ?? 'Something went wrong');
    }
  }

  Future<List<UnitModel>> getUnit({required String apiKey}) async {
    final response = await client.get(
      Uri.parse('https://rentapp.cyou/unit.php?action=getAll'),
      headers: {"x-api-key": apiKey, "Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        final List data = jsonBody['data'];
        print(data);
        return data.map((json) => UnitModel.fromJson(json)).toList();
      } else {
        throw ServerException(jsonBody['message'] ?? 'Unknown server error');
      }
    } else {
      final error = json.decode(response.body);
      throw ServerException(error['message'] ?? 'Something went wrong');
    }
  }

  @override
  Future<UnitDetailModel> getUnitDetail({
    required int unitId,
    required String apiKey,
  }) async {
    final response = await client.get(
      Uri.parse('https://rentapp.cyou/unit.php?action=getDetail&id=$unitId'),
      headers: {"x-api-key": apiKey, "Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        print(response.body);
        return UnitDetailResponse.fromJson(json.decode(response.body)).detail;
      } else {
        throw ServerException(jsonBody['message'] ?? 'Unknown server error');
      }
    } else {
      final error = json.decode(response.body);
      throw ServerException(error['message'] ?? 'Something went wrong');
    }
  }

  @override
  Future<double> getRoadDistanceInKm(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
    String apiKey,
  ) async {
    final url = Uri.parse(
      'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat&radiuses=2000',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['features'] != null && data['features'].isNotEmpty) {
        final features = data['features'] as List;
        final firstFeature = features.first as Map<String, dynamic>;

        final properties = firstFeature['properties'] as Map<String, dynamic>;
        final summary = properties['summary'] as Map<String, dynamic>;
        final meters = summary['distance'] as double;
        final kilometers = meters / 1000;

        final formattedString = kilometers.toStringAsFixed(2);
        final formattedDouble = double.parse(formattedString);

        return formattedDouble;
      } else {
        throw ServerException('No route found');
      }
    } else {
      final error = jsonDecode(response.body);
      throw ServerException(error['message'] ?? 'Something went wrong');
    }
  }

  @override
  Future<UserModel> registerInBackend({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    final response = await client.post(
      Uri.parse('https://rentapp.cyou/user.php'),
      body: {
        'action': "register",
        'firebaseuid': uid,
        'full_name': name,
        'email': email,
        'password': password,
        'phone_number': phoneNumber,
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException("Failed to save user to backend");
      }
    } else {
      final error = json.decode(response.body);
      throw ServerException(error['message'] ?? 'Something went wrong');
    }
  }

  @override
  Future<UserCredential> registerInFirebase(
    String email,
    String password,
  ) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<UserModel> getSqlUser({required String uid}) async {
    final response = await client.get(
      Uri.parse(
        'https://rentapp.cyou/user.php',
      ).replace(queryParameters: {'action': 'getUser', 'firebaseuid': uid}),
    );
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      if (jsonBody['status'] == 'success') {
        return UserModel.fromJson(jsonBody['data']);
      } else {
        throw ServerException("Failed to load user from backend");
      }
    } else {
      throw ServerException("Server error ${response.statusCode}");
    }
  }

  Future<OwnerDetailModel> getOwnerDetail({
    required int ownerId,
    required String apiKey,
  }) async {
    final url = Uri.parse(
      "https://rentapp.cyou/owner.php?action=get_owner_detail&owner_id=$ownerId",
    );
    final response = await http.get(
      url,
      headers: {"x-api-key": apiKey, "Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      if (decoded["status"] == "success") {
        return OwnerDetailModel.fromJson(decoded["data"]);
      } else {
        throw Exception(decoded["message"] ?? "Failed to fetch owner detail");
      }
    } else {
      throw Exception("Failed to connect to server (${response.statusCode})");
    }
  }
}
