/// A user's access level, stored server-side in `users/{uid}.role` so it
/// can't be spoofed by the client (unlike the old `kIsAdmin` compile-time
/// flag it replaces).
enum UserRole { free, vip, admin }

UserRole userRoleFromName(String? name) => UserRole.values.firstWhere(
      (r) => r.name == name,
      orElse: () => UserRole.free,
    );
