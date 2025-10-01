import 'package:flutter/cupertino.dart';
import 'package:rent_app/data/entities/owner_detail_entity.dart';
import 'package:rent_app/data/usecase/get_owner_detail.dart';

import '../../common/state_enum.dart';

class OwnerNotifier extends ChangeNotifier {
  late OwnerDetailEntity _detailOwner;

  OwnerDetailEntity get detailOwner => _detailOwner;
  RequestState _detailState = RequestState.Empty;

  RequestState get detailState => _detailState;

  String _message = '';

  String get message => _message;
  final GetOwnerDetail getOwnerDetail;

  OwnerNotifier({required this.getOwnerDetail});

  Future<void> fetchOwnerDetail({
    required int ownerId,
    required String apiKey,
  }) async {
    _detailState = RequestState.Loading;
    notifyListeners();

    final result = await getOwnerDetail.execute(
      ownerId: ownerId,
      apiKey: apiKey,
    );
    result.fold(
      (failure) {
        _message = failure.message;
        _detailState = RequestState.Error;
        notifyListeners();
      },
      (detailOwner) {
        _detailOwner = detailOwner;
        _detailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
