import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rent_app/data/models/unit_detail_model.dart';
import 'package:rent_app/data/models/unit_model.dart';

import '../../common/exception.dart';
import '../models/unit_type_model.dart';
import '../response/unit_detail_response.dart';

abstract class RemoteDataSource {
  Future<List<UnitTypeModel>> getUnitTypes();

  Future<List<UnitModel>> getUnit();

  Future<UnitDetailModel> getUnitDetail(int unitId);
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

  @override
  Future<List<UnitModel>> getUnit() async {
    final response = await client.get(
      Uri.parse('https://rentapp.cyou/units.php'),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        final List data = jsonBody['data'];
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
      Uri.parse('https://rentapp.cyou/getunitdetail.php?unit_id=$unitId'),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        return UnitDetailResponse.fromJson(json.decode(response.body)).detail;
      } else {
        throw ServerException(jsonBody['message'] ?? 'Unknown server error');
      }
    } else {
      final error = json.decode(response.body);
      throw ServerException(error['message'] ?? 'Something went wrong');
    }
  }
}
