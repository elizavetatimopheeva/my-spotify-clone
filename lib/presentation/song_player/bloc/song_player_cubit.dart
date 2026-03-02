// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

// class SongPlayerCubit extends Cubit<SongPlayerState> {
//   AudioPlayer audioPlayer = AudioPlayer();

//   Duration songDuration = Duration.zero;
//   Duration songPosition = Duration.zero;

//   SongPlayerCubit() : super(SongPlayerLoading()) {
//     audioPlayer.positionStream.listen((position) {
//       songPosition = position;
//       updateSongPlayer();
//     });

//     audioPlayer.durationStream.listen((duration) {
//       songDuration = duration!;
//     });
//   }


//   void updateSongPlayer(){
//     emit(
//       SongPlayerLoaded()
//     );
//   }

//   Future<void> loadSong(String asset) async {
//     try {
//       await audioPlayer.setUrl(asset);
//       emit(SongPlayerLoaded());
//     } catch (e) {
//       emit(SongPlayerFailure());
//     }
//   }

//   void playOrPauseSong() {
//     if (audioPlayer.playing) {
//       audioPlayer.stop();
//     } else {
//       audioPlayer.play();
//     }
//     emit(SongPlayerLoaded());
//   }

//   @override
//   Future<void> close (){
//     audioPlayer.dispose();
//     return super.close();
//   }
// }



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    // Подписываемся на изменения позиции
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      if (!isClosed) {
        emit(SongPlayerLoaded(
          position: position,
          duration: songDuration,
        ));
      }
    });

    // Исправляем обработку duration
    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        if (!isClosed) {
          emit(SongPlayerLoaded(
            position: songPosition,
            duration: duration,
          ));
        }
      }
    });

    // Добавляем обработку состояния плеера
    audioPlayer.playerStateStream.listen((playerState) {
      if (!isClosed && state is SongPlayerLoaded) {
        emit(SongPlayerLoaded(
          position: songPosition,
          duration: songDuration,
          isPlaying: playerState.playing,
        ));
      }
    });
  }

  Future<void> loadSong(String asset) async {
    try {
      emit(SongPlayerLoading());
      
      // Важно: сначала устанавливаем URL
      await audioPlayer.setUrl(asset);
      
      // Ждем немного, чтобы duration успел загрузиться
      // Но не блокируем UI
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Проверяем, загрузилась ли длительность
      if (songDuration == Duration.zero) {
        // Если еще не загрузилась, ждем еще
        await Future.delayed(const Duration(milliseconds: 500));
      }
      
      emit(SongPlayerLoaded(
        position: songPosition,
        duration: songDuration,
      ));
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    // Не эмитим здесь, так как playerStateStream обновит состояние
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}