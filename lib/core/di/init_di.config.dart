// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:testerx2/core/router/router.dart' as _i878;
import 'package:testerx2/presentation/home/bloc/home/home_bloc.dart' as _i981;
import 'package:testerx2/presentation/profile/admin/bloc/admin/admin_bloc.dart'
    as _i113;
import 'package:testerx2/presentation/profile/bloc/group_list/group_list_bloc.dart'
    as _i971;
import 'package:testerx2/repository/auth/auth_repository.dart' as _i775;
import 'package:testerx2/repository/group/group_repository.dart' as _i288;
import 'package:testerx2/repository/history/history_repository.dart' as _i873;
import 'package:testerx2/repository/sorted_by_test_id/sorted_by_test_id_repository.dart'
    as _i1029;
import 'package:testerx2/repository/storage/storage_repository.dart' as _i625;
import 'package:testerx2/repository/test/test_repository.dart' as _i660;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i660.TestRepository>(() => _i660.TestRepository());
    gh.singleton<_i1029.SortedByTestIdRepository>(
        () => _i1029.SortedByTestIdRepository());
    gh.singleton<_i775.AuthRepository>(() => _i775.AuthRepository());
    gh.singleton<_i288.GroupRepository>(() => _i288.GroupRepository());
    gh.singleton<_i625.StorageRepository>(() => _i625.StorageRepository());
    gh.singleton<_i873.HistoryRepository>(() => _i873.HistoryRepository());
    gh.singleton<_i878.AppRouter>(() => _i878.AppRouter());
    gh.singleton<_i981.HomeBloc>(() => _i981.HomeBloc());
    gh.singleton<_i113.AdminBloc>(() => _i113.AdminBloc());
    gh.singleton<_i971.GroupListBloc>(() => _i971.GroupListBloc());
    return this;
  }
}
