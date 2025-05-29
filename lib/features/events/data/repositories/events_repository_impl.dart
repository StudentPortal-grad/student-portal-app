import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../../../core/utils/service_locator.dart';
import '../../domain/repositories/events_repository.dart';
import '../dto/event_rsvp.dart';
import '../models/event_model.dart';

class EventsRepositoryImpl implements EventsRepository {
  final ApiService apiService;
  final secureStorage = getIt<SecureStorage>();

  EventsRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, List<Event>>> getAllEvents() async {
    try {
      var data = await apiService.get(
        endpoint: ApiEndpoints.events,
      );
      return Right(data['data'].map<Event>((e) => Event.fromJson(e)).toList());
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, Event>> getEventById(String id) async {
    try {
      var data = await apiService.get(
        endpoint: ApiEndpoints.eventID(id),
      );
      return Right(Event.fromJson(data['data']['event']));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, String>> updateEventRSVP(EventRsvpDTO eventRsvpDTO) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.eventRSVP(eventRsvpDTO.eventId),
        data: eventRsvpDTO.toJson(),
      );
      return Right((data['data']['message'] as String? ?? ""));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
