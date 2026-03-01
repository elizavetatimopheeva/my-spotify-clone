import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/singin_user_req.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class SigninUseCase implements UseCase<Either,SinginUserReq> {
  @override
  Future<Either<dynamic, dynamic>> call({SinginUserReq? params}) async{
   return sl<AuthRepository>().singin(params!);
  }

}