import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/home_app_bar_entity.dart';
import '../repositories/home_app_bar_repository.dart';

class ChangeColorUseCase
    implements UseCases<HomeAppBarEntity, ChangeColorParams> {
  final HomeAppBarRepository repository;

  ChangeColorUseCase({@required this.repository});

  @override
  Either<Failure, HomeAppBarEntity> call(ChangeColorParams params) {
    return repository.changeColor(params.color, params.notes, params.box);
  }
}

class ChangeColorParams extends Equatable {
  final List<Note> notes;
  final Color color;
  final WriteOn box;

  ChangeColorParams({
    @required this.notes,
    @required this.color,
    @required this.box,
  });

  @override
  List<Object> get props => [notes, color, box];
}
