import 'package:dartz/dartz.dart';

abstract class SongsRepository{
  Future <Either> getNewsSongs();
  Future <Either> getPlayList();
  Future <Either> addOrRemoveFavorite(String songId);
  Future <bool> isFavoriteSong(String songId);
  
}