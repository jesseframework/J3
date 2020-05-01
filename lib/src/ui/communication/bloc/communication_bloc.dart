import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:j3enterprise/src/database/crud/communication/communication_setup_crud.dart';
import 'package:j3enterprise/src/database/moor_database.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

part 'communication_event.dart';
part 'communication_state.dart';

class CommunicationBloc extends Bloc<CommunicationEvent, CommunicationState> {
  CommunicationDao communicationDao;
  List<CommunicationData> communicationData;
  final String communicationType;
  var db;

  CommunicationBloc({this.communicationType}) {
    db = AppDatabase();
    communicationDao = CommunicationDao(db);
  }

  @override
  CommunicationState get initialState => CommunicationInitial();

  @override
  Stream<CommunicationState> mapEventToState(
    CommunicationEvent event,
  ) async* {
    if (event is SaveCommunicationButtonPressed) {
      // set state as loading
      yield CommunicationInserting();
      // save data to db
      await communicationDao.insertCommunnication(event.data);
      // set the success state
      yield CommunicationSuccess();
    }

    if (event is OnFormLoadGetSaveCommunication) {
      yield CommunicationLoading();

      var viewCommunicationDataByType = await communicationDao
          .getCommunicationDataByType(event.communicationType);

      var _viewCommunicationDataByType = viewCommunicationDataByType.length > 0;
      var data =
          _viewCommunicationDataByType ? viewCommunicationDataByType : null;

      // set the success state
      yield CommunicationLoadSuccess(data: data);
    }
  }
}
