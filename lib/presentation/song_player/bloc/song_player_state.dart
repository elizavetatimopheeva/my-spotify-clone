abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState{}

class SongPlayerLoaded extends SongPlayerState{
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  
  SongPlayerLoaded({
    required this.position,
    required this.duration,
    this.isPlaying = false,
  });
}

class SongPlayerFailure extends SongPlayerState{}