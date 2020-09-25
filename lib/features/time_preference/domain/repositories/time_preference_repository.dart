import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../entities/time_preference.dart';

abstract class TimePreferenceRepository {
  Either<Failure, TimePreference> getPreference();
  Either<Failure, TimePreference> setMorning({@required morning});
  Either<Failure, TimePreference> setNoon({@required noon});
  Either<Failure, TimePreference> setAfternoon({@required afternoon});
  Either<Failure, TimePreference> setNight({@required night});
}
