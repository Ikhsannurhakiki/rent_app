import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rent_app/data/models/unit_detail_model.dart';
import 'package:rent_app/data/models/unit_model.dart';

import '../../common/exception.dart';
import '../models/unit_type_model.dart';
import '../response/unit_detail_response.dart';

abstract class RemoteDataSource {
  Future<List<UnitTypeModel>> getUnitTypes();

  Future<List<UnitModel>> getUnit();

  Future<UnitDetailModel> getUnitDetail(int unitId);

  Future<double> getRoadDistanceInKm(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
    String apiKey,
  );
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static const BASE_URL = 'https://rentapp.cyou';

  final http.Client client;

  RemoteDataSourceImpl({required this.client});

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

  static const String _apiKey = "";

  Future<List<UnitModel>> getUnit() async {
    final response = await client.get(
      Uri.parse('https://rentapp.cyou/unit.php?action=getAll'),
      headers: {
        "x-api-key": _apiKey,
        "Content-Type": "application/json",
      },
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
  Future<UnitDetailModel> getUnitDetail(int unitId) async {
    final response = await client.get(
      Uri.parse('https://rentapp.cyou/unit.php?action=getDetail&id=$unitId'),
      headers: {
        "x-api-key": _apiKey,
        "Content-Type": "application/json",
      },
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
}
