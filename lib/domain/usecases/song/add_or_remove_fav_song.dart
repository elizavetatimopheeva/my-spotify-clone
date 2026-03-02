import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';

import 'package:spotify/domain/repository/song/song.dart';

import 'package:spotify/service_locator.dart';

class AddOrRemoveFavSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavorite(params!);
  }
}
