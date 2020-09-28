import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/home_app_bar/data/datasources/home_app_local_data_source.dart';
import 'package:task_hard/features/home_app_bar/data/model/home_app_bar_model.dart';
import 'package:task_hard/features/home_app_bar/data/repositories/home_app_bar_repository_impl.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockLocalDataSource extends Mock implements HomeAppBarLocalDataSource {}

void main() {
  MockLocalDataSource dataSource;
  HomeAppBarRepositoryImpl impl;

  setUp(
    () {
      dataSource = MockLocalDataSource();
      impl = HomeAppBarRepositoryImpl(dataSource: dataSource);
    },
  );
  final selectedNotes = <Note>[];

  final model = HomeAppBarModel.fromList(selectedNotes);

  test(
    'should return HomeAppBarModel when addNote is called',
    () {
      when(dataSource.addNote(any)).thenReturn(model);

      final result = impl.addNote(selectedNotes);

      verify(dataSource.addNote(selectedNotes));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(model));
    },
  );
}
