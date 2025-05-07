import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';

/// Watch the [authTokenProvider] to check if the user is logged in.
final authTokenProvider = StateProvider<String?>((ref) => null);

final currentUserProvider = StateProvider<User?>((ref) => null);