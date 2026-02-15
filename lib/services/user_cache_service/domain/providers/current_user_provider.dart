import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/services/user_cache_service/domain/providers/user_cache_provider.dart';

import '../../../../shared/domain/models/user/user_model.dart';

final currentUserProvider=FutureProvider<User?>((ref)async{
  final repository=ref.watch(userLocalRepositoryProvider);
  final eitherType=(await repository.fetchUser() );
  return eitherType.fold((l) => null, (r) => r);
});