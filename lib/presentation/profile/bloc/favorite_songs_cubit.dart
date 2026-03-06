
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/get_user_fav_song.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongsList = [];
  Future<void> getFavoriteSongs() async {
    var result = await sl<GetUserFavSongUseCase>().call();

    result.fold(
      (l) {
        emit(FavoriteSongsFailure());
      },
      (favoriteSongs) {
        favoriteSongsList = favoriteSongs;
        emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongsList));
      },
    );
  }

  void removeSong(int index){
    favoriteSongsList.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongsList));

  }
}
