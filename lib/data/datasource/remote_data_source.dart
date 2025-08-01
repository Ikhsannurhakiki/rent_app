import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rent_app/data/models/unit_detail_model.dart';
import 'package:rent_app/data/models/unit_model.dart';
import 'package:rent_app/data/response/unit_response.dart';

import '../../common/exception.dart';
import '../response/unit_detail_response.dart';

abstract class RemoteDataSource {
  Future<List<UnitModel>> getUnit();
  Future<UnitDetailModel> getUnitDetail(int unitId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static const BASE_URL = 'https://rentapp.cyou';

  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<UnitModel>> getUnit() async {
    final response = await client.get(Uri.parse('https://rentapp.cyou/units.php'));

    if (response.statusCode == 200) {
      return UnitResponse.fromJson(json.decode(response.body)).list;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UnitDetailModel> getUnitDetail(int unitId) async {
    final response = await client.get(
        Uri.parse('https://rentapp.cyou/getunitdetail.php?unit_id=1'));
    if (response.statusCode == 200) {
      print(response.body);
      return UnitDetailResponse
          .fromJson(json.decode(response.body))
          .detail;
    } else {
      throw ServerException();
    }
  }
}
