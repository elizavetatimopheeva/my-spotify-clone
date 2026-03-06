import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity song;
  final Function? function;
  const FavoriteButton({super.key, required this.song, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              style: const ButtonStyle(
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(0),
              onPressed: () async{
               await context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                  song.songId,
                );
                if(function !=null){
                  function!();
                }
              },
              icon: Icon(
                song.isFavorite
                    ? Icons.favorite_outlined
                    : Icons.favorite_outline_outlined,
                color: AppColors.darkGrey,
              ),
            );
          }
      
          if (state is FavoriteButtonUpdated) {
            return IconButton(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(0),
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                  song.songId,
                );
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite_outlined
                    : Icons.favorite_outline_outlined,
                color: AppColors.darkGrey,
              ),
            );
          }
      
          return Container();
        },
      ),
    );
  }
}


