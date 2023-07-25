part of 'theme_cubit.dart';

class ThemeState {
  final bool isSystem;
  final bool isLight;
  ThemeState({
    this.isSystem = false,
    this.isLight = false,
  });

  ThemeState copyWith({
    bool? isSystem,
    bool? isLight,
  }) {
    return ThemeState(
      isSystem: isSystem ?? this.isSystem,
      isLight: isLight ?? this.isLight,
    );
  }
}
