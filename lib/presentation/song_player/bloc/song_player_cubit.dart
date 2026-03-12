import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      if (!isClosed) {
        emit(SongPlayerLoaded(
          position: position,
          duration: songDuration,
        ));
      }
    });

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
      await audioPlayer.setUrl(asset);
      await Future.delayed(const Duration(milliseconds: 100));
      if (songDuration == Duration.zero) {
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
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}